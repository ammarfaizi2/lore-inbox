Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135435AbRDMHZL>; Fri, 13 Apr 2001 03:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135433AbRDMHZE>; Fri, 13 Apr 2001 03:25:04 -0400
Received: from danielle.hinet.hr ([195.29.254.157]:6154 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S135437AbRDMHYs>; Fri, 13 Apr 2001 03:24:48 -0400
Date: Fri, 13 Apr 2001 09:24:47 +0200
From: Mario Mikocevic <mozgy@hinet.hr>
To: linux-kernel@vger.kernel.org
Subject: I need help ! (COMPAQ Proliant 6500 hangs, 2.4.3 kernel)
Message-ID: <20010413092447.A6269@danielle.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

well, it happened again !

Just before complete hang I gathered some data ->
(sorry for being it long)

[root@ls203 /root]# hwclock --show
Thu Apr 12 20:13:20 2001  0.089248 seconds
[root@ls203 /root]# 
[root@ls203 /root]# 
[root@ls203 /root]# date
Thu Apr 12 19:34:32 CEST 2001
[root@ls203 /root]# date
Thu Apr 12 19:34:32 CEST 2001
[root@ls203 /root]# date
Thu Apr 12 19:34:32 CEST 2001
[root@ls203 /root]# 
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/driver/rtc
rtc_time        : 20:14:34
rtc_date        : 2001-04-12
rtc_epoch       : 1900
alarm           : 00:00:00
DST_enable      : no
BCD             : yes
24hr            : yes
square_wave     : no
alarm_IRQ       : no
update_IRQ      : no
periodic_IRQ    : no
periodic_freq   : 1024
batt_status     : okay

[root@ls203 /root]# cat /proc/driver/rtc
rtc_time        : 20:14:35
rtc_date        : 2001-04-12
rtc_epoch       : 1900
alarm           : 00:00:00
DST_enable      : no
BCD             : yes
24hr            : yes
square_wave     : no
alarm_IRQ       : no
update_IRQ      : no
periodic_IRQ    : no
periodic_freq   : 1024
batt_status     : okay
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 499.870
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 996.14

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 499.870
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 999.42

[root@ls203 /root]# cat /proc/devices
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
  7 vcs
 10 misc
 21 sg
 89 i2c
109 lvm
128 ptm
136 pts
162 raw
202 cpu/msr
203 cpu/cpuid

Block devices:
  3 ide0
  8 sd
 58 lvm
 65 sd
 66 sd
 80 i2o_block

[root@ls203 /root]# cat /proc/dma
 4: cascade

[root@ls203 /root]# cat /proc/interrupts
           CPU0       CPU1       
  0:    4900732    4896887    IO-APIC-edge  timer
  1:        707        663    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  5:   28417491   28419598   IO-APIC-level  eth0
  8:          2          3    IO-APIC-edge  rtc
 10:     139457     138541   IO-APIC-level  sym53c8xx
 11:         13         17   IO-APIC-level  sym53c8xx
 12:        135        120    IO-APIC-edge  PS/2 Mouse
 14:          3          3    IO-APIC-edge  ide0
 15:     393468     393603   IO-APIC-level  eth1
NMI:          0          0 
LOC:    9797478    9797477 
ERR:          0

[root@ls203 /root]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000f0000-000fffff : System ROM
00100000-1fffbfff : System RAM
  00100000-00223d11 : Kernel code
  00223d12-0029bd5f : Kernel data
1fffc000-1fffffff : ACPI Tables
c5000000-c5ffffff : ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
c6990000-c6990fff : ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
c69a0000-c69a0fff : Symbios Logic Inc. (formerly NCR) 53c875 (#2)
c69b0000-c69b00ff : Symbios Logic Inc. (formerly NCR) 53c875 (#2)
c69c0000-c69c0fff : Symbios Logic Inc. (formerly NCR) 53c875
c69d0000-c69d00ff : Symbios Logic Inc. (formerly NCR) 53c875
c69e0000-c69e00ff : Compaq Computer Corporation Advanced System Management Controller
c69f0000-c69f00ff : Compaq Computer Corporation PCI Hotplug Controller
c6a00000-c6afffff : PCI Bus #05
  c6ae0000-c6ae0fff : Intel Corporation 82557 [Ethernet Pro 100] (#3)
    c6ae0000-c6ae0fff : eepro100
  c6af0000-c6af0fff : Intel Corporation 82557 [Ethernet Pro 100] (#2)
    c6af0000-c6af0fff : eepro100
c6bf0000-c6bf00ff : Compaq Computer Corporation PCI Hotplug Controller (#2)
c6c00000-c6cfffff : Intel Corporation 82557 [Ethernet Pro 100]
c6df0000-c6df0fff : Intel Corporation 82557 [Ethernet Pro 100]
  c6df0000-c6df0fff : eepro100
c6e00000-c6ffffff : PCI Bus #05
  c6e00000-c6efffff : Intel Corporation 82557 [Ethernet Pro 100] (#3)
  c6f00000-c6ffffff : Intel Corporation 82557 [Ethernet Pro 100] (#2)
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
fff80000-ffffffff : reserved
[root@ls203 /root]# 
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1200-123f : Intel Corporation 82371AB PIIX4 ACPI
1240-125f : Intel Corporation 82371AB PIIX4 ACPI
1800-18ff : Compaq Computer Corporation Advanced System Management Controller
2000-20ff : Symbios Logic Inc. (formerly NCR) 53c875
  2000-207f : sym53c8xx
2400-24ff : Symbios Logic Inc. (formerly NCR) 53c875 (#2)
  2400-247f : sym53c8xx
2800-28ff : ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
2c00-2c0f : Intel Corporation 82371AB PIIX4 IDE
  2c00-2c07 : ide0
2c20-2c3f : Intel Corporation 82371AB PIIX4 USB
3000-303f : Intel Corporation 82557 [Ethernet Pro 100]
  3000-303f : eepro100
4000-4fff : PCI Bus #05
  4000-401f : Intel Corporation 82557 [Ethernet Pro 100] (#2)
    4000-401f : eepro100
  4020-403f : Intel Corporation 82557 [Ethernet Pro 100] (#3)
    4020-403f : eepro100
[root@ls203 /root]# cat /proc/loadavg
0.09 0.08 0.06 1/322 16657
[root@ls203 /root]# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  525467648 450908160 74559488        0  3760128 228630528
Swap: 537911296        0 537911296
MemTotal:       513152 kB
MemFree:         72812 kB
MemShared:           0 kB
Buffers:          3672 kB
Cached:         223272 kB
Active:           9920 kB
Inact_dirty:    216636 kB
Inact_clean:       388 kB
Inact_target:      120 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513152 kB
LowFree:         72812 kB
SwapTotal:      525304 kB
SwapFree:       525304 kB
[root@ls203 /root]# cat /proc/misc
135 rtc
166 i2octl
  1 psaux
[root@ls203 /root]# cat /proc/modules
eepro100               17456   2 (autoclean)
[root@ls203 /root]# cat /proc/mounts
/dev/root / ext2 rw 0 0
/proc /proc proc rw 0 0
/dev/sda1 /boot ext2 rw 0 0
/dev/sda8 /home ext2 rw 0 0
/dev/sda7 /opt ext2 rw 0 0
/dev/sda5 /usr ext2 rw 0 0
/dev/sda6 /var ext2 rw 0 0
none /dev/pts devpts rw 0 0
/dev/lvmdsk/web /mnt/web ext2 rw 0 0
/dev/lvmdsk/log /var/weblog ext2 rw 0 0
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0x400020000 (16384MB), size=  64KB: uncachable, count=1
reg02: base=0x400040000 (16384MB), size=  64KB: uncachable, count=1
reg03: base=0x400060000 (16384MB), size=  64KB: uncachable, count=1
reg04: base=0x400080000 (16384MB), size=  64KB: uncachable, count=1
reg05: base=0x4000a0000 (16384MB), size=  64KB: uncachable, count=1
reg06: base=0x4000c0000 (16384MB), size=  64KB: uncachable, count=1
reg07: base=0x4000e0000 (16384MB), size=  64KB: uncachable, count=1
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/partitions
major minor  #blocks  name

   8     0    8886750 sda
   8     1      66544 sda1
   8     2     525312 sda2
   8     3     525312 sda3
   8     4          1 sda4
   8     5    3145712 sda5
   8     6    2097136 sda6
   8     7    1048560 sda7
   8     8    1477616 sda8
   8    16    8886750 sdb
   8    17    8883913 sdb1
   8    32    8886750 sdc
   8    33    8883913 sdc1
  58     0    8192000 lvma
  58     1    9568256 lvmb
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/pci
PCI devices found:
  Bus  0, device  11, function  0:
    PCI Hot-plug controller: Compaq Computer Corporation PCI Hotplug Controller (rev 4).
      IRQ 9.
      Non-prefetchable 32 bit memory at 0xc69f0000 [0xc69f00ff].
  Bus  4, device  11, function  0:
    PCI Hot-plug controller: Compaq Computer Corporation PCI Hotplug Controller (#2) (rev 4).
      IRQ 9.
      Non-prefetchable 32 bit memory at 0xc6bf0000 [0xc6bf00ff].
  Bus  0, device  12, function  0:
    System peripheral: Compaq Computer Corporation Advanced System Management Controller (rev 0).
      I/O at 0x1800 [0x18ff].
      Non-prefetchable 32 bit memory at 0xc69e0000 [0xc69e00ff].
  Bus  0, device  13, function  0:
    SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 20).
      IRQ 10.
      Master Capable.  Latency=255.  Min Gnt=17.Max Lat=64.
      I/O at 0x2000 [0x20ff].
      Non-prefetchable 32 bit memory at 0xc69d0000 [0xc69d00ff].
      Non-prefetchable 32 bit memory at 0xc69c0000 [0xc69c0fff].
  Bus  0, device  13, function  1:
    SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (#2) (rev 20).
      IRQ 11.
      Master Capable.  Latency=255.  Min Gnt=17.Max Lat=64.
      I/O at 0x2400 [0x24ff].
      Non-prefetchable 32 bit memory at 0xc69b0000 [0xc69b00ff].
      Non-prefetchable 32 bit memory at 0xc69a0000 [0xc69a0fff].
  Bus  0, device  14, function  0:
    VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC] (rev 122).
      Master Capable.  Latency=64.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xc5000000 [0xc5ffffff].
      I/O at 0x2800 [0x28ff].
      Non-prefetchable 32 bit memory at 0xc6990000 [0xc6990fff].
  Bus  0, device  15, function  0:
    ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 2).
  Bus  0, device  15, function  1:
    IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=64.  
      I/O at 0x2c00 [0x2c0f].
  Bus  0, device  15, function  2:
    USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
      Master Capable.  Latency=64.  
      I/O at 0x2c20 [0x2c3f].
  Bus  0, device  15, function  3:
    Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 2).
      IRQ 9.
  Bus  0, device  16, function  0:
    Host bridge: Intel Corporation 450NX - 82451NX Memory & I/O Controller (rev 3).
  Bus  4, device   2, function  0:
    PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 2).
      Master Capable.  Latency=64.  Min Gnt=7.
  Bus  4, device   3, function  0:
    Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 8).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xc6df0000 [0xc6df0fff].
      I/O at 0x3000 [0x303f].
      Non-prefetchable 32 bit memory at 0xc6c00000 [0xc6cfffff].
  Bus  5, device   4, function  0:
    Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (#2) (rev 5).
      IRQ 15.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
      Prefetchable 32 bit memory at 0xc6af0000 [0xc6af0fff].
      I/O at 0x4000 [0x401f].
      Non-prefetchable 32 bit memory at 0xc6f00000 [0xc6ffffff].
  Bus  5, device   5, function  0:
    Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (#3) (rev 5).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
      Prefetchable 32 bit memory at 0xc6ae0000 [0xc6ae0fff].
      I/O at 0x4020 [0x403f].
      Non-prefetchable 32 bit memory at 0xc6e00000 [0xc6efffff].
  Bus  0, device  18, function  0:
    Host bridge: Intel Corporation 450NX - 82454NX/84460GX PCI Expander Bridge (rev 4).
  Bus  0, device  20, function  0:
    Host bridge: Intel Corporation 450NX - 82454NX/84460GX PCI Expander Bridge (#2) (rev 4).
[root@ls203 /root]# cat /proc/slabinfo
slabinfo - version: 1.1 (SMP)
kmem_cache            68     68    232    4    4    1 :  252  126
tcp_tw_bucket        834    960     96   24   24    1 :  252  126
tcp_bind_bucket      226    226     32    2    2    1 :  252  126
tcp_open_request    1062   1062     64   18   18    1 :  252  126
inet_peer_cache        0      0     64    0    0    1 :  252  126
ip_fib_hash           75    226     32    2    2    1 :  252  126
ip_dst_cache        6816   6816    160  284  284    1 :  252  126
arp_cache             60     60    128    2    2    1 :  252  126
blkdev_requests     5120   5240     96  128  131    1 :  252  126
dnotify cache          0      0     20    0    0    1 :  252  126
file lock cache       84     84     92    2    2    1 :  252  126
fasync cache           0      0     16    0    0    1 :  252  126
uid_cache            115    226     32    2    2    1 :  252  126
skbuff_head_cache  11160  11160    160  465  465    1 :  252  126
sock                1100   1100    800  220  220    1 :  124   62
inode_cache       189200 189200    480 23650 23650    1 :  124   62
bdev_cache         10941  10974     64  186  186    1 :  252  126
sigqueue             183    435    132   10   15    1 :  252  126
kiobuf                 0      0    128    0    0    1 :  252  126
dentry_cache      216780 216780    128 7226 7226    1 :  252  126
filp                2400   2440     96   61   61    1 :  252  126
names_cache           11     11   4096   11   11    1 :   60   30
buffer_head        56729  87520     96 1419 2188    1 :  252  126
mm_struct            474    600    160   25   25    1 :  252  126
vm_area_struct      7068  10974     64  169  186    1 :  252  126
fs_cache             581    649     64   11   11    1 :  252  126
files_cache          391    495    416   51   55    1 :  124   62
signal_act           303    393   1312  129  131    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             1      1  65536    1    1   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             0      0  32768    0    0    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384             1      4  16384    1    4    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              0      0   8192    0    0    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096             26     26   4096   26   26    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048           2888   2888   2048 1444 1444    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024           3516   3516   1024  879  879    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             280    280    512   35   35    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256            3825   3825    256  255  255    1 :  252  126
size-128(DMA)          0      0    128    0    0    1 :  252  126
size-128            1590   1590    128   53   53    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64             5546   5546     64   94   94    1 :  252  126
size-32(DMA)           0      0     32    0    0    1 :  252  126
size-32            25764  25764     32  228  228    1 :  252  126
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/stat
cpu  507632 52 743914 18426156
cpu0 252239 35 220674 9365929
cpu1 255393 17 523240 9060227
page 4053078 2084716
swap 1 0
intr 67795405 9838877 1370 0 4 4 56889712 0 0 5 0 278012 30 255 0 6 787130 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
disk_io: (8,0):(56156,13468,485280,42688,407216) (8,1):(168483,83157,7377562,85326,3488680) (8,2):(42224,17023,243314,25201,273536) 
ctxt 109250500
btime 986998484
processes 146411
[root@ls203 /root]# cat /proc/swaps
Filename                        Type            Size    Used    Priority
/dev/sda3                       partition       525304  0       -1
[root@ls203 /root]# cat /proc/version
Linux version 2.4.3-lvm (root@ls203.hinet.hr) (gcc version 2.96 20000731 (Red Hat Linux 7.0)) #6 SMP Wed Apr 4 13:44:44 CEST 2001
[root@ls203 /root]# 
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/bus/pci/devices
0058    0e11a0f7        9       c69f0000        00000000        00000000       00000000 00000000        00000000        00000000        00000100        00000000
        00000000        00000000        00000000        00000000        00000000

0458    0e11a0f7        9       c6bf0000        00000000        00000000       00000000 00000000        00000000        00000000        00000100        00000000
        00000000        00000000        00000000        00000000        00000000

0060    0e11a0f0        0       00001801        c69e0000        00000000       00000000 00000000        00000000        00000000        00000100        00000100
        00000000        00000000        00000000        00000000        00000000

0068    1000000f        a       00002001        c69d0000        c69c0000       00000000 00000000        00000000        00000000        00000100        00000100
        00001000        00000000        00000000        00000000        00000000

0069    1000000f        b       00002401        c69b0000        c69a0000       00000000 00000000        00000000        00000000        00000100        00000100
        00001000        00000000        00000000        00000000        00000000

0070    10024756        0       c5000008        00002801        c6990000       00000000 00000000        00000000        00000000        01000000        00000100
        00001000        00000000        00000000        00000000        00020000

0078    80867110        0       00000000        00000000        00000000       00000000 00000000        00000000        00000000        00000000        00000000
        00000000        00000000        00000000        00000000        00000000

0079    80867111        0       00000000        00000000        00000000       00000000 00002c01        00000000        00000000        00000000        00000000
        00000000        00000000        00000010        00000000        00000000

007a    80867112        0       00000000        00000000        00000000       00000000 00002c21        00000000        00000000        00000000        00000000
        00000000        00000000        00000020        00000000        00000000

007b    80867113        9       00000000        00000000        00000000       00000000 00000000        00000000        00000000        00000000        00000000
        00000000        00000000        00000000        00000000        00000000

0080    808684ca        0       00000000        00000000        00000000       00000000 00000000        00000000        00000000        00000000        00000000
        00000000        00000000        00000000        00000000        00000000

0410    10110026        0       00000000        00000000        00000000       00000000 00000000        00000000        00000000        00000000        00000000
        00000000        00000000        00000000        00000000        00000000

0418    80861229        5       c6df0000        00003001        c6c00000       00000000 00000000        00000000        00000000        00001000        00000040
        00100000        00000000        00000000        00000000        00100000
        eepro100
0520    80861229        f       c6af0008        00004001        c6f00000       00000000 00000000        00000000        00000000        00001000        00000020
        00100000        00000000        00000000        00000000        00000000
        eepro100
0528    80861229        5       c6ae0008        00004021        c6e00000       00000000 00000000        00000000        00000000        00001000        00000020
        00100000        00000000        00000000        00000000        00000000
        eepro100
0090    808684cb        0       00000000        00000000        00000000       00000000 00000000        00000000        00000000        00000000        00000000
        00000000        00000000        00000000        00000000        00000000

00a0    808684cb        0       00000000        00000000        00000000       00000000 00000000        00000000        00000000        00000000        00000000
        00000000        00000000        00000000        00000000        00000000

[root@ls203 /root]# cat /proc/lvm/global
LVM driver version 0.9.1_beta6 (12/03/2001)

Total:  1 VG  2 PVs  2 LVs (2 LVs open 2 times)

Global: 74146 bytes malloced   IOP version: 10   1 day 1:24:20 active

VG:  lvmdsk  [2 PV, 2 LV/2 open]  PE Size: 4096 KB
  Usage [KB/PE]: 17760256 /4336 total  17760256 /4336 used  0 /0 free
  PVs: [AA] sdb1                   8880128 /2168     8880128 /2168           0 /0     
       [AA] sdc1                   8880128 /2168     8880128 /2168           0 /0     
    LVs: [AWDL  ] web                        8192000 /2000     1x open
         [AWDL  ] log                        9568256 /2336     1x open
[root@ls203 /root]# ls /proc/lvm/VGs/lvmdsk/LVs
log  web
[root@ls203 /root]# 
[root@ls203 /root]# ls /proc/irq
0  1  10  11  12  13  14  15  2  3  4  5  6  7  8  9  prof_cpu_mask
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/irq/prof_cpu_mask
ffffffff
[root@ls203 /root]# 
[root@ls203 /root]# 
[root@ls203 /root]# ls /proc/i2o
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/ide/drivers
ide-cdrom version 4.59
ide-disk version 1.10
[root@ls203 /root]# 
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/ide/piix

                                Intel PIIX4 Ultra 33 Chipset.
--------------- Primary Channel ---------------- Secondary Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              no              no                no 
UDMA enabled:   yes              no              no                no 
UDMA enabled:   2                X               X                 X
UDMA
DMA
PIO
[root@ls203 /root]# 
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/net//dev
Inter-|   Receive                                                |  Transmit
 face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
    lo: 9184213    3773    0    0    0     0          0         0  9184213    3773    0    0    0     0       0          0
  eth0:4167514917 33635056    0    0    0     0          0         0 400368427 39654789    0    0    0     0       0          0
  eth1:32730758  528404    0    0    0     0          0         0 1485552823  984226    0    0    0     0       0          0
  eth2:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/net/netstat
TcpExt: SyncookiesSent SyncookiesRecv SyncookiesFailed EmbryonicRsts PruneCalled RcvPruned OfoPruned OutOfWindowIcmps LockDroppedIcmps TW TWRecycled TWKilled PAWSPassive PAWSActive PAWSEstab DelayedACKs DelayedACKLocked DelayedACKLost ListenOverflows ListenDrops TCPPrequeued TCPDirectCopyFromBacklog TCPDirectCopyFromPrequeue TCPPrequeueDropped TCPHPHits TCPHPHitsToUser TCPPureAcks TCPHPAcks TCPRenoRecovery TCPSackRecovery TCPSACKReneging TCPFACKReorder TCPSACKReorder TCPRenoReorder TCPTSReorder TCPFullUndo TCPPartialUndo TCPDSACKUndo TCPLossUndo TCPLoss TCPLostRetransmit TCPRenoFailures TCPSackFailures TCPLossFailures TCPFastRetrans TCPForwardRetrans TCPSlowStartRetrans TCPTimeouts TCPRenoRecoveryFail TCPSackRecoveryFail TCPSchedulerFailed TCPRcvCollapsed TCPDSACKOldSent TCPDSACKOfoSent TCPDSACKRecv TCPDSACKOfoRecv TCPAbortOnSyn TCPAbortOnData TCPAbortOnClose TCPAbortOnMemory TCPAbortOnTimeout TCPAbortOnLinger TCPAbortFailed TCPMemoryPressures
TcpExt: 0 0 0 19242 100 0 0 0 0 635078 0 0 0 0 322 13092 83 107483 3843 3843 19130145 347534 1926801828 0 45942 3950673 10603272 11230403 5934 99476 1 1754 169 619 119 515 836 4 2569 60447 55 12785 83858 6636 133853 8523 347996 292125 863 32319 2 344 86375 0 78385 0 1 253868 369 0 4024 0 0 0



[root@ls203 /root]# cat /proc/net/raw
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                               
   1: 00000000:0001 00000000:0000 07 00000000:0000939C 00:00000000 00000000     0        0 213015 2 df9e8040                   
   6: 00000000:0006 00000000:0000 07 00000000:0000FF48 00:00000000 00000000     0        0 213016 2 d9e34040                   
  17: 00000000:0011 00000000:0000 07 00000000:0000FFE8 00:00000000 00000000     0        0 213018 2 d9e5d040                   
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/net/unix
Num       RefCount Protocol Flags    Type St Inode Path
df8b49a0: 00000002 00000000 00010000 0001 01  2056 /dev/gpmctl
df474cc0: 00000023 00000000 00000000 0002 01   916 /dev/log
d5adc040: 00000002 00000000 00000000 0002 01 2482652
d5adccc0: 00000002 00000000 00000000 0002 01 2482638
d7e90040: 00000002 00000000 00000000 0002 01 2482281
d7e909a0: 00000002 00000000 00000000 0002 01 2482276
c52ba680: 00000002 00000000 00000000 0002 01 2481934
d0f02040: 00000002 00000000 00000000 0002 01 2481929
cf8c0680: 00000002 00000000 00000000 0002 01 2481907
ce25f040: 00000002 00000000 00000000 0002 01 2481902
ce25f9a0: 00000002 00000000 00000000 0002 01 2481897
cfb63cc0: 00000002 00000000 00000000 0002 01 2481885
db403680: 00000002 00000000 00000000 0002 01 2478956
dbe46040: 00000002 00000000 00000000 0002 01 2478945
dbe469a0: 00000002 00000000 00000000 0002 01 2478939
c6dba360: 00000002 00000000 00000000 0002 01 2478918
d7ad9040: 00000002 00000000 00000000 0002 01 2478591
d7ad99a0: 00000002 00000000 00000000 0002 01 2476351
d2673040: 00000002 00000000 00000000 0002 01 2475970
cb187360: 00000002 00000000 00000000 0002 01 2475960
ddae6040: 00000002 00000000 00000000 0002 01 2475954
ddae6cc0: 00000002 00000000 00000000 0002 01 2475948
c30ba360: 00000002 00000000 00000000 0002 01 2475938
cd3f2cc0: 00000002 00000000 00000000 0002 01 2472442
c677a680: 00000002 00000000 00000000 0002 01 2472365
d9402360: 00000002 00000000 00000000 0002 01 2472358
d0e0d040: 00000002 00000000 00000000 0002 01 2472347
d4ebe360: 00000002 00000000 00000000 0002 01 2472276
d4ebecc0: 00000002 00000000 00000000 0002 01 2472271
d9dde040: 00000002 00000000 00000000 0002 01 1426207
dc6b8040: 00000002 00000000 00000000 0002 01 213017
df3189a0: 00000002 00000000 00000000 0002 01  2480
df8b4cc0: 00000002 00000000 00000000 0002 01  2241
df474360: 00000002 00000000 00000000 0002 01  1142
df318040: 00000002 00000000 00000000 0002 01  1019
df9af9a0: 00000002 00000000 00000000 0001 03   410
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: COMPAQ   Model: AB00931B92       Rev: 3A07
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: COMPAQ   Model: AB00931B92       Rev: 3A07
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: COMPAQ   Model: AB00931B92       Rev: 3A07
  Type:   Direct-Access                    ANSI SCSI revision: 02
[root@ls203 /root]# 
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/scsi/sg/devices
0       0       0       0       0       7       8       0
0       0       1       0       0       0       8       0
0       0       2       0       0       0       8       0
[root@ls203 /root]# cat /proc/scsi/sg/hosts
8192    0       32      127     0       0
9216    0       32      127     0       0
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/scsi/sg/version
30117   Version: 3.1.17 (20001002)
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/scsi/sym53c8xx/0
General information:
  Chip sym53c875, device id 0xf, revision id 0x14
  On PCI bus 0, device 13, function 0, IRQ 10
  Synchronous period factor 12, max commands per lun 32
[root@ls203 /root]# cat /proc/sysvipc/msg
       key      msqid perms      cbytes       qnum lspid lrpid   uid   gid  cuid  cgid      stime      rtime      ctime
1752331826     131072   600           0          0 29019 13221     0     0     0     0  987096872  987096872  987046601
1752331825     163841   600           0          0 16711     0     0     0     0     0  987096872  987096872  987046601
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/sysvipc/sem
       key      semid perms      nsems   uid   gid  cuid  cgid      otime      ctime
         0      65536   600          1    48    48     0     0  987096872  987084061
[root@ls203 /root]# 
[root@ls203 /root]# cat /proc/sysvipc/shm
       key      shmid perms       size  cpid  lpid nattch   uid   gid  cuid  cgid      atime      dtime      ctime
         0          0  1600     368644   708 16497    182    48    48     0     0  987096866  987096872  986998242
[root@ls203 /root]# 
[root@ls203 /root]# 
[root@ls203 scripts]# sh ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux ls203.hinet.hr 2.4.3-lvm #6 SMP Wed Apr 4 13:44:44 CEST 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.10m
modutils               2.4.2
e2fsprogs              1.19
Linux C Library        > libc.2.2
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         eepro100


-- 
Mario Mikoèeviæ (Mozgy)
My favourite FUBAR ...
