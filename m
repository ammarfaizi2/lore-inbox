Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315204AbSFIVEo>; Sun, 9 Jun 2002 17:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSFIVEn>; Sun, 9 Jun 2002 17:04:43 -0400
Received: from mail.libertysurf.net ([213.36.80.91]:4385 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S315204AbSFIVEm>; Sun, 9 Jun 2002 17:04:42 -0400
Date: Sun, 9 Jun 2002 23:03:56 +0200 (CEST)
From: Rui Sousa <rui.sousa@laposte.net>
X-X-Sender: rsousa@localhost.localdomain
To: Thunder from the hill <thunder@ngforever.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: About new list commands and emu10k1
In-Reply-To: <Pine.LNX.4.44.0206091315290.8715-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0206092301550.9249-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jun 2002, Thunder from the hill wrote:


> Hi,
> 
> I couldn't reach the emu10k1 guys for some obscure reason.

The maintainer file for OSS emu10k1 needs to be updated (as well as the 
driver)... However _this_ emu10k1 driver is from ALSA.

Rui Sousa

> I had a patch
> which sounded like this:
> 
> --- linus-2.5/sound/pci/emu10k1/memory.c	Sun Jun  9 04:18:03 2002
> +++ thunder-2.5/sound/pci/emu10k1/memory.c	Sun Jun  9 07:47:37 2002
> @@ -259,8 +259,7 @@
>  	spin_lock_irqsave(&emu->memblk_lock, flags);
>  	if (blk->mapped_page >= 0) {
>  		/* update order link */
> -		list_del(&blk->mapped_order_link);
> -		list_add_tail(&blk->mapped_order_link, &emu->mapped_order_link_head);
> +		list_move_tail(&blk->mapped_order_link, &emu->mapped_order_link_head);
>  		spin_unlock_irqrestore(&emu->memblk_lock, flags);
>  		return 0;
>  	}
> 
> Regards,
> Thunder
> 

