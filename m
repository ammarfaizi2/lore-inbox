Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRB0OLP>; Tue, 27 Feb 2001 09:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129424AbRB0OLG>; Tue, 27 Feb 2001 09:11:06 -0500
Received: from mail.clinet.fi ([194.100.0.7]:18949 "EHLO mail.clinet.fi")
	by vger.kernel.org with ESMTP id <S129413AbRB0OLB>;
	Tue, 27 Feb 2001 09:11:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dennis Noordsij <dennis.noordsij@wiral.com>
To: linux-kernel@vger.kernel.org
Subject: Unexpected IRQ trap at vector 20
Date: Tue, 27 Feb 2001 16:10:52 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01022716105200.01136@dennis>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After a previous post about a Dell 5000e Inspiron crashing when Speedstep 
kicks in I have set up a serial console, and this time, when copying a file 
between partitions, in plain old console, no X, network not configured, etc 
etc, plugging in the power (while the system was running on battery - this 
causes the CPU to step up to 700MHz from 550MHz) causes the system to freeze 
in every way (including SysRq), while continuously spitting out "Unexpected 
IRQ trap at vector 20" on the serial console. 

I realize that probably more information is needed for this to be useful (if 
it is not just a 'shitty hardware' thing) but I am not sure what would be 
needed, so if you need to know anything, just drop me a line.

Kind regards,
Dennis Noordsij

Linux version 2.4.2 (root@dennis) (gcc version 2.95.3 20010219 (prerelease)) 
#10 Tue Feb 27 18:51:54 EET 2001
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 696.977
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1389.36

           CPU0       
  0:     354204          XT-PIC  timer
  1:      20736          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  ESS Maestro 2E
 11:      33195          XT-PIC  Texas Instruments PCI1225, Texas Instruments 
PCI1225 (#2), eth0
 12:      59885          XT-PIC  PS/2 Mouse
 14:      76934          XT-PIC  ide0
 15:         20          XT-PIC  ide1
NMI:          0 
ERR:        193

Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
  7 vcs
 10 misc
 14 sound
 21 sg
108 ppp
128 ptm
136 pts
162 raw
254 pcmcia

Block devices:
  2 fd
  3 ide0
  7 loop
 11 sr
 22 ide1

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0280-0287 : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
1000-103f : Intel Corporation 82371AB PIIX4 ACPI
1040-105f : Intel Corporation 82371AB PIIX4 ACPI
1060-107f : Intel Corporation 82371AB PIIX4 USB
1080-108f : Intel Corporation 82371AB PIIX4 IDE
  1080-1087 : ide0
  1088-108f : ide1
1400-14ff : ESS Technology ES1978 Maestro 2E
  1400-14ff : ESS Maestro 2E
1800-18ff : PCI CardBus #02
  1800-187f : PCI device 115d:0003
    1800-187f : eth0
  1880-1887 : PCI device 115d:0103
    1880-1887 : serial(auto)
1c00-1cff : PCI CardBus #02
2000-2fff : PCI Bus #01
  2000-20ff : ATI Technologies Inc Mobility M3 AGP 2x
3000-30ff : PCI CardBus #06
3400-34ff : PCI CardBus #06

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 3).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 3).
      Master Capable.  Latency=128.  Min Gnt=140.
  Bus  0, device   4, function  0:
    CardBus bridge: Texas Instruments PCI1225 (rev 1).
      IRQ 11.
      Master Capable.  Latency=168.  Max Lat=5.
      Non-prefetchable 32 bit memory at 0x10000000 [0x10000fff].
  Bus  0, device   4, function  1:
    CardBus bridge: Texas Instruments PCI1225 (#2) (rev 1).
      IRQ 11.
      Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
      Non-prefetchable 32 bit memory at 0x10001000 [0x10001fff].
  Bus  0, device   7, function  0:
    Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=64.  
      I/O at 0x1080 [0x108f].
  Bus  0, device   7, function  2:
    USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
      IRQ 5.
      Master Capable.  Latency=64.  
      I/O at 0x1060 [0x107f].
  Bus  0, device   7, function  3:
    Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 3).
  Bus  0, device   8, function  0:
    Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 16).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=24.
      I/O at 0x1400 [0x14ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc Mobility M3 AGP 2x (rev 
2).
      IRQ 11.
      Master Capable.  Latency=66.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
      I/O at 0x2000 [0x20ff].
      Non-prefetchable 32 bit memory at 0xf4000000 [0xf4003fff].
  Bus  2, device   0, function  0:
    Ethernet controller: PCI device 115d:0003 (rev 3).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=20.Max Lat=40.
      I/O at 0x1800 [0x187f].
      Non-prefetchable 32 bit memory at 0x10800000 [0x108007ff].
      Non-prefetchable 32 bit memory at 0x10800800 [0x10800fff].
  Bus  2, device   0, function  1:
    Serial controller: PCI device 115d:0103 (rev 3).
      IRQ 11.
      I/O at 0x1880 [0x1887].
      Non-prefetchable 32 bit memory at 0x10801000 [0x108017ff].
      Non-prefetchable 32 bit memory at 0x10801800 [0x10801fff].
