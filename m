Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272401AbRIOQUS>; Sat, 15 Sep 2001 12:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272399AbRIOQUJ>; Sat, 15 Sep 2001 12:20:09 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:28290 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S272385AbRIOQT4>; Sat, 15 Sep 2001 12:19:56 -0400
Message-ID: <3BA37F9A.9060003@korseby.net>
Date: Sat, 15 Sep 2001 18:19:38 +0200
From: Kristian Peters <kristian.peters@korseby.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Mohammad A. Haque" <mhaque@haque.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext2fs corruption again
In-Reply-To: <3BA33818.8030503@korseby.net> <3BA37848.BB5851E9@haque.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*Soooorrrry for sending the first message of this thread 3 times... But the 
mailing list still returns my mails...*

Mohammad A. Haque wrote:
> You need to provide more information such as what kind of motherboard or
> ide chipset you are using. 

Ok. I already did that before and will do it again. ;-)

As you'll see I have no VIA chipset.

[root@adlib /root]# cat /proc/interrupts
            CPU0
   0:     424127          XT-PIC  timer
   1:      20206          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   8:          1          XT-PIC  rtc
  11:     186306          XT-PIC  es1371, bttv, eth0
  12:      94563          XT-PIC  PS/2 Mouse
  14:     117603          XT-PIC  ide0
  15:         17          XT-PIC  ide1
NMI:          0
ERR:          0
[root@adlib /root]# cat /proc/pci
PCI devices found:
   Bus  0, device   0, function  0:
     Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 3).
       Master Capable.  Latency=64.
       Prefetchable 32 bit memory at 0x44000000 [0x47ffffff].
   Bus  0, device   1, function  0:
     PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 3).
       Master Capable.  Latency=64.  Min Gnt=140.
   Bus  0, device  14, function  0:
     Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 5).
       IRQ 11.
       Master Capable.  Latency=66.  Min Gnt=8.Max Lat=56.
       Prefetchable 32 bit memory at 0x48100000 [0x48100fff].
       I/O at 0x1000 [0x101f].
       Non-prefetchable 32 bit memory at 0x48000000 [0x480fffff].
   Bus  0, device  15, function  0:
     Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 6).
       IRQ 11.
       Master Capable.  Latency=64.  Min Gnt=12.Max Lat=128.
       I/O at 0x1080 [0x10bf].
   Bus  0, device  16, function  0:
     Multimedia video controller: Brooktree Corporation Bt878 (rev 17).
       IRQ 11.
       Master Capable.  Latency=66.  Min Gnt=16.Max Lat=40.
       Prefetchable 32 bit memory at 0x48200000 [0x48200fff].
   Bus  0, device  16, function  1:
     Multimedia controller: Brooktree Corporation Bt878 (rev 17).
       IRQ 11.
       Master Capable.  Latency=66.  Min Gnt=4.Max Lat=255.
       Prefetchable 32 bit memory at 0x48300000 [0x48300fff].
   Bus  0, device  20, function  0:
     ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 2).
   Bus  0, device  20, function  1:
     IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
       Master Capable.  Latency=64.
       I/O at 0x1040 [0x104f].
   Bus  0, device  20, function  2:
     USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
       IRQ 11.
       Master Capable.  Latency=64.
       I/O at 0x1020 [0x103f].
   Bus  0, device  20, function  3:
     Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 2).
       IRQ 9.
   Bus  1, device   0, function  0:
     VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 130).
       IRQ 11.
       Master Capable.  Latency=64.  Min Gnt=16.Max Lat=32.
       Prefetchable 32 bit memory at 0x42000000 [0x43ffffff].
       Non-prefetchable 32 bit memory at 0x40800000 [0x40803fff].
       Non-prefetchable 32 bit memory at 0x40000000 [0x407fffff].
[root@adlib /root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 597.416
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat p
se36 mmx fxsr sse
bogomips        : 1192.75
[root@adlib /root]# cat /proc/filesystems
nodev   proc
nodev   sockfs
nodev   tmpfs
nodev   shm
nodev   pipefs
         ext2
         msdos
         vfat
         iso9660
nodev   devfs
         umsdos
nodev   devpts
nodev   nfs
[root@adlib /root]# cat /proc/dma
  4: cascade

Kristian

·· · · reach me :: · ·· ·· ·  · ·· · ··  · ··· · ·
                          :: http://www.korseby.net
                          :: http://www.tomlab.de
kristian@korseby.net ....::

