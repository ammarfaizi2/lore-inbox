Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265776AbUFDMs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265776AbUFDMs1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 08:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265779AbUFDMs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 08:48:27 -0400
Received: from gprs214-121.eurotel.cz ([160.218.214.121]:2689 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265776AbUFDMsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 08:48:20 -0400
Date: Fri, 4 Jun 2004 14:48:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: Christoph Hellwig <hch@ucw.cz>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lowered priority of "too many keys" message in atkbd
Message-ID: <20040604124811.GC11950@elf.ucw.cz>
References: <20040530083126.GA30916@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040530083126.GA30916@lst.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch is from the Debian kernel package and I think it's valid
> because this error doesn't cause any kind of malfunction of the
> system.

Except perhaps dropped key?

When keypress is lost, I like to know if my fingers are to blame,
keyboard hardware is to blame, or keyboard is misdesigned.
								Pavel

> --- linux/drivers/input/keyboard/atkbd.c	2004-04-05 19:49:28.000000000 +1000
> +++ linux/drivers/input/keyboard/atkbd.c	2004-04-06 19:55:38.000000000 +1000
> @@ -284,7 +284,7 @@
>  			atkbd_report_key(&atkbd->dev, regs, KEY_HANJA, 3);
>  			goto out;
>  		case ATKBD_RET_ERR:
> -			printk(KERN_WARNING "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
> +			printk(KERN_DEBUG "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
>  			goto out;
>  	}
>  


-- 
934a471f20d6580d5aad759bf0d97ddc
