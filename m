Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937699AbWLFWGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937699AbWLFWGI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 17:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937706AbWLFWGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 17:06:08 -0500
Received: from ms.trustica.cz ([82.208.32.68]:54701 "EHLO ms.trustica.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937716AbWLFWGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 17:06:05 -0500
Message-ID: <45773EB9.3060800@assembler.cz>
Date: Wed, 06 Dec 2006 23:05:45 +0100
From: Rudolf Marek <r.marek@assembler.cz>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Rudmer van Dijk <rudmer.van.dijk@casema.nl>
CC: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_via report
References: <4573353E.2060307@assembler.cz> <200612040035.30642.rudmer.van.dijk@casema.nl>
In-Reply-To: <200612040035.30642.rudmer.van.dijk@casema.nl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> 1 Maxtor 6Y080P0 on primary IDE and 2 optical drives on secundary IDE (DVD-RW 
> master, CD-RW slave). all are connected with 80pin cables:
> 
> libata version 2.00 loaded.
> pata_via 0000:00:0f.1: version 0.2.0
> ata1: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFC00 irq 14
> ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFC08 irq 15
> scsi0 : pata_via
> ata1.00: ATA-7, max UDMA/133, 160086528 sectors: LBA 
> ata1.00: ata1: dev 0 multi count 16
> ata1.00: configured for UDMA/133

Anyone can help me check if I'm right?

Each byte is for each channel, LSB is secondary slave. Interesting bit is bit 4
1 = 80PIN.

Mine:
> 50: 07 e6 07 e1

So: I have 40 40 40 40

 > 50: e6 e2 17 e0

Yours: 40 40 80 40

So the silly BIOS is doing something wrong :/ I would expect 40 40 80 80.
I will try to play with the cables to see what I can get.

regards
Rudolf


