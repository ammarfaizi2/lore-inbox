Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130442AbRCTPwu>; Tue, 20 Mar 2001 10:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130439AbRCTPwb>; Tue, 20 Mar 2001 10:52:31 -0500
Received: from passat.ndh.net ([195.94.90.26]:54209 "EHLO passat.ndh.net")
	by vger.kernel.org with ESMTP id <S130432AbRCTPw3>;
	Tue, 20 Mar 2001 10:52:29 -0500
Date: Tue, 20 Mar 2001 16:52:15 +0100
From: Alexander Riesen <ariesen@traian.de>
To: linux-kernel@vger.kernel.org
Subject: [CRASH] 2.4.2-ac20: kernel: memory.c:83: bad pmd 4f433232.
Message-ID: <20010320165215.A429@traian.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all

Simply crashed. No oops-screens. And fast rebooted :)
Under middle load. Nothing serious.
Workstation, running XFree86 4.0.2,
simple programs eating megabytes.

Alex Riesen
Traian AG

P.S.:

>From syslog:
Mar 20 15:41:48 ws018 -- MARK --
Mar 20 15:49:00 ws018 kernel: emory.c:83: bad pmd 5f454341.
Mar 20 15:49:00 ws018 kernel: memory.c:83: bad pmd 68736148.
... a while
Mar 20 15:49:01 ws018 kernel: memory.c:83: bad pmd 4f433232.
Mar 20 15:49:01 ws018 kernel: memory.c:83: bad pmd 5f414252.
... some normal activity
<crash>
Mar 20 16:10:19 ws018 syslogd 1.3-3#33: restart (remote reception).

ver_linux:
Linux ws018 2.4.2-ac20 #1 Wed Mar 14 12:19:28 CET 2001 i686 unknown
 
Gnu C                  2.95.2
Gnu make               3.78.1
binutils               2.9.5.0.37
util-linux             2.10r
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0b
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         snd-seq-midi snd-seq-midi-event snd-seq snd-card-als4000 snd-pcm snd-mpu401-uart snd-rawmidi snd-opl3 snd-hwdep snd-seq-device snd-timer snd-sb-common snd soundcore reiserfs serial 3c59x nls_koi8-r ntfs smbfs vfat fat nls_iso8859-2 nls_iso8859-1 nls_cp866 binfmt_misc autofs nfs lockd sunrpc nbd



There are <timestamp>.{modules,ksyms} in var/log/ksymoops,
timestamp corresponds to the time before restart. I provide
here only .modules, but have a copy of .ksyms kept.

20010320161019.modules (i have rmmod in crontab):
snd-seq-midi            3472   0 (unused)
snd-seq-midi-event      2912   0 [snd-seq-midi]
snd-seq                35712   0 [snd-seq-midi snd-seq-midi-event]
snd-card-als4000        4560   0 (unused)
snd-pcm                46400   0 [snd-card-als4000]
snd-mpu401-uart         2720   0 [snd-card-als4000]
snd-rawmidi            11008   0 [snd-seq-midi snd-mpu401-uart]
snd-opl3                5280   0 [snd-card-als4000]
snd-hwdep               3600   0 [snd-opl3]
snd-seq-device          4160   0 [snd-seq-midi snd-seq snd-rawmidi snd-opl3]
snd-timer               9152   0 [snd-seq snd-pcm snd-opl3]
snd-sb-common           6176   0 [snd-card-als4000]
snd                    22816   1 [snd-seq-midi snd-seq-midi-event snd-seq snd-card-als4000 snd-pcm snd-mpu401-uart snd-rawmidi snd-opl3 snd-hwdep snd-seq-device snd-timer snd-sb-common]
soundcore               3472   3 [snd]
reiserfs              146480   1 (autoclean)
serial                 41104   0 (autoclean)
3c59x                  23520   1
nls_koi8-r              3856   0 (unused)
ntfs                   34480   0 (unused)
smbfs                  30448   0 (unused)
vfat                    8432   0 (unused)
fat                    28896   0 [vfat]
nls_iso8859-2           3360   0 (unused)
nls_iso8859-1           2848   0 (unused)
nls_cp866               3840   0 (unused)
binfmt_misc             5536   0
autofs                  8896   0 (unused)
nfs                    68224   3
lockd                  47088   1 [nfs]
sunrpc                 56064   1 [nfs lockd]
nbd                    14576   0 (unused)


Hardware:
/proc/pci:
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 3).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xe7000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 3).
      Master Capable.  Latency=64.  Min Gnt=136.
  Bus  0, device   4, function  0:
    ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   4, function  1:
    IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=32.  
      I/O at 0xb800 [0xb80f].
  Bus  0, device   4, function  2:
    USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
      IRQ 5.
      Master Capable.  Latency=32.  
      I/O at 0xb400 [0xb41f].
  Bus  0, device   4, function  3:
    Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 2).
      IRQ 9.
  Bus  0, device  11, function  0:
    Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 116).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
      I/O at 0xb000 [0xb07f].
      Non-prefetchable 32 bit memory at 0xe4800000 [0xe480007f].
  Bus  0, device  13, function  0:
    Multimedia audio controller: Avance Logic Inc. ALS4000 Audio Chipset (rev 0).
      IRQ 5.
      Master Capable.  Latency=32.  
      I/O at 0xa800 [0xa87f].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP (rev 58).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xe6000000 [0xe6ffffff].
      I/O at 0xd800 [0xd8ff].
      Non-prefetchable 32 bit memory at 0xe5000000 [0xe5000fff].


/proc/cpuinfo:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 551.257
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1101.00

/proc/meminfo:

        total:    used:    free:  shared: buffers:  cached:
Mem:  262397952 257777664  4620288        0 130260992 64589824
Swap: 254943232  1245184 253698048
MemTotal:       256248 kB

/proc/ioports:

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
a800-a87f : Avance Logic Inc. ALS4000 Audio Chipset
  a800-a83f : ALS4000
b000-b07f : 3Com Corporation 3c905C-TX [Fast Etherlink]
  b000-b07f : eth0
b400-b41f : Intel Corporation 82371AB PIIX4 USB
b800-b80f : Intel Corporation 82371AB PIIX4 IDE
  b800-b807 : ide0
  b808-b80f : ide1
d000-dfff : PCI Bus #01
  d800-d8ff : ATI Technologies Inc 3D Rage IIC AGP
e400-e43f : Intel Corporation 82371AB PIIX4 ACPI
e800-e81f : Intel Corporation 82371AB PIIX4 ACPI

/proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0fffbfff : System RAM
  00100000-001b3c1f : Kernel code
  001b3c20-001e357f : Kernel data
0fffc000-0fffefff : ACPI Tables
0ffff000-0fffffff : ACPI Non-volatile Storage
e4800000-e480007f : 3Com Corporation 3c905C-TX [Fast Etherlink]
e5000000-e5dfffff : PCI Bus #01
  e5000000-e5000fff : ATI Technologies Inc 3D Rage IIC AGP
e5f00000-e6ffffff : PCI Bus #01
  e6000000-e6ffffff : ATI Technologies Inc 3D Rage IIC AGP
e7000000-e7ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
ffff0000-ffffffff : reserved



