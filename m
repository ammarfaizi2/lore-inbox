Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318132AbSIJVJC>; Tue, 10 Sep 2002 17:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318138AbSIJVJB>; Tue, 10 Sep 2002 17:09:01 -0400
Received: from web14001.mail.yahoo.com ([216.136.175.92]:15538 "HELO
	web14001.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318132AbSIJVHg>; Tue, 10 Sep 2002 17:07:36 -0400
Message-ID: <20020910211222.37684.qmail@web14001.mail.yahoo.com>
Date: Tue, 10 Sep 2002 14:12:22 -0700 (PDT)
From: Tony Spinillo <tspinillo@yahoo.com>
Subject: Re: Linux 2.4.20-pre6 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  o i845G fixes

I just tried 2.4.20-pre6 on my Intel 845GBVL board (845G chipset). 
For the first time DMA is available with the DVD drive, 
without a -ac patch. But UDMA(25) as opposed to UDMA(33) 
with 2.4.20pre5-ac1.Also I got some junk characters in 2.4.20pre6 
when it was probing for IDE devices: 

*****DMESG 2.4.20pre6 snip of the Intel board *****
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
PCI: Found IRQ 5 for device 00:1f.1
PCI: Sharing IRQ 5 with 00:1d.2
GARBAGE CHARACTERS HERE: BIOS setup was incomplete.
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
hda: LITEON DVD-ROM LTD-165H, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 48X DVD-ROM drie, 512kB Cache, UDMA(25)
Uniform CD-ROM driver Revision: 3.12
*******
Here is a Dmesg snip of 2.4.20pre5-ac1 on the Intel Board:
*******
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha1
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
PCI: Device 00:1f.1 not available because of resource collisions
PCI: Found IRQ 5 for device 00:1f.1
PCI: Sharing IRQ 5 with 00:1d.2
ICH4: Not fully BIOS configured!
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
hda: LITEON DVD-ROM LTD-165H, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
***********
2.4.20-pre6 came up fine with my Gigabyte 845IGX (845G chipset)
equipped machine. (Award BIOS as opposed to Intel's). DMA
started to work with 2.4.20-pre5 on this board. The
latest -ac patches do not work on this machine.

Here are full links to the Intel 845GBVL dmesg and lspci:
http://ac.marywood.edu/tspin/www/dmesg2420pre6.txt
http://ac.marywood.edu/tspin/www/dmesg2420pre5ac1.txt
http://ac.marywood.edu/tspin/www/lspci2420pre6.txt

Thanks! If anyone needs more info, let me know.

Tony


__________________________________________________
Yahoo! - We Remember
9-11: A tribute to the more than 3,000 lives lost
http://dir.remember.yahoo.com/tribute
