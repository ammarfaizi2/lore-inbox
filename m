Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131197AbQKUUSU>; Tue, 21 Nov 2000 15:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131213AbQKUUSJ>; Tue, 21 Nov 2000 15:18:09 -0500
Received: from [200.230.208.16] ([200.230.208.16]:47364 "EHLO plutao.vb.com.br")
	by vger.kernel.org with ESMTP id <S131197AbQKUUSG>;
	Tue, 21 Nov 2000 15:18:06 -0500
From: "Carlos E. Gorges" <carlos@techlinux.com.br>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4.0-test11 + reiser 3.6.18 
Date: Tue, 21 Nov 2000 17:42:07 -0200
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00112117520600.02749@shark.techlinux>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bug :

sym53c895-0-<8,0>: ordered tag forced.
sym53c895-0-<8,0>: ordered tag forced.
cmpci: write: chip lockup? dmasz 65536 fragsz 1024 count 65536 hwptr 52492 swptr 52492
sym53c895-0-<8,0>: ordered tag forced.
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 8, lun 0 Write (10) 00 00 3c f0 a0 00 00 40 00 
sym53c8xx_abort: pid=0 serial_number=4663 serial_number_at_timeout=4663
sym53c895-0-<8,*>: control msgout: 80 20 2f d.
SCSI disk error : host 0 channel 0 id 8 lun 0 return code = 2505007f
 I/O error: dev 08:01, sector 8640
SCSI disk error : host 0 channel 0 id 8 lun 0 return code = 2505007f
 I/O error: dev 08:01, sector 3993824
SCSI disk error : host 0 channel 0 id 8 lun 0 return code = 2505007f
 I/O error: dev 08:01, sector 8888
journal-601, buffer write failed
kernel BUG at prints.c:330!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0172095>]
EFLAGS: 00010282
eax: 0000001c   ebx: c02dbf80   ecx: c0278068   edx: 00000000
esi: c85e3e1c   edi: c85e3e0c   ebp: 00000000   esp: c85e3de0
ds: 0018   es: 0018   ss: 0018
Process bzip2 (pid: 18112, stackpage=c85e3000)
Stack: c0239ce5 c0239fd4 0000014a d88c315c 000000ca 00000000 d7936e00 c02dc380 
       c85e3e0c c85e3e08 c85e2000 00000000 c017bcd0 d7936e00 c023c4e0 d88e7aa8 
       d88c3078 00000000 d7936e00 d88c3190 d88c3184 00000000 000000cb 00000000 
Call Trace: [<c0239ce5>] [<c0239fd4>] [<d88c315c>] [<c017bcd0>] [<c023c4e0>] [<d88e7aa8>] [<d88c3078>] 
       [<d88c3190>] [<d88c3184>] [<c017c2ff>] [<d88c315c>] [<d88c30b8>] [<c017fab8>] [<d88c3078>] [<d88e8120>] 
       [<c017e1ca>] [<c016aed2>] [<c023d28f>] [<c0171528>] [<c0145445>] [<c0146433>] [<c0125f83>] [<c012603f>] 
       [<c0125f90>] [<c01317a7>] [<c010a637>] 
Code: 0f 0b 83 c4 0c 83 7c 24 28 00 74 17 8b 7c 24 28 80 7f 11 00 
sym53c895-0:8: message d sent on bad reselection.
sym53c895-0:8: message d sent on bad reselection.
sym53c895-0:8: message d sent on bad reselection.
sym53c895-0-<8,0>: ordered tag forced.
sym53c895-0-<8,0>: ordered tag forced.
sym53c895-0-<8,0>: ordered tag forced.
SysRq: unRaw saK Boot Sync Unmount showPc showTasks showMem loglevel0-8 tErm kIll killalL
SysRq: Emergency Sync
Syncing device 03:02 ... OK
Syncing device 08:01 ... <6>SysRq: Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init      S D7FE7F2C  4404     1      0 18110  (NOTLB)        
   sig: 0 0000000000000000 0000000000000000 : X
eventd    S C167A000  6364     2      1        (L-TLB)       3
   sig: 0 0000000000000000 ffffffffffffffff : X
kswapd    S D7EFDFA8  5848     3      1        (L-TLB)       4     2
   sig: 0 0000000000000000 ffffffffffffffff : X
kreclaimd  S 00000286  6364     4      1        (L-TLB)       5     3
   sig: 0 0000000000000000 ffffffffffffffff : X
kflushd   D 00000286  5816     5      1        (L-TLB)       6     4
   sig: 0 0000000000000000 ffffffffffffffff : X
kupdate   D 00000286  5808     6      1        (L-TLB)       7     5
   sig: 0 0000000000000000 fffffffffff9ffff : X
kreiserfsd  D 00000286  5772     7      1        (L-TLB)     423     6
   sig: 0 0000000000000000 ffffffffffffffff : X
syslogd   S 7FFFFFFF     0   423      1        (NOTLB)     444     7
   sig: 0 0000000000000000 0000000000000000 : X
crond     S D722FF88  4500   444      1        (NOTLB)     479   423
   sig: 0 0000000000000000 0000000000000000 : X
gpm       S D6E1BF2C  4564   479      1        (NOTLB)     493   444
   sig: 0 0000000000000000 0000000000000000 : X
xfs       S D6BD7F2C  4932   493      1        (NOTLB)     516   479
   sig: 0 0000000000000000 0000000000000000 : X
login     S 00000000   128   516      1   621  (NOTLB)     517   493
   sig: 0 0000000000000000 0000000000000000 : X
login     S 00000000     0   517      1   701  (NOTLB)     518   516
   sig: 0 0000000000000000 0000000000000000 : X
login     S 00000000     0   518      1   888  (NOTLB)     519   517
   sig: 0 0000000000000000 0000000000000000 : X
login     S 00000000     0   519      1   930  (NOTLB)     520   518
   sig: 0 0000000000000000 0000000000000000 : X
mingetty  S 7FFFFFFF     0   520      1        (NOTLB)     521   519
   sig: 0 0000000000000000 0000000000000000 : X
mingetty  S 7FFFFFFF     0   521      1        (NOTLB)     522   520
   sig: 0 0000000000000000 0000000000000000 : X
mingetty  S 7FFFFFFF    96   522      1        (NOTLB)     523   521
   sig: 0 0000000000000000 0000000000000000 : X
login     S 00000000   128   523      1   526  (NOTLB)    1936   522
   sig: 0 0000000000000000 0000000000000000 : X
bash      S 00000000  5160   526    523  3523  (NOTLB)        
   sig: 0 0000000000000000 0000000000010000 : X
bash      S 00000000    20   621    516 18116  (NOTLB)        
   sig: 0 0000000000000000 0000000000010000 : X
bash      S 7FFFFFFF     0   701    517        (NOTLB)        
   sig: 0 0000000000000000 0000000000000000 : X
bash      S 00000000     0   888    518  2740  (NOTLB)        
   sig: 0 0000000000000000 0000000000010000 : X
bash      S 7FFFFFFF  5160   930    519        (NOTLB)        
   sig: 0 0000000000000000 0000000000000000 : X
kdesud    S C8441F2C     0  1936      1        (NOTLB)   18110   523
   sig: 0 0000000000000000 0000000000000000 : X
wget      D 00000286   572  2740    888        (NOTLB)        
   sig: 1 0000000000000002 0000000000000000 : 2 X
mpg123    D 00000286  2436  3523    526        (NOTLB)        
   sig: 0 0000000000000000 0000000000000000 : X
sh        S 00000000     0 18110      1 18113  (NOTLB)          1936
   sig: 0 0000000000010000 0000000000010000 : 17 X
tar       D 00000286     0 18113  18110        (NOTLB)        
   sig: 1 0000000000000002 0000000000000000 : 2 X
bash      D 00000286     0 18116    621        (NOTLB)        
   sig: 1 0000000000000002 0000000000000000 : 2 X
SysRq: Show Memory
Mem-info:
Free pages:       11300kB (     0kB HighMem)
( Active: 9744, inactive_dirty: 74221, inactive_clean: 790, free: 2825 (383 766 1149) )
1*4kB 1*8kB 1*16kB 1*32kB 0*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB = 956kB)
822*4kB 14*8kB 132*16kB 83*32kB 18*64kB 0*128kB 0*256kB 0*512kB 1*1024kB 0*2048kB = 10344kB)
= 0kB)
Swap cache: add 0, delete 0, find 0/0
Free swap:        80288kB
98288 pages of RAM
0 pages of HIGHMEM
2230 reserved pages
75886 pages shared
0 pages swap cached
0 pages in page table cache
Buffer memory:    49180kB
    CLEAN: 1671 buffers, 6684 kbyte, 143 used (last=1670), 0 locked, 0 protected, 0 dirty
   LOCKED: 37907 buffers, 151628 kbyte, 468 used (last=36997), 162 locked, 0 protected, 0 dirty
sym53c895-0-<8,0>: ordered tag forced.
sym53c895-0-<8,0>: ordered tag forced.

/proc/cpuinfo :
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 548.000549
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
features	: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1094.45

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 548.000549
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
features	: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1094.45

/proc/pci :
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 3).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 3).
      Master Capable.  Latency=64.  Min Gnt=136.
  Bus  0, device   7, function  0:
    ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=64.  
      I/O at 0xf000 [0xf00f].
  Bus  0, device   7, function  2:
    USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
      IRQ 19.
      Master Capable.  Latency=64.  
      I/O at 0xd000 [0xd01f].
  Bus  0, device   7, function  3:
    Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 2).
  Bus  0, device   9, function  0:
    SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c895 (rev 1).
      IRQ 17.
      Master Capable.  Latency=64.  Min Gnt=30.Max Lat=64.
      I/O at 0xd400 [0xd4ff].
      Non-prefetchable 32 bit memory at 0xec000000 [0xec0000ff].
      Non-prefetchable 32 bit memory at 0xec002000 [0xec002fff].
  Bus  0, device  10, function  0:
    Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 48).
      IRQ 18.
      Master Capable.  Latency=64.  Min Gnt=10.Max Lat=10.
      I/O at 0xd800 [0xd87f].
      Non-prefetchable 32 bit memory at 0xec001000 [0xec00107f].
  Bus  0, device  11, function  0:
    Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 16).
      IRQ 19.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=24.
      I/O at 0xdc00 [0xdcff].
  Bus  1, device   0, function  0:
    VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 1).
      IRQ 16.
      Non-prefetchable 32 bit memory at 0xe4000000 [0xe5ffffff].
      Prefetchable 32 bit memory at 0xe8000000 [0xe9ffffff].
      I/O at 0xc000 [0xc0ff].

dmesg :

0 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium III (Katmai) stepping 03
CPU has booted.
Before bogomips.
Total of 2 processors activated (2188.90 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
number of MP IRQ sources: 23.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    0    0   0   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    91
 0f 003 03  0    0    0   0   0    1    1    99
 10 003 03  1    1    0   1   0    1    1    A1
 11 003 03  1    1    0   1   0    1    1    A9
 12 003 03  1    1    0   1   0    1    1    B1
 13 003 03  1    1    0   1   0    1    1    B9
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ10 -> 10
IRQ11 -> 11
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
IRQ16 -> 16
IRQ17 -> 17
IRQ18 -> 18
IRQ19 -> 19
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 548.5791 MHz.
..... host bus clock speed is 99.7414 MHz.
cpu: 0, clocks: 997414, slice: 332471
CPU0<T0:997408,T1:664928,D:9,S:332471,C:997414>
cpu: 1, clocks: 997414, slice: 332471
CPU1<T0:997408,T1:332464,D:2,S:332471,C:997414>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb200, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I9,P0) -> 17
PCI->APIC IRQ transform: (B0,I10,P0) -> 18
PCI->APIC IRQ transform: (B0,I11,P0) -> 19
PCI->APIC IRQ transform: (B0,I12,P0) -> 16
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 90871U2, ATA DISK drive
hdc: CREATIVECD-RW RW8432E, ATAPI CDROM drive
hdd: SAMSUNG SV1364D, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=1027/255/63, UDMA(33)
hdd: 26762400 sectors (13702 MB) w/480KiB Cache, CHS=26550/16/63, UDMA(33)
Partition check:
 hda: hda1 hda2
 hdd: [PTBL] [1665/255/63] hdd1
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
[drm] Initialized tdfx 1.0.0 20000928 on minor 63
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 9, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c895 detected with Tekram NVRAM
sym53c895-0: rev 0x1 on pci bus 0 device 9 function 0 irq 17
sym53c895-0: Tekram format NVRAM, ID 7, Fast-40, Parity Checking
sym53c895-0: on-chip RAM at 0xec002000
sym53c895-0: restart (scsi reset).
sym53c895-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx - version 1.6b
  Vendor: QUANTUM   Model: VIKING II 9.1WLS  Rev: 4110
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym53c895-0-<8,0>: tagged command queue depth set to 4
ncr53c8xx: at PCI bus 0, device 9, function 0
ncr53c8xx: IO region 0xd400[0..127] is in use
Detected scsi disk sda at scsi0, channel 0, id 8, lun 0
sym53c895-0-<8,0>: wide msgout: 1-2-3-1.
sym53c895-0-<8,0>: wide msgin: 1-2-3-1.
sym53c895-0-<8,0>: wide: wide=1 chg=0.
sym53c895-0-<8,0>: wide msgout: 1-2-3-1.
sym53c895-0-<8,0>: wide msgin: 1-2-3-1.
sym53c895-0-<8,0>: wide: wide=1 chg=0.
sym53c895-0-<8,0>: sync msgout: 1-3-1-c-1f.
sym53c895-0-<8,0>: sync msg in: 1-3-1-c-1f.
sym53c895-0-<8,0>: sync: per=12 scntl3=0xb0 scntl4=0x0 ofs=31 fak=0 chg=0.
sym53c895-0-<8,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 31)
SCSI device sda: 17836668 512-byte hdwr sectors (9132 MB)
 sda: sda1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
kmem_create: Forcing size word alignment - nfs_fh
reiserfs: checking transaction log (device 03:02) ...
Warning, log replay starting on readonly filesystem
reiserfs: replayed 5 transactions in 2 seconds
Using tea hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.18
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 240k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 80288k swap-space (priority -1)
reiserfs: checking transaction log (device 08:01) ...
reiserfs: replayed 3 transactions in 3 seconds
Using tea hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.18
cmpci: version v2.41-nomodem time 14:23:18 Nov 20 2000
cmpci: found CM8738 adapter at io 0xdc00 irq 19
3c59x.c:LK1.1.11 13 Nov 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd800,  00:50:04:99:4a:bd, IRQ 18
  8K byte-wide RAM 5:3 Rx:Tx split, 10baseT interface.
  Enabling bus-master transmits and whole-frame receives.
eth0: using default media 10baseT

cya;	
-- 
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
