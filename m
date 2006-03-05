Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWCEHpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWCEHpA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 02:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWCEHo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 02:44:59 -0500
Received: from dd6424.kasserver.com ([83.133.49.41]:7905 "EHLO
	dd6424.kasserver.com") by vger.kernel.org with ESMTP
	id S932102AbWCEHo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 02:44:59 -0500
Message-ID: <440A96FD.9020307@feuerpokemon.de>
Date: Sun, 05 Mar 2006 08:45:01 +0100
From: dragoran <dragoran@feuerpokemon.de>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with Plextor 755A
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I bought a plextor 755a drive and tryed to use it on linux.
I am using FC4 x86_64 with kernel kernel-smp-2.6.15-1.1833_FC4.
Sometimes it works just fine (can mount and burn media).
But sometimes (often) it refuses to mount dvds. Saying invalid filesystem.
The same dvd works fine on windows. It also works fine if I use ide-scsi 
(dunno why), but this breaks burning.
I already have filled a bug:
http://bugzilla.kernel.org/show_bug.cgi?id=6162
(no reply so far)
I also noticed this:
Running cdrecord as user:
Device type    : Removable CD-ROM
Version        : 0
Response Format: 2
Capabilities   :
Vendor_info    : 'PLEXTOR '
Identifikation : 'DVDR   PX-755A  '
Revision       : '1.02'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
running it as root:
Device type    : Removable CD-ROM
Version        : 0
Response Format: 2
Capabilities   :
Vendor_info    : 'PLEXTOR '
Identifikation : 'DVDR   PX-755A  '
Revision       : '1.02'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE VARIREC FORCESPEED SPEEDREAD
Why does varirec,forcespeed an speedread only work as root? Is this 
because of the scsi command filter introduced in 2.6.8.1 ?
Other infos:
00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller 
(rev a3)
00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev a2)
00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller 
(rev a3)
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
01:09.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80)
01:0a.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 
Gigabit Ethernet Controller (rev 13)
01:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
01:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 0a)
05:00.0 VGA compatible controller: nVidia Corporation GeForce 7800 GTX 
(rev a1)
CPU = Opteron 170 running on smp kernel. (dual core)
hdparm -I /dev/hdc

/dev/hdc:

ATAPI CD-ROM, with removable media
        Model Number:       PLEXTOR DVDR   PX-755A
        Serial Number:      107321
        Firmware Revision:  1.02
Standards:
        Likely used CD-ROM ATAPI-1
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(can be disabled)
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper

I don't had this Problems with my old burner (LITE ON)
Any idea whats going on here?
PS:
Please CC me
