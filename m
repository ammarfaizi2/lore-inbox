Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbTAEUap>; Sun, 5 Jan 2003 15:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265085AbTAEUap>; Sun, 5 Jan 2003 15:30:45 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:23558 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265095AbTAEUao>; Sun, 5 Jan 2003 15:30:44 -0500
Date: Sun, 5 Jan 2003 20:39:16 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] Logo crash
In-Reply-To: <Pine.GSO.4.21.0301051744260.10559-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.44.0301052039040.24903-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The local variable palette_cmap.transp is not initialized, so it can contain
> garbage, causing a crash during logo drawing.
> 
> --- linux-2.5.54/drivers/video/fbmem.c	Thu Jan  2 12:54:58 2003
> +++ linux-m68k-2.5.54/drivers/video/fbmem.c	Sun Jan  5 17:22:57 2003
> @@ -386,6 +386,7 @@
>  	palette_cmap.red = palette_red;
>  	palette_cmap.green = palette_green;
>  	palette_cmap.blue = palette_blue;
> +	palette_cmap.transp = 0;
>  
>  	for (i = 0; i < LINUX_LOGO_COLORS; i += n) {
>  		n = LINUX_LOGO_COLORS - i;

Applied.


