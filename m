Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288051AbSBDBJn>; Sun, 3 Feb 2002 20:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288058AbSBDBJe>; Sun, 3 Feb 2002 20:09:34 -0500
Received: from p0015.as-l042.contactel.cz ([194.108.237.15]:5504 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S288051AbSBDBJV>;
	Sun, 3 Feb 2002 20:09:21 -0500
Date: Mon, 4 Feb 2002 02:08:54 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Denis Zaitsev <zzz@cd-club.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] matroxfb_base.c - a little fix
Message-ID: <20020204010854.GC2572@ppc.vc.cvut.cz>
In-Reply-To: <20020204060107.A18956@zzz.zzz.zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020204060107.A18956@zzz.zzz.zzz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2002 at 06:01:07AM +0500, Denis Zaitsev wrote:
> So, below is the little fix.  It's self-explanatory.  Matrox's fb
> can't be compiled without it.  Petr, please, apply it.

Thanks. I already tried to push updated matroxfb to both Marcello
and Linus, but only Alan picked it... matroxfb_crtc2.c needs
simillar fix, BTW.

> --- drivers/video/matrox/matroxfb_base.c.orig	Mon Feb  4 05:11:15 2002
> +++ drivers/video/matrox/matroxfb_base.c	Mon Feb  4 05:16:05 2002
> @@ -1789,7 +1789,7 @@
>  
>  	strcpy(ACCESS_FBINFO(fbcon.modename), "MATROX VGA");
>  	ACCESS_FBINFO(fbcon.changevar) = NULL;
> -	ACCESS_FBINFO(fbcon.node) = -1;
> +	ACCESS_FBINFO(fbcon.node.value) = -1;

No,     ACCESS_FBINFO(fbcon.node) = B_FREE;
or                                = NODEV; 

>  	ACCESS_FBINFO(fbcon.fbops) = &matroxfb_ops;
>  	ACCESS_FBINFO(fbcon.disp) = d;
>  	ACCESS_FBINFO(fbcon.switch_con) = &matroxfb_switch;

							Petr Vandrovec
							vandrove@vc.cvut.cz

