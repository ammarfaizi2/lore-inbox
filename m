Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272980AbTHKUx2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 16:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272961AbTHKUxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 16:53:19 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:45972
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S272796AbTHKUww
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 16:52:52 -0400
Date: Mon, 11 Aug 2003 17:06:57 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: narancs <narancs@narancs.tii.matav.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DEC KZPSA SCSI card - is there a linux driver?
Message-ID: <20030811170657.A30357@animx.eu.org>
References: <3F37A962.4030505@narancs.tii.matav.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3F37A962.4030505@narancs.tii.matav.hu>; from narancs on Mon, Aug 11, 2003 at 04:34:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I guess this mail should have gone to a mailing list like linux-scsi, 
> but I just couldn't find that list's address - sorry if this mail is not 
> to be here :)
> 
> so I have just got a DEC PCI SCSI card which has a sym53c720 chip and an 
> intel 930 chip and an LSI chip on board. it is a full-length 32bit PCI 
> scsi card. (it was working fine in an alpha axp system with true64 unix, 
> and now it is installed in a PC.)
> 
> with linux kernel 2.4.20 (suse8.2) trying all the modules, I just 
> couldn't get it working.
> I moved the card to other PCI slots and play with irqs, but no success.
> 
> please help that which driver should get it working if this card is 
> supported at all.

Are you sure it's not a raid controller?  Being a full length PCI card, it
may be.  DEC used Mylex DAC960 controller in some of their servers.  My
AS1000A came with 2 single channel DAC960PD cards.  Does it have a slot for
memory? (good indication of being raid)

> 00:0d.0 SCSI storage controller: Digital Equipment Corporation KZPSA [KZPSA]
>         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
> ParErr+ Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz- UDF+ FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 66 (2000ns min, 31750ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 7
>         BIST result: 00
>         Region 0: Memory at fedfd000 (64-bit, non-prefetchable) [size=4K]
>         Region 2: I/O ports at d000 [size=4K]
>         Region 3: Memory at feb00000 (64-bit, non-prefetchable) [size=1M]
>         Expansion ROM at <unassigned> [disabled] [size=64K]

Doesn't seem like a raid controller here.  Is this an alpha machine?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
