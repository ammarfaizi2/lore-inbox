Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317387AbSGOI2W>; Mon, 15 Jul 2002 04:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317389AbSGOI2V>; Mon, 15 Jul 2002 04:28:21 -0400
Received: from mortar.viawest.net ([216.87.64.7]:18101 "EHLO
	mortar.viawest.net") by vger.kernel.org with ESMTP
	id <S317387AbSGOI2R>; Mon, 15 Jul 2002 04:28:17 -0400
Date: Mon, 15 Jul 2002 01:30:57 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
Message-ID: <20020715083057.GA1042@wizard.com>
References: <20020713073717.GA9203@wizard.com> <1026547292.1224.132.camel@psuedomode> <1026549957.1224.136.camel@psuedomode> <20020713110619.A28835@ucw.cz> <20020713214801.GA276@wizard.com> <20020714100509.B25887@ucw.cz> <20020714101854.GA1068@wizard.com> <20020714140153.A26469@ucw.cz> <20020714213033.GA1030@wizard.com> <20020715050000.A32268@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020715050000.A32268@ucw.cz>
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.5.25 (i686)
X-uptime: 1:25am  up 3 min,  2 users,  load average: 0.18, 0.16, 0.06
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 05:00:00AM +0200, Vojtech Pavlik wrote:
> > > A keyboard must support the 0xf5 command ('reset').
> > > 
> > > So, the error response might be coming either from the mouse, or the
> > > controller, and somehow gets passed to the keyboard (they unfortunately
> > > share the same registers), or the response somes from the mouse driver
> > > first trying to probe for a mouse on the port.
> > > 
> > > So, please #define I8042_DEBUG_IO in drivers/input/serio/i8042.h as
> > > well, and try again. Then we'll know more.
> > > 
> > 
> >         Just gave that a go.. no change in the dmesg output. Nothing written 
> > out to stdout or anything via syslogd/klogd. See above for that output.
> 
> Are you sure you didn't leave the #undef in that file?

        Sorry about that.. I defined before the #undef. made the change and 
recompiled. dmesg is below:

block: 256 slots per queue, batch=32
ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: VIA Technologies, Inc. Bus Master IDE, PCI slot 00:07.1
ATA: chipset rev.: 6
ATA: non-legacy mode: IRQ probe delayed
VP_IDE: VIA vt82c686b (rev 40) ATA UDMA100 controller on PCI 00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 91531U3, DISK drive
hdb: WDC WD200AB-00BVA0, DISK drive
hdc: CD-W54E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 hda: 30015216 sectors w/512KiB Cache, CHS=29777/16/63, UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: [PTBL] [1868/255/63] p1 p2 p3 p4 < p5 p6 p7 p8 >
 hdb: 39102336 sectors w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
 /dev/ide/host0/bus0/target1/lun0: [PTBL] [2434/255/63] p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 p11 >
mice: PS/2 mouse device common for all mice
i8042.c: 20 -> i8042 (command) [0]
i8042.c: 47 <- i8042 (return) [0]
i8042.c: 60 -> i8042 (command) [0]
i8042.c: 56 -> i8042 (parameter) [0]
i8042.c: 60 -> i8042 (command) [0]
i8042.c: 47 -> i8042 (parameter) [0]
i8042.c: f6 -> i8042 (kbd-data) [0]
i8042.c: fa <- i8042 (interrupt-kbd) [3]
i8042.c: f2 -> i8042 (kbd-data) [3]
i8042.c: fa <- i8042 (interrupt-kbd) [6]
i8042.c: ab <- i8042 (interrupt-kbd) [7]
i8042.c: 60 -> i8042 (command) [7]
i8042.c: 56 -> i8042 (parameter) [7]
i8042.c: 60 -> i8042 (command) [7]
i8042.c: 47 -> i8042 (parameter) [7]
atkbd.c: Sent: f5
i8042.c: f5 -> i8042 (kbd-data) [7]
i8042.c: 60 -> i8042 (command) [17]
i8042.c: 56 -> i8042 (parameter) [17]
i8042.c: fe <- i8042 (interrupt-kbd) [18]
atkbd.c: Received fe
serio: i8042 KBD port at 0x60,0x64 irq 1
i8042.c: d3 -> i8042 (command) [20]
i8042.c: 5a -> i8042 (parameter) [20]
i8042.c: a5 <- i8042 (return) [20]
i8042.c: a9 -> i8042 (command) [20]
i8042.c: 00 <- i8042 (return) [20]
i8042.c: a7 -> i8042 (command) [20]
i8042.c: 20 -> i8042 (command) [20]
i8042.c: 76 <- i8042 (return) [20]
i8042.c: a9 -> i8042 (command) [20]
i8042.c: 00 <- i8042 (return) [20]
i8042.c: a8 -> i8042 (command) [20]
i8042.c: 20 -> i8042 (command) [20]
i8042.c: 56 <- i8042 (return) [20]
i8042.c: 60 -> i8042 (command) [20]
i8042.c: 74 -> i8042 (parameter) [20]
i8042.c: 60 -> i8042 (command) [20]
i8042.c: 56 -> i8042 (parameter) [20]
i8042.c: d4 -> i8042 (command) [20]
i8042.c: f6 -> i8042 (parameter) [20]
i8042.c: 60 -> i8042 (command) [20]
i8042.c: 56 -> i8042 (parameter) [20]
i8042.c: fa <- i8042 (interrupt-aux) [21]
i8042.c: d4 -> i8042 (command) [21]
i8042.c: f2 -> i8042 (parameter) [21]
i8042.c: 60 -> i8042 (command) [21]
i8042.c: 56 -> i8042 (parameter) [21]
i8042.c: fa <- i8042 (interrupt-aux) [22]
i8042.c: 00 <- i8042 (interrupt-aux) [23]
i8042.c: d4 -> i8042 (command) [23]
i8042.c: e8 -> i8042 (parameter) [23]
i8042.c: 60 -> i8042 (command) [23]
i8042.c: 56 -> i8042 (parameter) [23]
i8042.c: fa <- i8042 (interrupt-aux) [24]
i8042.c: d4 -> i8042 (command) [24]
i8042.c: 03 -> i8042 (parameter) [24]
i8042.c: 60 -> i8042 (command) [24]
i8042.c: 56 -> i8042 (parameter) [24]
i8042.c: fa <- i8042 (interrupt-aux) [25]
i8042.c: d4 -> i8042 (command) [26]
i8042.c: e6 -> i8042 (parameter) [26]
i8042.c: 60 -> i8042 (command) [26]
i8042.c: 56 -> i8042 (parameter) [26]
i8042.c: fa <- i8042 (interrupt-aux) [27]
i8042.c: d4 -> i8042 (command) [27]
i8042.c: e6 -> i8042 (parameter) [27]
i8042.c: 60 -> i8042 (command) [27]
i8042.c: 56 -> i8042 (parameter) [27]
i8042.c: fa <- i8042 (interrupt-aux) [28]
i8042.c: d4 -> i8042 (command) [28]
i8042.c: e6 -> i8042 (parameter) [28]
i8042.c: 60 -> i8042 (command) [28]
i8042.c: 56 -> i8042 (parameter) [28]
i8042.c: fa <- i8042 (interrupt-aux) [29]
i8042.c: d4 -> i8042 (command) [29]
i8042.c: e9 -> i8042 (parameter) [29]
i8042.c: 60 -> i8042 (command) [29]
i8042.c: 56 -> i8042 (parameter) [29]
i8042.c: fa <- i8042 (interrupt-aux) [30]
i8042.c: 00 <- i8042 (interrupt-aux) [31]
i8042.c: 03 <- i8042 (interrupt-aux) [32]
i8042.c: 64 <- i8042 (interrupt-aux) [33]
i8042.c: d4 -> i8042 (command) [33]
i8042.c: e8 -> i8042 (parameter) [33]
i8042.c: 60 -> i8042 (command) [33]
i8042.c: 56 -> i8042 (parameter) [33]
i8042.c: fa <- i8042 (interrupt-aux) [34]
i8042.c: d4 -> i8042 (command) [34]
i8042.c: 00 -> i8042 (parameter) [34]
i8042.c: 60 -> i8042 (command) [34]
i8042.c: 56 -> i8042 (parameter) [34]
i8042.c: fa <- i8042 (interrupt-aux) [35]
i8042.c: d4 -> i8042 (command) [35]
i8042.c: e6 -> i8042 (parameter) [35]
i8042.c: 60 -> i8042 (command) [35]
i8042.c: 56 -> i8042 (parameter) [35]
i8042.c: fa <- i8042 (interrupt-aux) [36]
i8042.c: d4 -> i8042 (command) [36]
i8042.c: e6 -> i8042 (parameter) [36]
i8042.c: 60 -> i8042 (command) [36]
i8042.c: 56 -> i8042 (parameter) [36]
i8042.c: fa <- i8042 (interrupt-aux) [37]
i8042.c: d4 -> i8042 (command) [37]
i8042.c: e6 -> i8042 (parameter) [37]
i8042.c: 60 -> i8042 (command) [37]
i8042.c: 56 -> i8042 (parameter) [37]
i8042.c: fa <- i8042 (interrupt-aux) [38]
i8042.c: d4 -> i8042 (command) [38]
i8042.c: e9 -> i8042 (parameter) [38]
i8042.c: 60 -> i8042 (command) [38]
i8042.c: 56 -> i8042 (parameter) [38]
i8042.c: fa <- i8042 (interrupt-aux) [39]
i8042.c: 00 <- i8042 (interrupt-aux) [40]
i8042.c: 00 <- i8042 (interrupt-aux) [41]
i8042.c: 64 <- i8042 (interrupt-aux) [42]
i8042.c: d4 -> i8042 (command) [42]
i8042.c: f3 -> i8042 (parameter) [42]
i8042.c: 60 -> i8042 (command) [42]
i8042.c: 56 -> i8042 (parameter) [42]
i8042.c: fa <- i8042 (interrupt-aux) [43]
i8042.c: d4 -> i8042 (command) [43]
i8042.c: c8 -> i8042 (parameter) [43]
i8042.c: 60 -> i8042 (command) [43]
i8042.c: 56 -> i8042 (parameter) [43]
i8042.c: fa <- i8042 (interrupt-aux) [44]
i8042.c: d4 -> i8042 (command) [44]
i8042.c: f3 -> i8042 (parameter) [44]
i8042.c: 60 -> i8042 (command) [44]
i8042.c: 56 -> i8042 (parameter) [44]
i8042.c: fa <- i8042 (interrupt-aux) [45]
i8042.c: d4 -> i8042 (command) [45]
i8042.c: 64 -> i8042 (parameter) [45]
i8042.c: 60 -> i8042 (command) [45]
i8042.c: 56 -> i8042 (parameter) [45]
i8042.c: fa <- i8042 (interrupt-aux) [46]
i8042.c: d4 -> i8042 (command) [46]
i8042.c: f3 -> i8042 (parameter) [46]
i8042.c: 60 -> i8042 (command) [46]
i8042.c: 56 -> i8042 (parameter) [46]
i8042.c: fa <- i8042 (interrupt-aux) [47]
i8042.c: d4 -> i8042 (command) [47]
i8042.c: 50 -> i8042 (parameter) [47]
i8042.c: 60 -> i8042 (command) [47]
i8042.c: 56 -> i8042 (parameter) [47]
i8042.c: fa <- i8042 (interrupt-aux) [48]
i8042.c: d4 -> i8042 (command) [48]
i8042.c: f2 -> i8042 (parameter) [48]
i8042.c: 60 -> i8042 (command) [48]
i8042.c: 56 -> i8042 (parameter) [48]
i8042.c: fa <- i8042 (interrupt-aux) [49]
i8042.c: 03 <- i8042 (interrupt-aux) [50]
i8042.c: d4 -> i8042 (command) [50]
i8042.c: f3 -> i8042 (parameter) [50]
i8042.c: 60 -> i8042 (command) [50]
i8042.c: 56 -> i8042 (parameter) [50]
i8042.c: fa <- i8042 (interrupt-aux) [51]
i8042.c: d4 -> i8042 (command) [51]
i8042.c: c8 -> i8042 (parameter) [51]
i8042.c: 60 -> i8042 (command) [51]
i8042.c: 56 -> i8042 (parameter) [51]
i8042.c: fa <- i8042 (interrupt-aux) [52]
i8042.c: d4 -> i8042 (command) [52]
i8042.c: f3 -> i8042 (parameter) [52]
i8042.c: 60 -> i8042 (command) [52]
i8042.c: 56 -> i8042 (parameter) [52]
i8042.c: fa <- i8042 (interrupt-aux) [53]
i8042.c: d4 -> i8042 (command) [53]
i8042.c: c8 -> i8042 (parameter) [53]
i8042.c: 60 -> i8042 (command) [53]
i8042.c: 56 -> i8042 (parameter) [53]
i8042.c: fa <- i8042 (interrupt-aux) [54]
i8042.c: d4 -> i8042 (command) [54]
i8042.c: f3 -> i8042 (parameter) [54]
i8042.c: 60 -> i8042 (command) [54]
i8042.c: 56 -> i8042 (parameter) [54]
i8042.c: fa <- i8042 (interrupt-aux) [55]
i8042.c: d4 -> i8042 (command) [55]
i8042.c: 50 -> i8042 (parameter) [55]
i8042.c: 60 -> i8042 (command) [55]
i8042.c: 56 -> i8042 (parameter) [55]
i8042.c: fa <- i8042 (interrupt-aux) [56]
i8042.c: d4 -> i8042 (command) [56]
i8042.c: f2 -> i8042 (parameter) [56]
i8042.c: 60 -> i8042 (command) [56]
i8042.c: 56 -> i8042 (parameter) [56]
i8042.c: fa <- i8042 (interrupt-aux) [57]
i8042.c: 03 <- i8042 (interrupt-aux) [58]
input: ImPS/2 Microsoft IntelliMouse on isa0060/serio1
i8042.c: d4 -> i8042 (command) [60]
i8042.c: f3 -> i8042 (parameter) [60]
i8042.c: 60 -> i8042 (command) [60]
i8042.c: 56 -> i8042 (parameter) [60]
i8042.c: fa <- i8042 (interrupt-aux) [61]
i8042.c: d4 -> i8042 (command) [61]
i8042.c: 64 -> i8042 (parameter) [61]
i8042.c: 60 -> i8042 (command) [61]
i8042.c: 56 -> i8042 (parameter) [61]
i8042.c: fa <- i8042 (interrupt-aux) [62]
i8042.c: d4 -> i8042 (command) [62]
i8042.c: f3 -> i8042 (parameter) [62]
i8042.c: 60 -> i8042 (command) [62]
i8042.c: 56 -> i8042 (parameter) [62]
i8042.c: fa <- i8042 (interrupt-aux) [63]
i8042.c: d4 -> i8042 (command) [63]
i8042.c: c8 -> i8042 (parameter) [63]
i8042.c: 60 -> i8042 (command) [63]
i8042.c: 56 -> i8042 (parameter) [63]
i8042.c: fa <- i8042 (interrupt-aux) [64]
i8042.c: d4 -> i8042 (command) [64]
i8042.c: e8 -> i8042 (parameter) [64]
i8042.c: 60 -> i8042 (command) [64]
i8042.c: 56 -> i8042 (parameter) [64]
i8042.c: fa <- i8042 (interrupt-aux) [65]
i8042.c: d4 -> i8042 (command) [65]
i8042.c: 03 -> i8042 (parameter) [65]
i8042.c: 60 -> i8042 (command) [65]
i8042.c: 56 -> i8042 (parameter) [65]
i8042.c: fa <- i8042 (interrupt-aux) [66]
i8042.c: d4 -> i8042 (command) [67]
i8042.c: e6 -> i8042 (parameter) [67]
i8042.c: 60 -> i8042 (command) [67]
i8042.c: 56 -> i8042 (parameter) [67]
i8042.c: fa <- i8042 (interrupt-aux) [68]
i8042.c: d4 -> i8042 (command) [68]
i8042.c: ea -> i8042 (parameter) [68]
i8042.c: 60 -> i8042 (command) [68]
i8042.c: 56 -> i8042 (parameter) [68]
i8042.c: fa <- i8042 (interrupt-aux) [69]
i8042.c: d4 -> i8042 (command) [69]
i8042.c: f4 -> i8042 (parameter) [69]
i8042.c: 60 -> i8042 (command) [69]
i8042.c: 56 -> i8042 (parameter) [69]
i8042.c: fa <- i8042 (interrupt-aux) [70]
serio: i8042 AUX port at 0x60,0x64 irq 12
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 244k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.


        There ya go.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

