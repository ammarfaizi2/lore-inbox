Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284929AbRLZUyg>; Wed, 26 Dec 2001 15:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284924AbRLZUy0>; Wed, 26 Dec 2001 15:54:26 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:38646 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S284899AbRLZUyQ>;
	Wed, 26 Dec 2001 15:54:16 -0500
Date: Wed, 26 Dec 2001 13:53:38 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17: Dell Laptop extra buttons patch (fwd)
Message-ID: <20011226135338.B782@lynx.no>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0112261711200.9973-200000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.21.0112261711200.9973-200000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Wed, Dec 26, 2001 at 05:11:53PM -0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 26, 2001  17:11 -0200, Marcelo Tosatti wrote:
> Could someone with Dell laptops test this for me ?

I don't have a Dell laptop, but AFAIK in the past patches like this have
been rejected by Andries Brouwer (I think) because it is possible to do
this from user space with key mapping tools like setkeycodes, xkeycaps,
or xmodmap.

Cheers, Andreas
> ---------- Forwarded message ----------
> From: Alan Ford <alan@whirlnet.co.uk>
> 
> Would you consider adding this patch to the next kernel release? I've been
> using it for a while, and since there is now the Dell laptop module for 
> extra BIOS features available in the kernel it seems this patch could be 
> appropriate and useful to include. It adds keycodes for the four shortcut 
> buttons that are provided on Dell Inspiron laptops.
> 
> Regards,
> Alan
> -- 
> Alan Ford * alan@whirlnet.co.uk 

> --- linux/drivers/char/pc_keyb.c.old	Wed Dec 26 19:06:21 2001
> +++ linux/drivers/char/pc_keyb.c	Wed Dec 26 19:08:13 2001
> @@ -228,9 +228,17 @@
>  #define E0_MSLW	125
>  #define E0_MSRW	126
>  #define E0_MSTM	127
> +/*
> + * Dell Inspiron Laptop Keyboard has four shortcut buttons
> + * e0 01 - e0 04  [alan@whirlnet.co.uk]
> + */
> +#define E0_DELL1 121
> +#define E0_DELL2 122
> +#define E0_DELL3 123
> +#define E0_DELL4 124
>  
>  static unsigned char e0_keys[128] = {
> -  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x00-0x07 */
> +  0, E0_DELL1, E0_DELL2, E0_DELL3, E0_DELL4, 0, 0, 0, /* 0x00-0x07 */
>    0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x08-0x0f */
>    0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x10-0x17 */
>    0, 0, 0, 0, E0_KPENTER, E0_RCTRL, 0, 0,	      /* 0x18-0x1f */
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

