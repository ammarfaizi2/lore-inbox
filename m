Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130834AbRCTV7p>; Tue, 20 Mar 2001 16:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130900AbRCTV7f>; Tue, 20 Mar 2001 16:59:35 -0500
Received: from ns.suse.de ([213.95.15.193]:58121 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130834AbRCTV71>;
	Tue, 20 Mar 2001 16:59:27 -0500
Date: Tue, 20 Mar 2001 22:58:45 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2 freezes with bad ISOs in IDE cdroms
Message-ID: <20010320225845.A5763@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a bogus bugreport.

The 2.4.2 kernel freezes on some machines here when I try to access (or
mount) a bad self burned ISO image, in this case the boot CD with the
install system.

There are different case:

I have an iBook and a blue&white G3. The G3 has a cmd646 controller. It
freezes when it tries to access the CD. No output.
"ide0=nodma ide2=nodma" doesnt lead to a freeze, but endless error messages.
The installer starts after a while, so it can mount the inst-sys, but it
doest get very far (no output).

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
CMD646: IDE controller on PCI bus 01 dev 08
CMD646: chipset revision 7
CMD646: chipset revision 0x07, UltraDMA Capable
CMD646: 100% native mode on irq 26
    ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:pio, hdd:pio
pmac_ide: enabling IDE bus ID 0
hda: Maxtor 90648D3, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
hde: MATSHITADVD-ROM SR-8583, ATAPI CD/DVD-ROM drive
ide0 at 0x1840-0x1847,0x1832 on irq 26
ide2 at 0xc8544000-0xc8544007,0xc8544160 on irq 13
hda: 12656448 sectors (6480 MB) w/512KiB Cache, CHS=12556/16/63,
UDMA(33)
hde: Enabling MultiWord DMA 2
hde: ATAPI 32X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9 hda10


Today I got another report on a G4/500. It just freezes when it access a
package on a bad block. Skipping the rpm package were it freezes solves that.

I tried the same ISOs on a SCSI cdrom to verify the MD5SUMS, no crash,
just read errors in dmesg. The controller is a "Symbios Logic Inc.
(formerly NCR) 53c875 (rev 04)".

However, my machine at home locks the SCSI bus in sometimes. It has a
mesh SCSI controller, The last message in the syslog is that:
Device not ready.  Make sure there is a disc in the drive
I still can switch consoles, but the hard drive is not accessible
anymore. 
(this part of the bugreport is maybe not related to the lockups).



Any ideas where to start here?


Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
