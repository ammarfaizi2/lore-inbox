Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282844AbRLBL7h>; Sun, 2 Dec 2001 06:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282845AbRLBL71>; Sun, 2 Dec 2001 06:59:27 -0500
Received: from mout03.kundenserver.de ([195.20.224.218]:37414 "EHLO
	mout03.kundenserver.de") by vger.kernel.org with ESMTP
	id <S282844AbRLBL7K>; Sun, 2 Dec 2001 06:59:10 -0500
Date: Sun, 2 Dec 2001 13:03:54 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: File system Corruption with 2.4.16
Message-ID: <20011202120354.GA309@elfie.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3C0954D5.6AA3532B@ruault.com> <3C09580F.5F323195@pobox.com> <3C095B0B.7EA478C1@ruault.com> <003601c17ac2$7a8dec10$f5976dcf@nwfs> <3C096DB3.204CE41C@pobox.com> <001e01c17acb$a44b69c0$f5976dcf@nwfs> <20011202023145.A1628@emeraude.kwisatz.net> <3C09B3FA.61777E84@ruault.com> <1007273541.408.5.camel@psuedomode> <3C09CF7D.9E395177@ruault.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C09CF7D.9E395177@ruault.com>
User-Agent: Mutt/1.3.24-current-20011201i (Linux 2.4.17-pre2 i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Dec 01 2001, Charles-Edouard Ruault wrote:

> I agree with you when you say it's not as general ... 
> i'm sure that otherwise the problem would have been already 
> reported and fixed ...

I tried but could NOT (re)produce any filesystem corruption (ext2)
using 2.4.16 or 2.4.17-pre(1|2), and I have almost the same hardware here.
I stressed my system until collapse (copying GB's, untaring, parallel
compiling...), no ext2 corruption.

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 4).
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=4.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 65).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=64.  
      I/O at 0xe000 [0xe00f].
  Bus  0, device   7, function  3:
    Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 16).
  Bus  0, device  17, function  0:
    VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=255.
      Non-prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 9
model name	: AMD-K6(tm) 3D+ Processor
stepping	: 1
cpu MHz		: 400.918
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips	: 799.53

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci00:07.1
ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DHEA-36481, ATA DISK drive
hdb: Conner Peripherals 1275MB - CFS1275A, ATA DISK drive
hdc: CD-540E, ATAPI CD/DVD-ROM drive
hdd: CD-W54E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 12692736 sectors (6499 MB) w/472KiB Cache, CHS=790/255/63, UDMA(33)
hdb: 2496876 sectors (1278 MB) w/64KiB Cache, CHS=619/64/63, DMA

hd@elfie:~ # gcc -v
Reading specs from /usr/local/lib/gcc-lib/i586-pc-linux-gnu/2.95.3/specs
gcc version 2.95.3 20010315 (release)

Gnu C                  2.95.3
Gnu make               3.79.1
binutils	       2.11.92.0.7
util-linux             2.11m
Fileutils              4.1
mount                  2.11m
modutils               2.4.12
e2fsprogs              1.24
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Linux C++ Library      2.9.0
Procps                 2.0.7
Net-tools              1.46
Kbd                    1.06
Sh-utils               2.0.11
Modules Loaded         ppp_deflate ppp_async ppp_generic slhc serial

-- 
# Heinz Diehl, 68259 Mannheim, Germany
