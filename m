Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319323AbSHVL1K>; Thu, 22 Aug 2002 07:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319324AbSHVL1K>; Thu, 22 Aug 2002 07:27:10 -0400
Received: from ulima.unil.ch ([130.223.144.143]:26505 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S319323AbSHVL1I>;
	Thu, 22 Aug 2002 07:27:08 -0400
Date: Thu, 22 Aug 2002 13:31:13 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac6
Message-ID: <20020822113112.GB19201@ulima.unil.ch>
References: <200208212025.g7LKPda15450@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200208212025.g7LKPda15450@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I can't use DMA on ICH4 with it (MB MSI 845E Max2-BLR):
with PNPBIOS compiled in (no ACPI compiled in):
(almost full log under
http://ulima.unil.ch/greg/linux/dmesg-2.4.20-pre2-ac6 )

...
i810_rng: RNG not detected
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha1
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PCI: Unable to reserve I/O region #1:8@0 for device 00:1f.1
Trying to free nonexistent resource <00000000-00000007>
Trying to free nonexistent resource <00000000-00000003>
Trying to free nonexistent resource <00000000-00000007>
Trying to free nonexistent resource <00000000-00000003>
Trying to free nonexistent resource <0000fc00-0000fc0f>
Trying to free nonexistent resource <20000000-200003ff>
hda: IC35L120AVVA07-0, ATA DISK drive
hdc: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=15017/255/63
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
Linux agpgart interface v0.99 (c) Jeff Hartmann
...

And without PNPBIOS (also without ACPI):
(almost full log under
http://ulima.unil.ch/greg/linux/dmesg-2.4.20-pre2-ac6-noPNPBIOS )
...
i810_rng: RNG not detected
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha1
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PCI: Unable to reserve I/O region #1:8@0 for device 00:1f.1
Trying to free nonexistent resource <00000000-00000007>
Trying to free nonexistent resource <00000000-00000003>
Trying to free nonexistent resource <00000000-00000007>
Trying to free nonexistent resource <00000000-00000003>
Trying to free nonexistent resource <0000fc00-0000fc0f>
Trying to free nonexistent resource <20000000-200003ff>
hda: IC35L120AVVA07-0, ATA DISK drive
hdc: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=15017/255/63
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
Linux agpgart interface v0.99 (c) Jeff Hartmann
...

That don't seem to change anything... I have reported an oops with
2.4.20-pre2-ac3 also with IDE:
http://groups.google.com/groups?hl=fr&lr=&ie=UTF-8&threadm=20020816181957.GA14157%40ulima.unil.ch&rnum=1&prev=/groups%3Fhl%3Dfr%26lr%3D%26ie%3DISO-8859-1%26q%3D2.4.20-pre2-ac3%2Boops%26btnG%3DRecherche%2BGoogle

Is there something I could try?

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
