Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281748AbRKVUyb>; Thu, 22 Nov 2001 15:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281759AbRKVUyM>; Thu, 22 Nov 2001 15:54:12 -0500
Received: from dark.pcgames.pl ([195.205.62.2]:62434 "EHLO dark.pcgames.pl")
	by vger.kernel.org with ESMTP id <S281748AbRKVUyC>;
	Thu, 22 Nov 2001 15:54:02 -0500
Date: Thu, 22 Nov 2001 21:53:06 +0100 (CET)
From: Krzysztof Oledzki <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: <linux-kernel@vger.kernel.org>
cc: <kmliu@sis.com.tw>, <andre@suse.com>
Subject: SIS IDE (sis5513.c)
Message-ID: <Pine.LNX.4.33.0111222120440.18864-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello :)

I have a notebook with SIS IDE Chipset - SIS601. This week I have
installed Linux. It seems that this chipset is not supported by sis5513.c
driver. I tried adding support myself by putting PCI_DEVICE_ID_SI_601 in
each switch/case in this file (because I found that it sound work for
PCI_DEVICE_ID_SI_540 and PCI_DEVICE_ID_SI_620 ). Unfortunetly ugly
"unknown IDE controller" message still appeard. Then I go to the ide-pci.c
and noticed that int ide_pci_chipsets here is only one line for SIS:

        {DEVID_SIS5513, "SIS5513",      PCI_SIS5513,    ATA66_SIS5513,  INIT_SIS5513,   NULL,        {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},   ON_BOARD,       0 },

and one #define:
#define DEVID_SIS5513   ((ide_pci_devid_t){PCI_VENDOR_ID_SI,      PCI_DEVICE_ID_SI_5513})

BTW: Am I right, this makes that only PCI_DEVICE_ID_SI_5513 chipset is
supported and all other chipset listed in sis5513.c will not work?

Ok, I added DEVID_SIS601 (PCI_DEVICE_ID_SI_601) with parameters from
SIS5513 or all zeros but... now I have "neither IDE port enabled (BIOS)"
message. So? Is there any way to enable DMA transfers for my HDD? With PIO
my HDD is verry slow (hdparm shows 3 MB/sek).

Best regards,

				Krzysztof Oledzki

