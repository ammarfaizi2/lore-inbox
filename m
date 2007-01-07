Return-Path: <linux-kernel-owner+w=401wt.eu-S932504AbXAGLpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbXAGLpI (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 06:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbXAGLpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 06:45:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47800 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932504AbXAGLpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 06:45:06 -0500
Subject: Re: [PATCH] Fix __ucmpdi2 in v4l2_norm_to_name()
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, v4l-dvb-maintainer@linuxtv.org
In-Reply-To: <20070104151837.1a878a20.akpm@osdl.org>
References: <1167909014.20853.8.camel@localhost.localdomain>
	 <20070104144825.68fec948.akpm@osdl.org> <1167951548.12012.55.camel@praia>
	 <20070104151837.1a878a20.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 07 Jan 2007 09:44:40 -0200
Message-Id: <1168170280.27419.69.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qui, 2007-01-04 às 15:18 -0800, Andrew Morton escreveu:
> On Thu, 04 Jan 2007 20:59:08 -0200
> Mauro Carvalho Chehab <mchehab@infradead.org> wrote:
> 
> > > The largest value we use here is 0x02000000.  Perhaps v4l2_std_id shouldn't
> > > be 64-bit?
> > Too late to change it to 32 bits. It is at V4L2 userspace API since
> > kernel 2.6.0.
> 
> You could perhaps make it 32-bit internally, and still 64-bit on the
> kernel<->userspace boundary.   64-bit quantities are expensive..
Hmm... there are some discussions currently on v4l ML about the need to
add some standards to support some digital streams, like those used on
webcams. Depending on the result of those discussions, we can need to
use more bits. So, I think it is not worth right now to replace video
std on every place it occurs.

I'm to just do the fix at v4l2-common.c.
> 
> > We can, however use this approach as a workaround, with
> > the proper documentation. I'll handle it after I return from vacations
> > next week.
Ok, I've wrote such patch. I should send today or tomorrow to Linus,
together with other patches.
> 
> Thanks.
Cheers, 
Mauro.

