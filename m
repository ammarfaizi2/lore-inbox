Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbTIYSry (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTIYSry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:47:54 -0400
Received: from smtp7.hy.skanova.net ([195.67.199.140]:9715 "EHLO
	smtp7.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261833AbTIYSrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:47:16 -0400
To: Ani Joshi <ajoshi@unixbox.com>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org
Subject: Re: Radeon FB in 2.6.0-test4 fails for me
References: <16202.57600.498532.587264@wombat.chubb.wattle.id.au>
	<Pine.BSF.4.50.0308261102240.15539-200000@shell.unixbox.com>
From: Peter Osterlund <petero2@telia.com>
Date: 25 Sep 2003 20:46:21 +0200
In-Reply-To: <Pine.BSF.4.50.0308261102240.15539-200000@shell.unixbox.com>
Message-ID: <m28yocg0zm.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ani Joshi <ajoshi@unixbox.com> writes:

> try the attatched patch (its against test4).

Thanks, this patch makes the frame buffer usable on my computer. I
suggest you send it to Linus.

> On Tue, 26 Aug 2003, Peter Chubb wrote:
> 
> >
> > Hi,
> > 	On a Clevo laptop with a Radeon Mobility M7 LW (AGP), enabling
> > 	the Radeon frame buffer results in an unusable LCD display (as
> > 	if the horizontal and/or vertical sync were incorrect -- lots
> > 	of skewed diagonal lines)
> 
> diff -uNr linux-2.6.0-test4.orig/drivers/video/radeonfb.c linux-2.6.0-test4/drivers/video/radeonfb.c
> --- linux-2.6.0-test4.orig/drivers/video/radeonfb.c	2003-08-22 17:01:33.000000000 -0700
> +++ linux-2.6.0-test4/drivers/video/radeonfb.c	2003-08-26 10:48:03.000000000 -0700
> @@ -2090,7 +2090,7 @@
>  	
>  	}
>  	/* Update fix */
> -        info->fix.line_length = rinfo->pitch*64;
> +        info->fix.line_length = mode->xres_virtual*(mode->bits_per_pixel/8);
>          info->fix.visual = rinfo->depth == 8 ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
>  
>  #ifdef CONFIG_BOOTX_TEXT

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
