Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129249AbRBDJYh>; Sun, 4 Feb 2001 04:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131197AbRBDJYS>; Sun, 4 Feb 2001 04:24:18 -0500
Received: from pop.gmx.net ([194.221.183.20]:15717 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129249AbRBDJYM>;
	Sun, 4 Feb 2001 04:24:12 -0500
Date: Sun, 4 Feb 2001 10:26:03 +0100
From: ksa1 <ksa1@gmx.de>
X-Mailer: The Bat! (v1.47 Halloween Edition) Personal
Reply-To: ksa1@gmx.de
X-Priority: 3 (Normal)
Message-ID: <66725424.20010204102603@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: d-link dfe-530 tx (bug-report)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

When I download big files with a win-client from my linux-server with samba 2.07 and
kernel 2.4.1 (just downloaded to test the new driver) after a random
time there is a connection-error! ..when I just download a few
megabytes there is no problem.

/var/log/messages on the linux-server with the d-link dfe-530 tx:
[THIS IS THE ERROR-MESSAGE!]
Feb  1  17:25:56 Nethost kernel: NETDEV WATCHDOG: eth0: transmit timed out
Feb  1  17:25:56 Nethost kernel: eth0: Transmit timed out, status 0000, PHY status 782d, resetting...

after booting everthing is fine (..until the big smb-transfer):
/var/log/messages (good):

via-rhine.c:v1.08b-LK1.1.6  8/9/2000  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
PCI: Assigned IRQ 9 for device 00:0a.0
PCI: Setting latency timer of device 00:0a.0 to 64
eth0: VIA VT6102 Rhine-II at 0xe000, 00:50:ba:68:59:9c, IRQ 9.
eth0: MII PHY found at address 8, status 0x7829 advertising 01e1 Link 0081.

I hope you can fix this problem.

bye.

additional informations:

lspci -vvv:
00:0a.0 Ethernet controller: VIA Technologies, Inc.: Unknown device 3065 (rev 42
)
        Subsystem: D-Link System Inc: Unknown device 1401
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step
ping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at e000 [size=256]
        Region 1: Memory at e5000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot
+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

cat /proc/cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 192.107
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 383.38

cat /proc/ioports:

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
0280-029f : eth1
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
e000-e0ff : VIA Technologies, Inc. Ethernet Controller
  e000-e0ff : eth0
e800-e80f : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
  e800-e807 : ide0
  e808-e80f : ide1

cat /proc/interrupts:

          CPU0
  0:      59686          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:         21          XT-PIC  serial
  9:       3276          XT-PIC  eth0
 10:         93          XT-PIC  eth1
 11:      11704          XT-PIC  HiSax
 14:       9771          XT-PIC  ide0
 15:         13          XT-PIC  ide1
NMI:          0
ERR:          0

cat /proc/modules:
smc-ultra               4784   1 (autoclean)
via-rhine               9616   1 (autoclean)
hisax                 140176   4
isdn                   89904   5 [hisax]


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
