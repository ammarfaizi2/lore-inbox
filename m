Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVHDEvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVHDEvA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 00:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVHDEtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 00:49:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15292 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261716AbVHDErF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 00:47:05 -0400
Date: Wed, 3 Aug 2005 21:45:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: greg@kroah.com, 7eggert@gmx.de, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.6.13-rc5]  V4L: OOPS fix for BTTV on bad
 behaviored PCI chipsets
Message-Id: <20050803214537.16b753f2.akpm@osdl.org>
In-Reply-To: <1123126493.8274.51.camel@localhost>
References: <1123126493.8274.51.camel@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab@brturbo.com.br> wrote:
>
> --- linux-2.6.13/drivers/media/video/bttv-driver.c	2005-08-03 18:25:55.000000000 -0300
>  +++ linux/drivers/media/video/bttv-driver.c	2005-08-03 22:19:44.000000000 -0300
>  @@ -1,5 +1,5 @@
>   /*
>  -    $Id: bttv-driver.c,v 1.45 2005/07/20 19:43:24 mkrufky Exp $
>  +    $Id: bttv-driver.c,v 1.52 2005/08/04 00:55:16 mchehab Exp $
>   
>       bttv - Bt848 frame grabber driver
>   
>  @@ -80,6 +80,7 @@
>   static unsigned int uv_ratio    = 50;
>   static unsigned int full_luma_range = 0;
>   static unsigned int coring      = 0;
>  +extern int no_overlay;

umm, OK.  Could you please send a fixup patch sometime which 

a) renames the now-global no_overlay to something more subsystem-specific and

b) move its declaration out of .c and into .h?

Thanks.
