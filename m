Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316664AbSFZQEh>; Wed, 26 Jun 2002 12:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316666AbSFZQEg>; Wed, 26 Jun 2002 12:04:36 -0400
Received: from mail.broadpark.no ([217.13.4.2]:46501 "HELO mail.broadpark.no")
	by vger.kernel.org with SMTP id <S316664AbSFZQEV>;
	Wed, 26 Jun 2002 12:04:21 -0400
Message-ID: <3D19E4F7.304EA4A6@online.no>
Date: Wed, 26 Jun 2002 17:59:51 +0200
From: Knut J Bjuland <knutjbj@online.no>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-4SGI_XFS_1.1custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bug in Linux 2.4.19RC1 i815e agpgart module, unable to determine 
 aperture size.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I have found a bug in agpgart code in Linux.  To replicate this
error boot into linux in text mode. Modeprobe agpgart and get this
message.  Agpgart work flawless with Linux 2.4.19-pre10 and all other
2.4.X kernels. You may notice that I have Nvidia Geforce but NVdriver
was not loaded when I tried to load agpgart, and the kernel was
untainted. Please CC me in your reply since I do not subscribe to lkml.

/lib/modules/2.4.19-rc1-xfs/kernel/drivers/char/agp/agpgart.o:
init_module: Invalid argument
/lib/modules/2.4.19-rc1-xfs/kernel/drivers/char/agp/agpgart.o: insmod
/lib/modules/2.4.19-rc1-xfs/kernel/drivers/char/agp/agpgart.o failed
/lib/modules/2.4.19-rc1-xfs/kernel/drivers/char/agp/agpgart.o: insmod
agpgart failed
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters





>From dmegs
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel i815 chipset
agpgart: unable to determine aperture size.

00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and
Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corp. 82815 815 Chipset AGP Bridge (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 02)
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev 02)
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2
GTS] (rev a4)
02:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
02:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
07)
02:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 07)

cat /proc/modules
ide-scsi                9344   0
scsi_mod              101496   1 [ide-scsi]
ide-cd                 30368   0
cdrom                  32000   0 [ide-cd]
nls_iso8859-1           3520   1 (autoclean)
nls_cp437               5152   1 (autoclean)
vfat                   11516   1 (autoclean)
fat                    36728   0 (autoclean) [vfat]
ext3                   63744   2 (autoclean)
jbd                    46672   2 (autoclean) [ext3]
usb-uhci               24420   0 (unused)
usbcore                71328   1 [usb-uhci]

