Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317362AbSG1WFx>; Sun, 28 Jul 2002 18:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317371AbSG1WFx>; Sun, 28 Jul 2002 18:05:53 -0400
Received: from ares.sdinet.de ([195.21.215.20]:25871 "HELO ares.sdinet.de")
	by vger.kernel.org with SMTP id <S317362AbSG1WFw>;
	Sun, 28 Jul 2002 18:05:52 -0400
Date: Mon, 29 Jul 2002 00:09:22 +0200 (CEST)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: haegar@space.comunit.de
To: Linux-Kernel-Mailinglist <linux-kernel@vger.kernel.org>
Subject: IDE-Problems with 2.4.x (2.4.19-rc3-ac3)
Message-ID: <Pine.LNX.4.44.0207282351520.18652-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi...

I can't get any newer 2.4-Kernels to boot on my box.

Stock-Debian (Woody) Kernel 2.2.20 works without problems (with and
without dma).

But all 2.4-Kernels fail one way or the other.

Tried till now:
Stock Debian Woody 2.4.16-k6:
	Read Errors while reading the partition-table
Stock Debian Woody 2.4.18-k6: the same
Stock Debian Woody 2.4.18-386: the same

2.4.19-rc3-ac3: "Lost Interrupt" and then "unknown partition table"


The following is the output from the working 2.2.20:

VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hd0: C/H/S=39420/16/255 from BIOS ignored
hda: IC35L080AVVA07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: IC35L080AVVA07-0, 78533MB w/1863kB Cache, CHS=10011/255/63
Partition check:
 hda: hda1 hda2 hda3


lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev
04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South]
(rev 23)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 11)
00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management (rev
30)
00:11.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR)
53c810 (rev 02)
00:12.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR)
53c810 (rev 02)
00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev
10)

/proc/interrupts:
           CPU0
  0:     140590          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  9:       3413          XT-PIC  eth0
 13:          1          XT-PIC  fpu
 14:      37257          XT-PIC  ide0
NMI:          0

/proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(set)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
d000-d007 : ide0
d008-d00f : ide1
e000-e07f : eth0


/proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 451.036
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mmx 3dnow
bogomips        : 897.84


the machine worked over a year without problems, but booted from one of
the scsi-controllers and 2.2.17.


more infos on request, perhaps this is a known problem.

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

