Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262483AbTCMRLt>; Thu, 13 Mar 2003 12:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262485AbTCMRLt>; Thu, 13 Mar 2003 12:11:49 -0500
Received: from ns.suse.de ([213.95.15.193]:45326 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262483AbTCMRLs>;
	Thu, 13 Mar 2003 12:11:48 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add prink KERN_* suffixes
X-Yow: Hey, wait a minute!!  I want a divorce!!..  you're not Clint
 Eastwood!!
From: Andreas Schwab <schwab@suse.de>
Date: Thu, 13 Mar 2003 18:22:33 +0100
In-Reply-To: <20030313164157.GB6435@renditai.milesteg.arr> (Daniele
 Venzano's message of "Thu, 13 Mar 2003 17:41:57 +0100")
Message-ID: <jellzji3l2.fsf@sykes.suse.de>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.3.50
References: <20030313164157.GB6435@renditai.milesteg.arr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniele Venzano <webvenza@libero.it> writes:

|> diff -urN -X /home/venza/kernel/dontdiff linux-2.5.64/drivers/net/3c509.c linux-2.5.64-work/drivers/net/3c509.c
|> --- linux-2.5.64/drivers/net/3c509.c	2003-03-06 11:41:18.000000000 +0100
|> +++ linux-2.5.64-work/drivers/net/3c509.c	2003-03-13 12:28:39.000000000 +0100
|> @@ -316,14 +316,14 @@
|>  
|>  	{
|>  		const char *if_names[] = {"10baseT", "AUI", "undefined", "BNC"};
|> -		printk("%s: 3c5x9 at %#3.3lx, %s port, address ",
|> +		printk(KERN_INFO "%s: 3c5x9 at %#3.3lx, %s port, address ",
|>  			dev->name, dev->base_addr, if_names[(dev->if_port & 0x03)]);
|>  	}
|>  
|>  	/* Read in the station address. */
|>  	for (i = 0; i < 6; i++)
|> -		printk(" %2.2x", dev->dev_addr[i]);
|> -	printk(", IRQ %d.\n", dev->irq);
|> +		printk(KERN_INFO " %2.2x", dev->dev_addr[i]);
|> +	printk(KERN_INFO ", IRQ %d.\n", dev->irq);

This is wrong, a KERN_* prefix is only recognized after a newline.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
