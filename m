Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbRGCQw7>; Tue, 3 Jul 2001 12:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265072AbRGCQwt>; Tue, 3 Jul 2001 12:52:49 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:40322 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S264963AbRGCQwg>; Tue, 3 Jul 2001 12:52:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gav <gavbaker@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.6-pre9: Failed HPT370 detection
Date: Tue, 3 Jul 2001 17:44:33 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <01070317222000.01180@box.penguin.power>
In-Reply-To: <01070317222000.01180@box.penguin.power>
MIME-Version: 1.0
Message-Id: <01070317423500.01111@box.penguin.power>
Content-Transfer-Encoding: 7BIT
Cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 July 2001 17:22, Gav wrote:

> This kernel refuses to detect my HPT370 chipset. (where my root filesystem
> is, on raid0). It just hangs where the detection usually takes place, so no
> oops and no meaningfull bugreport :/
>
> I have the same options set in my config as I always have, I've never had
> any problem with this before.
>
> CONFIG_BLK_DEV_HPT366=y
> CONFIG_MD_RAID0=y
>
> Anyone else seen this? Maybe its more VIA weirdness.
>

Actually its the drives ON the HPT chipset that arent being detected, not the 
chipset itself.

usually:
HPT370: IDE controller on PCI bus 00 dev 98
PCI: Found IRQ 11 for device 00:13.0 
HPT370: chipset revision 3 
HPT370: not 100%% native mode: will probe irqs later
    ide2: BM-DMA at 0xe000-0xe007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xe008-0xe00f, BIOS settings: hdg:DMA, hdh:pio
hda: SAMSUNG SV0322A, ATA DISK drive 
hdb: Hewlett-Packard CD-Writer Plus 9100b, ATAPI CD/DVD-ROM drive
hde: IBM-DTLA-305040, ATA DISK drive
hdg: IBM-DTLA-305040, ATA DISK drive
<etc>

in 2.4.6-pre9:
HPT370: IDE controller on PCI bus 00 dev 98
PCI: Found IRQ 11 for device 00:13.0 
HPT370: chipset revision 3 
HPT370: not 100%% native mode: will probe irqs later
    ide2: BM-DMA at 0xe000-0xe007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xe008-0xe00f, BIOS settings: hdg:DMA, hdh:pio
hda: SAMSUNG SV0322A, ATA DISK drive 
hdb: Hewlett-Packard CD-Writer Plus 9100b, ATAPI CD/DVD-ROM drive
<Hang>

Sorry about that.

-- Gavin Baker
