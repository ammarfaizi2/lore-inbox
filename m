Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267359AbSLKX3a>; Wed, 11 Dec 2002 18:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267360AbSLKX3a>; Wed, 11 Dec 2002 18:29:30 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:31961 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267359AbSLKX3Z>;
	Wed, 11 Dec 2002 18:29:25 -0500
Date: Wed, 11 Dec 2002 15:37:08 -0800
To: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: module-init-tools 0.9.3 -- "missing" issue
Message-ID: <20021211233708.GA13208@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <6561098.1039621998327.JavaMail.nobody@web55.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6561098.1039621998327.JavaMail.nobody@web55.us.oracle.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 07:53:18AM -0800, ALESSANDRO.SUARDI wrote:
> 
> Yep, it's smc-ircc :)
> 
> Dec 10 22:57:36 dolphin kernel: IrCOMM protocol (Dag Brattli)
> Dec 10 22:57:36 dolphin irattach: executing: '/sbin/modprobe irda0'
> Dec 10 22:57:36 dolphin kernel: found SMC SuperIO Chip (devid=0x09 rev=08 base=0x03f0): FDC37N958FR
> Dec 10 22:57:36 dolphin kernel: SMC IrDA Controller found
> Dec 10 22:57:36 dolphin kernel:  IrCC version 1.1, firport 0x290, sirport 0x3e8 dma=3, irq=4
> Dec 10 22:57:36 dolphin irattach: + FATAL: Error inserting smc_ircc
> (/lib/modules/2.5.51/kernel/smc-ircc.ko): No such device
> Dec 10 22:57:36 dolphin irattach: Trying to load module irda0 exited with status 1
> Dec 10 22:57:36 dolphin irattach: executing: 'echo 1 >
> /proc/sys/net/irda/discovery'
> Dec 10 22:57:36 dolphin irattach: Starting device irda0
> Dec 10 22:57:36 dolphin kernel: Module irda cannot be unloaded due to unsafe usage in net/irda/af_irda.c:1146
> 
> Should I give up on it and go for Daniele's smsc-ircc2 ? I confess I hadn't
>  used 2.5.xx for a couple of weeks awaiting for some form of stabilization
>  of the new module code (don't blame me - I can only, ahem, "test" on
>  my work laptop), and I had forgot about smsc-ircc2.
> 
> Since it seems someone could make some of the modular stuff work
>  I'm back in the game :)
> 
> --alessandro

	Hum... Looks like a weird interaction between smc-ircc and
irport, or allocation failure. Please activate IrDA debug, set it to
level 1 (echo 1 >> /proc/sys/net/irda/debug) and send the new kernel
log.
	Thanks...

	Jean
