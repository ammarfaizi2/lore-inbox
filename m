Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbSLTSIk>; Fri, 20 Dec 2002 13:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbSLTSIk>; Fri, 20 Dec 2002 13:08:40 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:62724 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263321AbSLTSIi>; Fri, 20 Dec 2002 13:08:38 -0500
Date: Fri, 20 Dec 2002 18:16:37 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Gergely Nagy <algernon@bonehunter.rulez.org>
cc: linux-fbdev-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH][TRIVIAL] drivers/video/tdfxfb.c
 compile failure (Linux 2.5.52)
In-Reply-To: <83fzstnas3.wl@iluvatar.ath.cx>
Message-ID: <Pine.LNX.4.44.0212201816140.6471-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you. I have other changes as well coming for this driver.


> 
> drivers/video/tdfxfb.c does not compile, because banshee_wait_idle()
> is used before declaration. A simple fix follows:
> 
> --- linux-2.5.52/drivers/video/tdfxfb.c.old	2002-12-19 18:55:03.000000000 +0100
> +++ linux-2.5.52/drivers/video/tdfxfb.c	2002-12-19 18:56:25.000000000 +0100
> @@ -166,6 +166,7 @@
>  static void tdfxfb_copyarea(struct fb_info *info, struct fb_copyarea *area);  
>  static void tdfxfb_imageblit(struct fb_info *info, struct fb_image *image); 
>  static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor);
> +static inline void banshee_wait_idle(struct fb_info *info);
>  
>  static struct fb_ops tdfxfb_ops = {
>  	.owner		= THIS_MODULE,
> 
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by: Geek Gift Procrastinating?
> Get the perfect geek gift now!  Before the Holidays pass you by.
> T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

