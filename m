Return-Path: <linux-kernel-owner+w=401wt.eu-S1030262AbXADXS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbXADXS6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 18:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbXADXS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 18:18:58 -0500
Received: from smtp.osdl.org ([65.172.181.24]:35393 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030262AbXADXS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 18:18:57 -0500
Date: Thu, 4 Jan 2007 15:18:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, v4l-dvb-maintainer@linuxtv.org
Subject: Re: [PATCH] Fix __ucmpdi2 in v4l2_norm_to_name()
Message-Id: <20070104151837.1a878a20.akpm@osdl.org>
In-Reply-To: <1167951548.12012.55.camel@praia>
References: <1167909014.20853.8.camel@localhost.localdomain>
	<20070104144825.68fec948.akpm@osdl.org>
	<1167951548.12012.55.camel@praia>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jan 2007 20:59:08 -0200
Mauro Carvalho Chehab <mchehab@infradead.org> wrote:

> > The largest value we use here is 0x02000000.  Perhaps v4l2_std_id shouldn't
> > be 64-bit?
> Too late to change it to 32 bits. It is at V4L2 userspace API since
> kernel 2.6.0.

You could perhaps make it 32-bit internally, and still 64-bit on the
kernel<->userspace boundary.   64-bit quantities are expensive..

> We can, however use this approach as a workaround, with
> the proper documentation. I'll handle it after I return from vacations
> next week.

Thanks.
