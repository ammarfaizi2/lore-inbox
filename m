Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTLULVS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 06:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTLULVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 06:21:18 -0500
Received: from hell.sks3.muni.cz ([147.251.210.31]:36043 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262598AbTLULVQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 06:21:16 -0500
Date: Sun, 21 Dec 2003 12:21:13 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Cc: linux@3ware.com
Subject: 3ware driver broken with 2.4.22/23 ?
Message-ID: <20031221112113.GE916@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have 3ware Escalade 8500-8 card with 8 SATA WD 250GB drives. I set up HW RAID5
configuration over all drives.
I'm using kernel 2.4.23 vanilla with XFS patch. RAID5 partition is formated to
XFS.
System is single hyper threaded P4 Xeon 2.8GHz with 1GB of RAM. There is Intel
1000/PRO ethernet card. Motherboard is MSI E7501 Master-LS.

If I do:
iozone -Ra -g 20G -e -n 10485760 
on the XFS partition then it freezes after certain time (but always the same
amount if I run it again few times).

Server responds only to ping and sysrq. No process can be run and already
running process top freezes as well. After about 8 hours it is still freezed.
If I connect monitor to the server when it freezes then monitor indicates - no
signal.

I use configuration with SMP without HIGHMEM. However it happens without SMP as
well. (Driver: 1.02.00.036)

With kernel 2.6.0 it seems to be ok. (Driver: 1.02.00.037)

Here is lspci:
00:00.0 Host bridge: Intel Corp. E7501 Memory Controller Hub (rev 01)
00:00.1 Class ff00: Intel Corp. E7000 Series Host RASUM Controller (rev 01)
00:02.0 PCI bridge: Intel Corp. E7000 Series Hub Interface B PCI-to-PCI Bridge (rev 01)
00:02.1 Class ff00: Intel Corp. E7000 Series Hub Interface B RASUM Controller (rev 01)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corp. 82801CA LPC Interface Controller (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801CA Ultra ATA Storage Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
01:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04)
01:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
01:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04)
01:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
02:09.0 Ethernet controller: Intel Corp. 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
02:0c.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
04:04.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
04:05.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)

Here is info from 3ware card:
Monitor version:	ME7X 1.01.00.035	
Firmware version:	FE7S 1.05.00.036	
BIOS version:		BE7X 1.08.00.044	
PCB version:		Rev3	
Achip version:		V3.20	
Pchip version:		V1.30	
Model:			8500-8

Can firmware upgrade help? Or there is an issue with something other not related
to 3ware card?

-- 
Luká¹ Hejtmánek
