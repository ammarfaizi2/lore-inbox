Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135792AbRDTERz>; Fri, 20 Apr 2001 00:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135794AbRDTERp>; Fri, 20 Apr 2001 00:17:45 -0400
Received: from b204.mhk.lu.se ([194.47.215.209]:52495 "EHLO
	RoadRunner.mhk.lu.se") by vger.kernel.org with ESMTP
	id <S135792AbRDTERb>; Fri, 20 Apr 2001 00:17:31 -0400
Date: Fri, 20 Apr 2001 06:17:04 +0200 (CEST)
From: Per-Henrik Persson <vajper@whatever.nu>
To: linux-kernel@vger.kernel.org
Subject: BP6: APIC, rtl8139 & sound
Message-ID: <Pine.LNX.4.21.0104200558310.12410-100000@RoadRunner.mhk.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'v been lurking around all archives from this list trying to find an
answer to my problem but with no success so I take the step ant mail it to
this list.

My hardware setup is as following:

Abit BP6, 2xCeleron 366, G400, old Matrox-card, sym53c8xx SCSI, Trident
4DWave NX sound, rtl8139 NIC.

lspci: 
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:09.0 Multimedia audio controller: Trident Microsystems 4DWave NX (rev
02)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev
10)
00:0d.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c895
(rev 01)
00:0f.0 Display controller: Matrox Graphics, Inc. MGA 2064W [Millennium]
(rev 01)
00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366
(rev 01)
00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366
(rev 01)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev
03)

cat /proc/interupts: 
           CPU0       CPU1       
  0:      79118      75272    IO-APIC-edge  timer
  1:       2261       2358    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          0          1    IO-APIC-edge  rtc
 12:      33056      32767    IO-APIC-edge  PS/2 Mouse
 14:          3         22    IO-APIC-edge  ide0
 15:          8         24    IO-APIC-edge  ide1
 16:          0          0   IO-APIC-level  mga@PCI:1:0:0
 17:        100         94   IO-APIC-level  sym53c8xx
 18:      45894      45820   IO-APIC-level  ide2, eth0
 19:      38881      40110   IO-APIC-level  usb-uhci, Trident 4DWave PCI
NMI:          0          0 
LOC:     154313     154315 
ERR:    6994982

I recently made a full reinstall of my Debian-system, from scratch. I also
upgraded to 2.4.3, ALSA for sound. Now I have a lot of problems!

When using my system, not using the NIC, not using sound I get some errors
like: 

APIC error on CPU0: 02(02)
APIC error on CPU1: 01(01)
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(01)

If i start to use the NIC, like som browsing on the internet i occassionly
get:

eth0: Too much work at interrupt, IntrStatus=0x0001.

The number of that kind of messages increases with harder network
traffic. A floodping TO my computer generates like 50 messages...

If I then start to use the sound (playing MP3's) i sometimes get _small_
lockups when X won't respond. If I at the same time generate some activity
on the harddisk connected to IDE2 I get longer lockups. A "cat
/proc/interupts" shows that I get a lot of interupt errors :(

Every now and then i get a lockup for like 10 seconds and as you can see
from my /proc/interupts above I get MILLIONS of interrupt errors! A
"dmesg" will give me an infinite stream of APIC-errors...

Do anyone have a solution for my problem? 

Last but not least, I haven't joined the kernel-list because I have some
troubles with the internet connection to my mailserver. Would it be
possible to CC all answers to ph@whatever.nu ?

Thanx in advance,

P-H


******************************************************************************** 
Per-Henrik Persson                         0703-68 53 86
vajper@whatever.nu                         http://www.whatever.nu
                                           -stupid webcam online 24h a day
"With digital it's all or nothing!"
"Just because something doesn't work, it doesn't mean it can't be used..."
********************************************************************************

