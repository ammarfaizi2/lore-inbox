Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263252AbSJTRHF>; Sun, 20 Oct 2002 13:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263267AbSJTRHF>; Sun, 20 Oct 2002 13:07:05 -0400
Received: from ulima.unil.ch ([130.223.144.143]:18560 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S263252AbSJTRHC>;
	Sun, 20 Oct 2002 13:07:02 -0400
Date: Sun, 20 Oct 2002 19:13:06 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.44 Oops (ISDN)
Message-ID: <20021020171306.GA15607@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

(syncppp don't compil already reported)

as 2.5.44 with syncppp doesn't compil, I tried to compil without, but it
Oops at boot:

ISDN subsystem Rev: 1.114.6.16/1.94.6.9/1.140.6.11/none/1.21.6.3/1.5.6.4
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (kernel)
HiSax: Layer1 Revision 2.41.6.5
HiSax: Layer2 Revision 2.25.6.4
HiSax: TeiMgr Revision 2.17.6.3
HiSax: Layer3 Revision 2.17.6.5
HiSax: LinkLayer Revision 2.51.6.6
HiSax: Approval certification failed because of
HiSax: unauthorized source code changes
HiSax: Card 1 Protocol NONE Id=HiSax (0)
HiSax: AVM PCI driver Rev. 1.22.6.6
FritzPnP: no ISA PnP present
AVM PCI: stat 0x2020a
AVM PCI: Class A Rev 2
HiSax: AVM Fritz!PCI config irq:16 base:0xB800
AVM PCI: ISAC version (0): 2086/2186 V1.1
AVM Fritz PnP/PCI: IRQ 16 count 0
------------[ cut here ]------------
kernel BUG at kernel/workqueue.c:69!
invalid operand: 0000
 
CPU:    0
EIP:    0060:[<c012a028>]    Not tainted
EFLAGS: 00010013
eax: 00000000   ebx: c17f3958   ecx: 00000001   edx: 00000000
esi: c17f395c   edi: dffef880   ebp: c153c000   esp: c153deb8
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 1, threadinfo=c153c000 task=c153a080)
Stack: 00000004 c17f3000 00000003 c040c5d2 c17f3000 00000002 00000052 c17f3000 
       00000002 c02e14ca c17f3000 00000002 00000003 c17f3000 c040b117 c17f3000 
       000000f2 00000000 c03a4092 c17f3000 00000000 c17f3000 00000000 00000001 
Call Trace: [<c02e14ca>]  [<c010506a>]  [<c0105040>]  [<c0105615>] 
Code: 0f 0b 45 00 b2 bb 37 c0 eb b3 8d b4 26 00 00 00 00 8d bc 27 
 <0>Kernel panic: Attempted to kill init!
 <6>SysRq : Resetting

ksymoops 2.4.5 on i686 2.5.44.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/linux/System.map (specified)

SGI XFS CVS-09/15/02:17 with no debug enabled
kernel BUG at kernel/workqueue.c:69!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c012a028>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010013
eax: 00000000   ebx: c17f3958   ecx: 00000001   edx: 00000000
esi: c17f395c   edi: dffef880   ebp: c153c000   esp: c153deb8
ds: 0068   es: 0068   ss: 0068
Stack: 00000004 c17f3000 00000003 c040c5d2 c17f3000 00000002 00000052 c17f3000 
       00000002 c02e14ca c17f3000 00000002 00000003 c17f3000 c040b117 c17f3000 
       000000f2 00000000 c03a4092 c17f3000 00000000 c17f3000 00000000 00000001 
Call Trace: [<c02e14ca>]  [<c010506a>]  [<c0105040>]  [<c0105615>] 
Code: 0f 0b 45 00 b2 bb 37 c0 eb b3 8d b4 26 00 00 00 00 8d bc 27 


>>EIP; c012a028 <queue_work+68/80>   <=====

>>ebx; c17f3958 <END_OF_CODE+1356124/????>
>>esi; c17f395c <END_OF_CODE+1356128/????>
>>edi; dffef880 <END_OF_CODE+1fb5204c/????>
>>ebp; c153c000 <END_OF_CODE+109e7cc/????>
>>esp; c153deb8 <END_OF_CODE+10a0684/????>

Trace; c02e14ca <AVM_card_msg+6a/d0>
Trace; c010506a <init+2a/150>
Trace; c0105040 <init+0/150>
Trace; c0105615 <kernel_thread_helper+5/10>

Code;  c012a028 <queue_work+68/80>
00000000 <_EIP>:
Code;  c012a028 <queue_work+68/80>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012a02a <queue_work+6a/80>
   2:   45                        inc    %ebp
Code;  c012a02b <queue_work+6b/80>
   3:   00 b2 bb 37 c0 eb         add    %dh,0xebc037bb(%edx)
Code;  c012a031 <queue_work+71/80>
   9:   b3 8d                     mov    $0x8d,%bl
Code;  c012a033 <queue_work+73/80>
   b:   b4 26                     mov    $0x26,%ah
Code;  c012a035 <queue_work+75/80>
   d:   00 00                     add    %al,(%eax)
Code;  c012a037 <queue_work+77/80>
   f:   00 00                     add    %al,(%eax)
Code;  c012a039 <queue_work+79/80>
  11:   8d bc 27 00 00 00 00      lea    0x0(%edi,1),%edi

 <0>Kernel panic: Attempted to kill init!


Linux localhost.localdomain 2.5.44 #8 Sat Oct 19 11:37:54 CEST 2002 i686 unknown unknown GNU/Linux
 
Gnu C                  gcc-3.2 (GCC) 3.2 (Mandrake Linux 9.0 3.2-2mdk) Copyright (C) 2002 Free Software Foundation, Inc. This is free software; see the source for copying conditions. There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11w
mount                  2.11w
modutils               2.4.19
e2fsprogs              1.27ea
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.10
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.2

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 11)
	Flags: bus master, fast devsel, latency 0
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [e4] #09 [a104]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 11) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=02, sec-latency=32
	Memory behind bridge: dec00000-dfdfffff
	Prefetchable memory behind bridge: da800000-de9fffff

00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Micro-star International Co Ltd: Unknown device 3982
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at d800 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Micro-star International Co Ltd: Unknown device 3982
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at dc00 [size=32]

00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 01) (prog-if 20 [EHCI])
	Subsystem: Micro-star International Co Ltd: Unknown device 3981
	Flags: bus master, medium devsel, latency 0, IRQ 23
	Memory at dfffbc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 81) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: dfe00000-dfefffff
	Prefetchable memory behind bridge: dea00000-deafffff

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-star International Co Ltd: Unknown device 3982
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at fc00 [size=16]
	Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp.: Unknown device 24c3 (rev 01)
	Subsystem: Micro-star International Co Ltd: Unknown device 3982
	Flags: medium devsel, IRQ 17
	I/O ports at 0c00 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24c5 (rev 01)
	Subsystem: Micro-star International Co Ltd: Unknown device 3982
	Flags: bus master, medium devsel, latency 0, IRQ 17
	I/O ports at d400 [size=256]
	I/O ports at d000 [size=64]
	Memory at dffffe00 (32-bit, non-prefetchable) [size=512]
	Memory at dffffd00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR 32Mb
	Flags: bus master, medium devsel, latency 32, IRQ 16
	Memory at dc000000 (32-bit, prefetchable) [size=32M]
	Memory at dfdfc000 (32-bit, non-prefetchable) [size=16K]
	Memory at df000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at dfdc0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [f0] AGP version 2.0

03:00.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz] (rev 02)
	Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH FRITZ!Card ISDN Controller
	Flags: medium devsel, IRQ 16
	Memory at dfefefe0 (32-bit, non-prefetchable) [size=32]
	I/O ports at b800 [size=32]

03:01.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
	Subsystem: Technotrend Systemtechnik GmbH: Unknown device 0000
	Flags: bus master, medium devsel, latency 32, IRQ 17
	Memory at dfefec00 (32-bit, non-prefetchable) [size=512]

03:02.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
	Subsystem: Adaptec 29160LP Low Profile Ultra160 SCSI Controller
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 18
	BIST result: 00
	I/O ports at bc00 [disabled] [size=256]
	Memory at dfeff000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at dfec0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

03:03.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
	Flags: bus master, medium devsel, latency 32, IRQ 19
	I/O ports at b400 [disabled] [size=256]
	Memory at dfefd000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at dfee0000 [disabled] [size=64K]

03:04.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
	Subsystem: Technotrend Systemtechnik GmbH: Unknown device 0000
	Flags: bus master, medium devsel, latency 32, IRQ 16
	Memory at dfefea00 (32-bit, non-prefetchable) [size=512]

03:08.0 Ethernet controller: Intel Corp.: Unknown device 103a (rev 81)
	Subsystem: Intel Corp.: Unknown device 1039
	Flags: bus master, medium devsel, latency 32, IRQ 20
	Memory at dfef8000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at b000 [size=64]
	Capabilities: [dc] Power Management version 2

Should I provide other info?

Thank you very much, 

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
