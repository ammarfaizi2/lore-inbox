Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272178AbRIENwp>; Wed, 5 Sep 2001 09:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272179AbRIENwg>; Wed, 5 Sep 2001 09:52:36 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:37638 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S272178AbRIENwY>; Wed, 5 Sep 2001 09:52:24 -0400
Date: Wed, 5 Sep 2001 15:52:42 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: ACPI lock-up on kernel init when probing /dev/hde (Promise 20265R)
Message-ID: <20010905155242.A3926@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when booting 2.4.9-ac7 with "apm=off", the ACPI system that I compiled
kicks in. I don't think it's -ac7 specific, IIRC, I also killed 2.4.9
with that, and I can check 2.4.7 should someone ask. If necessary, I can
also capture the log output via serial console and send the log of a
failed boot.

Here's the log of a normal boot:

PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: ROM enabled at 0xdfff0000
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xcc00-0xcc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdg:pio, hdh:pio
hda: WDC AC420400D, ATA DISK drive
  [ACPI locks up here]
hde: IBM-DTLA-307045, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xdc00-0xdc07,0xd802 on irq 11
hda: 39876480 sectors (20417 MB) w/1966KiB Cache, CHS=2482/255/63, (U)DMA
hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 hda15 >
 hde: [PTBL] [5606/255/63] hde1 hde2 < hde5 hde6 hde7 hde8 hde9 hde10 >

With ACPI, that box dies after the

hda: WDC AC420400D, ATA DISK drive

line, the HDD LED is always-on and nothing works (not even magic sysrq
for straight reboot) except pressing reset.

With APM, that box boots fine.

BTW, what's that KiB junk it mentions later on? Any ISO standard I
missed?

-- 
Matthias Andree
