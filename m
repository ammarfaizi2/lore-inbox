Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317471AbSIEMmq>; Thu, 5 Sep 2002 08:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317489AbSIEMmq>; Thu, 5 Sep 2002 08:42:46 -0400
Received: from mail.hometree.net ([212.34.181.120]:32915 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S317471AbSIEMmp>; Thu, 5 Sep 2002 08:42:45 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [PATCH] 2.4.20-pre5-ac2: Promise Controller LBA48 DMA fixed
Date: Thu, 5 Sep 2002 12:47:20 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <al7joo$9nd$1@forge.intermeta.de>
References: <1030635125.7190.116.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0209050050120.20228-100000@grace.speakeasy.net>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1031230040 24481 212.34.181.4 (5 Sep 2002 12:47:20 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 5 Sep 2002 12:47:20 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Isely <isely@pobox.com> writes:

>The trivial patch at the end of this text fixes DMA w/ LBA48 problems

More readable would be:

>-		if (!hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20246) {
>+		if (!(hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20246)) {

		if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246) {

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
