Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbREXRPy>; Thu, 24 May 2001 13:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbREXRPp>; Thu, 24 May 2001 13:15:45 -0400
Received: from noc.otenet.gr ([195.170.0.29]:39054 "EHLO noc.otenet.gr")
	by vger.kernel.org with ESMTP id <S261615AbREXRPg>;
	Thu, 24 May 2001 13:15:36 -0400
Date: Thu, 24 May 2001 20:15:18 +0300
From: Costas Tavernarakis <taver@otenet.gr>
To: linux-kernel@vger.kernel.org
Subject: aic7xxx problem on -ac series
Message-ID: <20010524201518.A20971@noc.otenet.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm not subscribed to LKML, so please Cc: me with any replies.

I'm running 2.4.5-pre4 with success on an ASUS-CUV4X-D based system
(noapic boot parameter, highmem). This kernel works for me (with a few
occasional hard lockups, but that's another story).

However, I'm having trouble with kernels from the -ac series.
These kernels (with noapic) halt while detecting the first scsi
controller on the system. The messages I get are:

SCSI subsystem driver Revision: 1.00
PCI: Found IRQ9 for device 00:09.0
PCI: The same IRQ used for device 00:0a.1
ahc_pci: 0:90: Using left over BIOS settings

and then the system stops responding.

while -pre4 goes ahead to print:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec 29160N Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/255 SCBs
...

The same problem is seen with virtually all kernels in
2.4.4-ac series, including -ac15. (haven't tried any
earlier -ac, though).

lspci on this system gives:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:09.0 SCSI storage controller: Adaptec 7892A (rev 02)
00:0a.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 14)
00:0a.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 14)
00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 08)
00:0c.1 Input device controller: Creative Labs SB Live! (rev 08)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82)

ver_linux output:
Linux idefix 2.4.5-pre4 #4 SMP Mon May 21 14:52:36 EEST 2001 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.7
util-linux             2.11b
mount                  2.11b
modutils               2.4.6
e2fsprogs              1.19
reiserfsprogs          3.x.0j
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         

I am, of course, willing to provide any more information you
may find important and/or to test any patches.
I'm not a kernel expert, though...

