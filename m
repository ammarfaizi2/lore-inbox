Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267191AbSLKPuP>; Wed, 11 Dec 2002 10:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267193AbSLKPuO>; Wed, 11 Dec 2002 10:50:14 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:12971 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S267191AbSLKPuI>; Wed, 11 Dec 2002 10:50:08 -0500
Message-ID: <6561098.1039621998327.JavaMail.nobody@web55.us.oracle.com>
Date: Wed, 11 Dec 2002 07:53:18 -0800 (PST)
From: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
To: jt@hpl.hp.com
Subject: Re: module-init-tools 0.9.3 -- "missing" issue
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrhiles wrote:
>
> Rusty Russell wrote :
> > In message <3DF67878.6090703@oracle.com> you write:
> > >   to modprobe vfat - but not the full irda stack, I'll report this
> > >   separately to Jean) _and_ on 2.4.20 (modular IrDA and PPP are
> > 
> > I'd appreciate receiving a copy of that irda report.  It's probably
> > not Jean's fault.
>      I've just managed to load and run Linux-IrDA on 2.5.51, and
> apart from a few warning (see my other e-mail) it was working. I even
> tested PPP over IrCOMM. But I didn't check smc-ircc.
>      So, this one might be *mine* ;-)

Yep, it's smc-ircc :)

Dec 10 22:57:36 dolphin kernel: IrCOMM protocol (Dag Brattli)
Dec 10 22:57:36 dolphin irattach: executing: '/sbin/modprobe irda0'
Dec 10 22:57:36 dolphin kernel: found SMC SuperIO Chip (devid=0x09 rev=08 base=0x03f0): FDC37N958FR
Dec 10 22:57:36 dolphin kernel: SMC IrDA Controller found
Dec 10 22:57:36 dolphin kernel:  IrCC version 1.1, firport 0x290, sirport 0x3e8 dma=3, irq=4
Dec 10 22:57:36 dolphin irattach: + FATAL: Error inserting smc_ircc
(/lib/modules/2.5.51/kernel/smc-ircc.ko): No such device
Dec 10 22:57:36 dolphin irattach: Trying to load module irda0 exited with status 1
Dec 10 22:57:36 dolphin irattach: executing: 'echo 1 >
/proc/sys/net/irda/discovery'
Dec 10 22:57:36 dolphin irattach: Starting device irda0
Dec 10 22:57:36 dolphin kernel: Module irda cannot be unloaded due to unsafe usage in net/irda/af_irda.c:1146

Should I give up on it and go for Daniele's smsc-ircc2 ? I confess I hadn't
 used 2.5.xx for a couple of weeks awaiting for some form of stabilization
 of the new module code (don't blame me - I can only, ahem, "test" on
 my work laptop), and I had forgot about smsc-ircc2.

Since it seems someone could make some of the modular stuff work
 I'm back in the game :)

--alessandro
