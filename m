Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbSLHMWy>; Sun, 8 Dec 2002 07:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265413AbSLHMWy>; Sun, 8 Dec 2002 07:22:54 -0500
Received: from mail.hometree.net ([212.34.181.120]:23480 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S265409AbSLHMWw>; Sun, 8 Dec 2002 07:22:52 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Oops with 3c59x module (3com 3c595 NIC)
Date: Sun, 8 Dec 2002 12:30:32 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <asve18$2i0$1@forge.intermeta.de>
References: <20021207164300.2a35f18d.mjr318@psu.edu> <3DF2738A.2447599@digeo.com> <3DF28151.40706@pobox.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1039350632 11723 212.34.181.4 (8 Dec 2002 12:30:32 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sun, 8 Dec 2002 12:30:32 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

>pci-skeleton.c and several of Don's drivers actually do do something 
>else on TxUnderrun, twiddle DMA burst settings:

>         if ((intr_status & TxUnderrun)
>                 && (np->tx_config & TxThresholdField) != 
>TxThresholdField) {
>                 long ioaddr = dev->base_addr;
>                 np->tx_config += TxThresholdInc;
>                 writel(np->tx_config, ioaddr + TxMode);
>                 np->stats.tx_fifo_errors++;
>         }

>I wonder how feasible it is to do that on 3c59x hardware?

I wonder whether this is not a layer violation. Shouldn't there be
some sort of API call to do this?

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
