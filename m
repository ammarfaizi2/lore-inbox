Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131477AbRCUOVV>; Wed, 21 Mar 2001 09:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131478AbRCUOVM>; Wed, 21 Mar 2001 09:21:12 -0500
Received: from agnus.shiny.it ([194.20.232.6]:63242 "EHLO agnus.shiny.it")
	by vger.kernel.org with ESMTP id <S131477AbRCUOU6>;
	Wed, 21 Mar 2001 09:20:58 -0500
Message-ID: <XFMail.010321151922.pochini@shiny.it>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010320225845.A5763@suse.de>
Date: Wed, 21 Mar 2001 15:19:22 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Olaf Hering <olh@suse.de>
Subject: RE: 2.4.2 freezes with bad ISOs in IDE cdroms
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20-Mar-01 Olaf Hering wrote:
> Hi,
> 
> this is a bogus bugreport.
> 
> The 2.4.2 kernel freezes on some machines here when I try to access (or
> mount) a bad self burned ISO image, in this case the boot CD with the
> install system.
> 
> There are different case:
> 
> I have an iBook and a blue&white G3. The G3 has a cmd646 controller. It
> freezes when it tries to access the CD. No output.
> "ide0=nodma ide2=nodma" doesnt lead to a freeze, but endless error messages.
> The installer starts after a while, so it can mount the inst-sys, but it
> doest get very far (no output).
> 
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> CMD646: IDE controller on PCI bus 01 dev 08
> CMD646: chipset revision 7
> CMD646: chipset revision 0x07, UltraDMA Capable
> CMD646: 100% native mode on irq 26
>     ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:pio, hdd:pio
> pmac_ide: enabling IDE bus ID 0
> hda: Maxtor 90648D3, ATA DISK drive
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> hde: MATSHITADVD-ROM SR-8583, ATAPI CD/DVD-ROM drive
> ide0 at 0x1840-0x1847,0x1832 on irq 26
> ide2 at 0xc8544000-0xc8544007,0xc8544160 on irq 13
> hda: 12656448 sectors (6480 MB) w/512KiB Cache, CHS=12556/16/63,
> UDMA(33)
> hde: Enabling MultiWord DMA 2
> hde: ATAPI 32X DVD-ROM drive, 512kB Cache, DMA
> Uniform CD-ROM driver Revision: 3.12
> Partition check:
>  hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9 hda10
> 
> 
> Today I got another report on a G4/500. It just freezes when it access a
> package on a bad block. Skipping the rpm package were it freezes solves that.
> 
> I tried the same ISOs on a SCSI cdrom to verify the MD5SUMS, no crash,
> just read errors in dmesg. The controller is a "Symbios Logic Inc.
> (formerly NCR) 53c875 (rev 04)".
> 
> However, my machine at home locks the SCSI bus in sometimes. It has a
> mesh SCSI controller, The last message in the syslog is that:
> Device not ready.  Make sure there is a disc in the drive
> I still can switch consoles, but the hard drive is not accessible
> anymore. 
> (this part of the bugreport is maybe not related to the lockups).
> 
> 
> Any ideas where to start here?


This happens on my blue G3 with 2.2.x too. I think it's a bug in the IDE
driver. My old 7300 (mesh) with a SCSI cd just reported a read error on
the same disk.


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-

