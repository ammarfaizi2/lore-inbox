Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265944AbUGAPpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265944AbUGAPpr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 11:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbUGAPpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 11:45:47 -0400
Received: from [194.243.27.136] ([194.243.27.136]:1038 "HELO
	venere.pandoraonline.it") by vger.kernel.org with SMTP
	id S265944AbUGAPpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 11:45:45 -0400
X-Qmail-Scanner-Mail-From: devel@integra-sc.it via venere.pandoraonline.it
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.22 (Clear:RC:1(213.140.22.76):. Processed in 0.052621 secs)
Date: Thu, 1 Jul 2004 17:49:55 +0200
From: Devel <devel@integra-sc.it>
To: linux-kernel@vger.kernel.org
Subject: Re: Fw: bttv error: vmalloc_32(8519680) failed
Message-Id: <20040701174955.46c63ffe.devel@integra-sc.it>
In-Reply-To: <20040630183711.GA5064@bytesex>
References: <20040630102732.04f08d5a.akpm@osdl.org>
	<20040630183711.GA5064@bytesex>
Organization: Integra Solutions
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Thanks for your reply, i'm tring the 2.4.26 kernel with  patch-2.4.26-kraxel.gz and i haven't error.
My IEI video grabber have the watchdog also do you think it work with bttv driver?
Saluti Carlo!

Il Wed, 30 Jun 2004 20:37:11 +0200
Gerd Knorr <kraxel@bytesex.org> scrisse:

> On Wed, Jun 30, 2004 at 10:27:32AM -0700, Andrew Morton wrote:
> > 
> > Begin forwarded message:
> > 
> > Date: Wed, 30 Jun 2004 11:51:21 +0200
> > From: Devel <devel@integra-sc.it>
> > To: linux-kernel@vger.kernel.org
> > Subject: bttv error: vmalloc_32(8519680) failed
> > 
> > 
> > Hi all, on my AMD XP+3000 with kernel 2.4.22 and bttv driver ver.
> > 0.7.107 i have 16 devices video grabber /dev/video0-->/dev/video15. If
> > i start programs that load images from the device /dev/video14 and
> > /dev/video15 i receive this error: bttv: vmalloc_32(8519680) failed
> 
> Looks like the machine runs out of vmalloc address space when using all
> devices at the same time ...
> 
> with gbuffers + gbufsize insmod options it is possible to adjust the
> amount of vmalloc memory used per device.
> 
> The other option is to use bttv 0.9.x which doesn't use vmalloc any
> more.  Making that one work with 2.4.22 isn't trivial through, easiest
> is to use either 2.6 (as-is) or a more recent 2.4.x kernel + patches
> from http://dl.bytesex.org/patches/
> 
>   Gerd
> 
> -- 
> return -ENOSIG;
> 
