Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWEZNb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWEZNb4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 09:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWEZNb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 09:31:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12426 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750730AbWEZNbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 09:31:55 -0400
Subject: Re: trivial videodev2.h patch
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Christian Kujau <evil@g-house.de>
Cc: David Mosberger-Tang <David.Mosberger@acm.org>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.NEB.4.64.0605251100500.7762@vaio.testbed.de>
References: <ed5aea430605242114g1e51e7e9nb124de50dbbf1e40@mail.gmail.com>
	 <Pine.NEB.4.64.0605251100500.7762@vaio.testbed.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 26 May 2006 10:31:47 -0300
Message-Id: <1148650307.4276.48.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1-2mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Em Qui, 2006-05-25 às 11:03 +0100, Christian Kujau escreveu:
> On Wed, 24 May 2006, David Mosberger-Tang wrote:
> > linux/videodev2.h uses types such as __u8 but it fails to include
> > <linux/types.h>.  Within the kernel, that's not a problem because
> > <linux/time.h> already includes <linux/types.h>.  However, there are
> > user apps that try to include videodev2.h (e.g., ekiga) and at least
> 
> userspace apps should (must?) not include kernel headers, AFAIK.
> there is lots of discussion regarding this in the lkml archives...
In fact, this videodev2.h header is meant to describe the public API for
V4L2. The current version have several kernel-specific stuff (under
__KERNEL define), but we are already working on cleaning those stuff. 

Currently, on V4L, all kernel-specific stuff are under include/media,
while the public stuff are under include/linux. 
> 
> Christian.
Cheers, 
Mauro.

