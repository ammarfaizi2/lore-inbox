Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264686AbUEJNwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264686AbUEJNwa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 09:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264691AbUEJNwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 09:52:30 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:44254 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264686AbUEJNvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 09:51:36 -0400
Message-Id: <200405101351.i4ADpYB03061@www.watkins-home.com>
From: "Guy" <bugzilla@watkins-home.com>
To: <celestar@t-online.de>, <linux-raid@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: RAID5 (along with RAID1) locks up
Date: Mon, 10 May 2004 09:51:28 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <1084182724.409f50c4e752f@modem.webmail.t-online.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcQ2dUKeRgCewK17QQGp/xPQ8zSCqgAIGsNw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see your RAID1 (md0) using sda1, sdb1 and sdc1.
Which disks/partitions is your RAID5 using?

Guy

-----Original Message-----
From: linux-raid-owner@vger.kernel.org
[mailto:linux-raid-owner@vger.kernel.org] On Behalf Of celestar@t-online.de
Sent: Monday, May 10, 2004 5:56 AM
To: linux-raid@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: RAID5 (along with RAID1) locks up

Hello everyone,

I'm having a somewhat large problem with using software RAID, which
occurred in multiple 2.6 kernels I tried (2.6.3, 2.6.4, 2.6.5). I have
three identical disks in the box (all SATA) and have a RAID1 (3 disks)
as root file system, which works flawlessly and I'm trying to set up a
RAID5 over all three disks for some data. When the array is initialized
(during creating or during boot), the machine locks up within 30-60
seconds. no SysRq key combinations work, and NMI watchdog interrupts
are created any more. 

Is this a known problem, or am I messing something up? As I'm not sure
that this is solely a RAID problem, I have sent it to linux-kernel as
well.

As I'm only subscribed to linux-raid, I'd be great if all responses to
go there ;)

Thanks in advance for your time,
Victor

System Information:

1. Hardware

????????????????????????????????????????????????????????????????????????????
???

1.1 procinfo - /usr/bin/procinfo


Linux 2.6.4-54.3-smp (geeko@buildhost) (gcc 3.3.3 ) #1 2CPU
[flmdyna10]
Memory:      Total        Used        Free      Shared     Buffers     

Mem:       1035240      110996      924244           0       18284
Swap:      1590408           0     1590408
Bootup: Fri May  7 06:01:30 2004    Load average: 0.72 0.27 0.09 1/69
3016
user  :       0:00:08.05   6.0%  page in :        0
nice  :       0:00:00.00   0.0%  page out:        0
system:       0:00:11.99   8.9%  swap in :        0
idle  :       0:01:34.33  70.0%  swap out:        0
uptime:       0:01:07.34         context :    34180
irq  0:     66021 timer                 irq 12:         3              
       
irq  1:       319 i8042                 irq 15:        30 ide1         
       
irq  2:         0 cascade [4]           irq 16:        61 uhci_hcd     
       
irq  6:        12                       irq 18:      4156 libata, eth0 
       
irq  8:         2 rtc                   irq 23:      5307 libata       
       
irq  9:         0 acpi                 

????????????????????????????????????????????????????????????????????????????
???

1.2 CPU - /proc/cpuinfo


processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 9
cpu MHz         : 2799.238
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5537.79
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 9
cpu MHz         : 2799.238
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5586.94

????????????????????????????????????????????????????????????????????????????
???

1.3 cmdline - /proc/cmdline


auto BOOT_IMAGE=Linux ro root=900 resume=/dev/sda2 splash=silent
desktop

????????????????????????????????????????????????????????????????????????????
???

1.4 IO-Ports - /proc/ioports


0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
0376-0376 : ide1
03c0-03df : vesafb
0400-041f : 0000:00:1f.3
0cf8-0cff : PCI conf1
b000-bfff : PCI Bus #01
  b000-b0ff : 0000:01:00.0
c000-cfff : PCI Bus #02
  cf80-cf9f : 0000:02:01.0
    cf80-cf9f : e1000
dc00-dc7f : 0000:03:04.0
  dc00-dc7f : sata_promise
df00-df3f : 0000:03:04.0
  df00-df3f : sata_promise
dfa0-dfaf : 0000:03:04.0
  dfa0-dfaf : sata_promise
ef00-ef1f : 0000:00:1d.0
  ef00-ef1f : uhci_hcd
ef90-ef9f : 0000:00:1f.2
  ef90-ef9f : libata
efa0-efa7 : 0000:00:1f.2
  efa0-efa7 : libata
efa8-efab : 0000:00:1f.2
  efa8-efab : libata
efac-efaf : 0000:00:1f.2
  efac-efaf : libata
efe0-efe7 : 0000:00:1f.2
  efe0-efe7 : libata
fc00-fc0f : 0000:00:1f.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1

????????????????????????????????????????????????????????????????????????????
???

1.5 DMA - /proc/dma


 4: cascade

????????????????????????????????????????????????????????????????????????????
???

1.6 devices - /proc/devices


Character devices:
  1 mem
  2 pty
  3 ttyp
  4 /dev/vc/0
  4 tty
  4 ttyS
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  6 lp
  7 vcs
  9 st
 10 misc
 13 input
 29 fb
128 ptm
136 pts
180 usb
188 ttyUSB
Block devices:
  1 ramdisk
  2 fd
  7 loop
  8 sd
  9 md
 11 sr
 22 ide1
 65 sd
 66 sd
 67 sd
 68 sd
 69 sd
 70 sd
 71 sd
128 sd
129 sd
130 sd
131 sd
132 sd
133 sd
134 sd
135 sd
253 device-mapper
254 mdp

????????????????????????????????????????????????????????????????????????????
???

1.7 USB-devices - /proc/bus/usb/devices


file /proc/bus/usb/devices not found

????????????????????????????????????????????????????????????????????????????
???

1.8 lsPCI - /sbin/lspci -vvv


0000:00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev
02)
        Subsystem: Asustek Computer, Inc.: Unknown device 80f6
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f4000000 (32-bit, prefetchable)
        Capabilities: [e4] #09 [2106]
        Capabilities: [a0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit-
FW- Rate=<none>
0000:00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller
(rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: fe800000-fe8fffff
        Prefetchable memory behind bridge: dff00000-efefffff
        Expansion ROM at 0000b000 [disabled] [size=4K]
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
0000:00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA
Bridge (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fe900000-fe9fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        Expansion ROM at 0000c000 [disabled] [size=4K]
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
0000:00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if
00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at ef00 [size=32]
0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev
c2) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fea00000-feafffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller
(rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
0000:00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage
Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at fc00 [size=16]
        Region 5: Memory at 40000000 (32-bit, non-prefetchable)
[size=1K]
0000:00:1f.2 IDE interface: Intel Corp. 82801EB Ultra ATA Storage
Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at efe0
        Region 1: I/O ports at efac [size=4]
        Region 2: I/O ports at efa0 [size=8]
        Region 3: I/O ports at efa8 [size=4]
        Region 4: I/O ports at ef90 [size=16]
0000:00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at 0400 [size=32]
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon
RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA])
        Subsystem: PC Partner Limited: Unknown device 7c28
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 04
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e0000000 (32-bit, prefetchable)
[size=fe8c0000]
        Region 1: I/O ports at b000 [size=256]
        Region 2: Memory at fe8f0000 (32-bit, non-prefetchable)
[size=64K]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit-
FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
0000:02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet
Controller (LOM)
        Subsystem: Asustek Computer, Inc.: Unknown device 80f7
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (63750ns min), cache line size 04
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at fe9e0000 (32-bit, non-prefetchable)
        Region 2: I/O ports at cf80 [size=32]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
0000:03:04.0 RAID bus controller: Promise Technology, Inc.: Unknown
device 3373 (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 80f5
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 96 (1000ns min, 4500ns max), cache line size 91
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at df00
        Region 1: I/O ports at dfa0 [size=16]
        Region 2: I/O ports at dc00 [size=128]
        Region 3: Memory at feafe000 (32-bit, non-prefetchable)
[size=4K]
        Region 4: Memory at feac0000 (32-bit, non-prefetchable)
[size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

lspci - /sbin/lspci -n

0000:00:00.0 Class 0600: 8086:2578 (rev 02)
0000:00:01.0 Class 0604: 8086:2579 (rev 02)
0000:00:03.0 Class 0604: 8086:257b (rev 02)
0000:00:1d.0 Class 0c03: 8086:24d2 (rev 02)
0000:00:1e.0 Class 0604: 8086:244e (rev c2)
0000:00:1f.0 Class 0601: 8086:24d0 (rev 02)
0000:00:1f.1 Class 0101: 8086:24db (rev 02)
0000:00:1f.2 Class 0101: 8086:24d1 (rev 02)
0000:00:1f.3 Class 0c05: 8086:24d3 (rev 02)
0000:01:00.0 Class 0300: 1002:5159
0000:02:01.0 Class 0200: 8086:1019
0000:03:04.0 Class 0104: 105a:3373 (rev 02)


1.11 Hardisk

????????????????????????????????????????????????????????????????????????????
???

1.11 partitions - /sbin/fdisk -l
Disk /dev/sda: 251.0 GB, 251000193024 bytes
255 heads, 63 sectors/track, 30515 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
   Device Boot      Start         End      Blocks   Id  System
/dev/sda1               1        1959    15735636   fd  Linux raid
autodetect
/dev/sda2            1960        2025      530145   82  Linux swap
Disk /dev/sdb: 251.0 GB, 251000193024 bytes
255 heads, 63 sectors/track, 30515 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1        1959    15735636   fd  Linux raid
autodetect
/dev/sdb2            1960        2025      530145   82  Linux swap
Disk /dev/sdc: 251.0 GB, 251000193024 bytes
255 heads, 63 sectors/track, 30515 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
   Device Boot      Start         End      Blocks   Id  System
/dev/sdc1               1        1959    15735636   fd  Linux raid
autodetect
/dev/sdc2            1960        2025      530145   82  Linux swap

????????????????????????????????????????????????????????????????????????????
???

1.12 Mountpoints - /bin/mount


/dev/md0 on / type reiserfs (rw,acl,user_xattr)
proc on /proc type proc (rw)
tmpfs on /dev/shm type tmpfs (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
/dev/hdc on /media/dvd type subfs
(ro,nosuid,nodev,fs=cdfss,procuid,iocharset=utf8)
/dev/fd0 on /media/floppy type subfs
(rw,nosuid,nodev,sync,fs=floppyfss,procuid)
usbfs on /proc/bus/usb type usbfs (rw)
automount(pid2297) on /home type autofs
(rw,fd=5,pgrp=2297,minproto=2,maxproto=3)
automount(pid2301) on /net type autofs
(rw,fd=5,pgrp=2301,minproto=2,maxproto=3)
automount(pid2299) on /ptmp type autofs
(rw,fd=5,pgrp=2299,minproto=2,maxproto=3)

????????????????????????????????????????????????????????????????????????????
???

1.13 fstab - /etc/fstab



     
/dev/md0             /                    reiserfs   acl,user_xattr    
   1 1
/dev/sda2            swap                 swap       pri=42            
   0 0
/dev/sdb2            swap                 swap       pri=42            
   0 0
/dev/sdc2            swap                 swap       pri=42            
   0 0
devpts               /dev/pts             devpts     mode=0620,gid=5   
   0 0
proc                 /proc                proc       defaults          
   0 0
usbfs                /proc/bus/usb        usbfs      noauto            
   0 0
sysfs                /sys                 sysfs      noauto            
   0 0
/dev/dvd             /media/dvd           subfs     
fs=cdfss,ro,procuid,nosuid,nodev,exec,iocharset=utf8 0 0
/dev/fd0             /media/floppy        subfs     
fs=floppyfss,procuid,nodev,nosuid,sync 0 0

     
????????????????????????????????????????????????????????????????????????????
???

1.14 Settings
name                    value           min             max            
mode
----                    -----           ---             ---            
----
current_speed           0               0               70             
rw
dsc_overlap             0               0               1              
rw
ide-scsi                0               0               1              
rw
init_speed              0               0               70             
rw
io_32bit                0               0               3              
rw
keepsettings            0               0               1              
rw
nice1                   1               0               1              
rw
number                  2               0               3              
rw
pio_mode                write-only      0               255            
w
unmaskirq               0               0               1              
rw
using_dma               0               0               1              
rw

????????????????????????????????????????????????????????????????????????????
???

1.16 scsi - /usr/sbin/hwinfo --scsi


14: SCSI 100.0: 10600 Disk
  [Created at block.190]
  Unique ID: _q_W.qQBd_Nltq75
  Parent ID: w7Y8.h+1RGPD0E57
  SysFS ID: /block/sda
  SysFS BusID: 1:0:0:0
  SysFS Device Link: /devices/pci0000:00/0000:00:1f.2/host1/1:0:0:0
  Hardware Class: disk
  Model: "ATA Maxtor 7Y250M0"
  Vendor: "ATA"
  Device: "Maxtor 7Y250M0"
  Revision: "1.02"
  Serial ID: "Y62BSWNE"
  Driver: "ata_piix", "sd"
  Device File: /dev/sda
  Device Number: block 8:0-8:15
  Geometry (Logical): CHS 30515/255/63
  Size: 490234752 sectors a 512 bytes
  Config Status: cfg=new, avail=yes, need=no, active=unknown
  Attached to: #8 (IDE interface)
15: SCSI 200.0: 10600 Disk
  [Created at block.190]
  Unique ID: R0Fb.iHV+UMtQHFC
  Parent ID: AMUB.Riy0go04uj1
  SysFS ID: /block/sdb
  SysFS BusID: 2:0:0:0
  SysFS Device Link:
/devices/pci0000:00/0000:00:1e.0/0000:03:04.0/host2/2:0:0:0
  Hardware Class: disk
  Model: "ATA Maxtor 7Y250M0"
  Vendor: "ATA"
  Device: "Maxtor 7Y250M0"
  Revision: "1.02"
  Serial ID: "Y62BAYFE"
  Driver: "sata_promise", "sd"
  Device File: /dev/sdb
  Device Number: block 8:16-8:31
  Geometry (Logical): CHS 30515/255/63
  Size: 490234752 sectors a 512 bytes
  Config Status: cfg=yes, avail=yes, need=no, active=unknown
  Attached to: #12 (RAID bus controller)
16: SCSI 300.0: 10600 Disk
  [Created at block.190]
  Unique ID: uBVf.0SX1qJ8tfr7
  Parent ID: AMUB.Riy0go04uj1
  SysFS ID: /block/sdc
  SysFS BusID: 3:0:0:0
  SysFS Device Link:
/devices/pci0000:00/0000:00:1e.0/0000:03:04.0/host3/3:0:0:0
  Hardware Class: disk
  Model: "ATA Maxtor 7Y250M0"
  Vendor: "ATA"
  Device: "Maxtor 7Y250M0"
  Revision: "1.02"
  Serial ID: "Y62BT08E"
  Driver: "sata_promise", "sd"
  Device File: /dev/sdc
  Device Number: block 8:32-8:47
  Geometry (Logical): CHS 30515/255/63
  Size: 490234752 sectors a 512 bytes
  Config Status: cfg=yes, avail=yes, need=no, active=unknown
  Attached to: #12 (RAID bus controller)
-
To unsubscribe from this list: send the line "unsubscribe linux-raid" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


