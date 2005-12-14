Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVLNVJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVLNVJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 16:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVLNVJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 16:09:59 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:5356 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932314AbVLNVJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 16:09:58 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: Re: sata_uli fails to see harddisks on an ASRock 939Dual-SATA2 board
Date: Wed, 14 Dec 2005 22:11:06 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <200512141501.10093.bero@arklinux.org>
In-Reply-To: <200512141501.10093.bero@arklinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512142211.06532.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 14 December 2005 15:01, Bernhard Rosenkraenzer wrote:
> On an ASRock 939Dual-SATA2 board, the sata_uli driver recognizes the onboard 
> SATA controller (PCI ID 10b9:5289 rev 10, Subsystem 1849:5289), but fails to 
> see an attached harddisk (the BIOS identifies the harddisk correctly, so a 
> hardware failure is unlikely). sata_uli apparently sees _something_ is 
> attached, but doesn't get further. dmesg says:
> 
> libata version 1.20 loaded.
> sata_uli 0000:00:12.1: version 0.5
> GSI 18 sharing vector 0xD1 and IRQ 18
> ACPI: PCI Interrupt 0000:00:12.1[A] -> GSI 19 (level, low) -> IRQ 209
> ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE082 bmdma 0xD880 irq 209
> ata2: SATA max UDMA/133 cmd 0xE000 ctl 0xDC02 bmdma 0xD888 irq 209
> ata1: SATA link up 1.5 Gbps (SStatus 113)
> scsi0 : sata_uli
> ata2: SATA link down (SStatus 0)
> scsi1 : sata_uli
> 
> No disks are found, even though the link (on ata1) is detected.
> 
> Verified both with an x86 and an x86_64 kernel, and both 2.6.15-rc5 and 
> 2.6.15-rc5-mm2.

I have exactly the same board and 2.6.15-rc5/x86-64 works for me (no problems
with detecting SATA drives on SATA1 ports).  The drives are jumper-forced to
SATA1, though, and I haven't tried the SATA2 controller.

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
