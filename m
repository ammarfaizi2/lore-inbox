Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263589AbTAVVr5>; Wed, 22 Jan 2003 16:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbTAVVr5>; Wed, 22 Jan 2003 16:47:57 -0500
Received: from [200.82.34.90] ([200.82.34.90]:10393 "EHLO prod1.trimaxcba.com")
	by vger.kernel.org with ESMTP id <S263589AbTAVVrt>;
	Wed, 22 Jan 2003 16:47:49 -0500
Date: Wed, 22 Jan 2003 18:55:59 -0300
From: Horacio de Oro <hgdeoro@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: oops at ppp/pppoe startup and shutdown (2.5.59-mm2)
Message-Id: <20030122185559.405ab49c.hgdeoro@yahoo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===========================
[1.] Summary of the problem
===========================

Oops at startup and shutdown ppp/pppoe connection.

========================================
[4.] Kernel version (from /proc/version)
========================================

Linux version 2.5.59-mm2-4 (horacio@corralito) (gcc version 3.2.2 20030109 (Debian prerelease)) #3 Tue Jan 21 02:32:41 ART 2003

=============================
[5.] Output of Oops.. message
=============================

Jan 22 15:12:58 corralito pppd[199]: pppd 2.4.1 started by root, uid 0
Jan 22 15:12:58 corralito pppd[199]: Serial connection established.
Jan 22 15:12:58 corralito kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000008
Jan 22 15:12:58 corralito kernel:  printing eip:
Jan 22 15:12:58 corralito kernel: c0126d2f
Jan 22 15:12:58 corralito kernel: *pde = 00000000
Jan 22 15:12:58 corralito kernel: Oops: 0000
Jan 22 15:12:58 corralito kernel: CPU:    0
Jan 22 15:12:58 corralito kernel: EIP:    0060:[____call_usermodehelper+31/80]    Not tainted
Jan 22 15:12:58 corralito kernel: EFLAGS: 00010286
Jan 22 15:12:58 corralito kernel: EIP is at ____call_usermodehelper+0x1f/0x50
Jan 22 15:12:58 corralito kernel: eax: 00000000   ebx: ce069e2c   ecx: 00000000   edx: ffffffff
Jan 22 15:12:58 corralito kernel: esi: 00000000   edi: 00000000   ebp: 00000000   esp: ce02ffe0
Jan 22 15:12:58 corralito kernel: ds: 007b   es: 007b   ss: 0068
Jan 22 15:12:58 corralito kernel: Process events/0 (pid: 203, threadinfo=ce02e000 task=ce9a1300)
Jan 22 15:12:58 corralito kernel: Stack: 0000007b 0000007b ffffffff c0126d10 c010713d ce069e2c 00000000 00000000 
Jan 22 15:12:58 corralito kernel: Call Trace:
Jan 22 15:12:58 corralito kernel:  [____call_usermodehelper+0/80] ____call_usermodehelper+0x0/0x50
Jan 22 15:12:58 corralito kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
Jan 22 15:12:58 corralito kernel: 
Jan 22 15:12:58 corralito kernel: Code: 8b 48 08 85 c9 74 1b 8b 43 0c 89 44 24 08 8b 43 08 89 44 24 
Jan 22 15:12:58 corralito pppd[199]: Using interface ppp0
Jan 22 15:12:58 corralito pppd[199]: Connect: ppp0 <--> /dev/pts/0
Jan 22 15:12:58 corralito usbmgr[204]: start 0.4.8
Jan 22 15:12:58 corralito usbmgr[206]: Can't get module loader
Jan 22 15:12:58 corralito pppoe[200]: PADS: Service-Name: ''
Jan 22 15:12:58 corralito pppoe[200]: PPP session is 54002
Jan 22 15:12:58 corralito usbmgr[206]: open error "host"
Jan 22 15:12:58 corralito usbmgr[215]: mount /proc/bus/usb
Jan 22 15:12:58 corralito kernel:  <6>Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
Jan 22 15:12:59 corralito usbmgr[206]: class:0x9 subclass:0x0 protocol:0x0
Jan 22 15:12:59 corralito pppd[199]: not replacing existing default route to eth0 [x.x.x.x]
Jan 22 15:12:59 corralito pppd[199]: Cannot determine ethernet address for proxy ARP
Jan 22 15:12:59 corralito pppd[199]: local  IP address x.x.x.x
Jan 22 15:12:59 corralito pppd[199]: remote IP address x.x.x.x
Jan 22 15:12:59 corralito pppd[199]: primary   DNS address x.x.x.x
Jan 22 15:12:59 corralito pppd[199]: secondary DNS address x.x.x.x
Jan 22 15:12:59 corralito usbmgr[206]: USB device is matched the configuration
Jan 22 15:12:59 corralito usbmgr[206]: "none" isn't loaded
Jan 22 15:12:59 corralito usbmgr[206]: vendor:0x5a4 product:0x9999
Jan 22 15:12:59 corralito usbmgr[206]: class:0x3 subclass:0x1 protocol:0x2
Jan 22 15:12:59 corralito usbmgr[206]: USB device is matched the configuration
(...)
Jan 22 18:14:20 corralito init: Switching to runlevel: 6
Jan 22 18:14:21 corralito pppd[199]: Terminating on signal 15.
Jan 22 18:14:21 corralito pppoe[200]: Received signal 15.
Jan 22 18:14:21 corralito pppoe[200]: Sent PADT
Jan 22 18:14:21 corralito pppd[199]: ioctl(PPPIOCSASYNCMAP): Inappropriate ioctl for device(25)
Jan 22 18:14:21 corralito pppd[199]: tcflush failed: Input/output error
Jan 22 18:14:21 corralito kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000008
Jan 22 18:14:21 corralito kernel:  printing eip:
Jan 22 18:14:21 corralito kernel: c0126d2f
Jan 22 18:14:21 corralito kernel: *pde = 00000000
Jan 22 18:14:21 corralito kernel: Oops: 0000
Jan 22 18:14:21 corralito kernel: CPU:    0
Jan 22 18:14:21 corralito kernel: EIP:    0060:[____call_usermodehelper+31/80]    Not tainted
Jan 22 18:14:21 corralito kernel: EFLAGS: 00010286
Jan 22 18:14:21 corralito kernel: EIP is at ____call_usermodehelper+0x1f/0x50
Jan 22 18:14:21 corralito kernel: eax: 00000000   ebx: ce069e48   ecx: 00000000   edx: ffffffff
Jan 22 18:14:21 corralito kernel: esi: 00000000   edi: 00000000   ebp: 00000000   esp: cda37fe0
Jan 22 18:14:21 corralito kernel: ds: 007b   es: 007b   ss: 0068
Jan 22 18:14:21 corralito kernel: Process events/0 (pid: 2270, threadinfo=cda36000 task=cd9d6dc0)
Jan 22 18:14:21 corralito kernel: Stack: 0000007b 0000007b ffffffff c0126d10 c010713d ce069e48 00000000 00000000 
Jan 22 18:14:21 corralito kernel: Call Trace:
Jan 22 18:14:21 corralito kernel:  [____call_usermodehelper+0/80] ____call_usermodehelper+0x0/0x50
Jan 22 18:14:21 corralito kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
Jan 22 18:14:21 corralito kernel: 
Jan 22 18:14:21 corralito kernel: Code: 8b 48 08 85 c9 74 1b 8b 43 0c 89 44 24 08 8b 43 08 89 44 24 
Jan 22 18:14:21 corralito kernel:  <7>PPPIOCDETACH file->f_count=3
Jan 22 18:14:21 corralito pppd[199]: Couldn't release PPP unit: Invalid argument
Jan 22 18:14:21 corralito pppd[199]: Exit.
Jan 22 18:14:28 corralito usbmgr[2359]: umount /proc/bus/usb
Jan 22 18:14:28 corralito usbmgr[206]: bye!
Jan 22 18:14:28 corralito kernel: Kernel logging (proc) stopped.
Jan 22 18:14:28 corralito kernel: Kernel log daemon terminating.
Jan 22 18:14:28 corralito exiting on signal 15


This time, ppp started at boot time, then I stoped it:


Jan 22 18:24:06 corralito pppd[191]: pppd 2.4.1 started by root, uid 0
Jan 22 18:24:06 corralito pppd[191]: Serial connection established.
Jan 22 18:24:06 corralito kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000008
Jan 22 18:24:06 corralito kernel:  printing eip:
Jan 22 18:24:06 corralito kernel: c0126d2f
Jan 22 18:24:06 corralito kernel: *pde = 00000000
Jan 22 18:24:06 corralito kernel: Oops: 0000
Jan 22 18:24:06 corralito kernel: CPU:    0
Jan 22 18:24:06 corralito kernel: EIP:    0060:[____call_usermodehelper+31/80]    Not tainted
Jan 22 18:24:06 corralito kernel: EFLAGS: 00010286
Jan 22 18:24:06 corralito kernel: EIP is at ____call_usermodehelper+0x1f/0x50
Jan 22 18:24:06 corralito kernel: eax: 00000000   ebx: cdf35e2c   ecx: 00000000   edx: ffffffff
Jan 22 18:24:06 corralito kernel: esi: 00000000   edi: 00000000   ebp: 00000000   esp: cdeedfe0
Jan 22 18:24:06 corralito kernel: ds: 007b   es: 007b   ss: 0068
Jan 22 18:24:06 corralito kernel: Process events/0 (pid: 195, threadinfo=cdeec000 task=c13f4680)
Jan 22 18:24:06 corralito kernel: Stack: 0000007b 0000007b ffffffff c0126d10 c010713d cdf35e2c 00000000 00000000 
Jan 22 18:24:06 corralito kernel: Call Trace:
Jan 22 18:24:06 corralito kernel:  [____call_usermodehelper+0/80] ____call_usermodehelper+0x0/0x50
Jan 22 18:24:06 corralito kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
Jan 22 18:24:06 corralito kernel: 
Jan 22 18:24:06 corralito kernel: Code: 8b 48 08 85 c9 74 1b 8b 43 0c 89 44 24 08 8b 43 08 89 44 24 
Jan 22 18:24:06 corralito pppd[191]: Using interface ppp0
Jan 22 18:24:06 corralito pppd[191]: Connect: ppp0 <--> /dev/pts/0
Jan 22 18:24:06 corralito usbmgr[196]: start 0.4.8
Jan 22 18:24:06 corralito usbmgr[198]: Can't get module loader
Jan 22 18:24:06 corralito pppoe[192]: PADS: Service-Name: ''
Jan 22 18:24:06 corralito pppoe[192]: PPP session is 54271
Jan 22 18:24:06 corralito usbmgr[198]: open error "host"
Jan 22 18:24:06 corralito usbmgr[205]: mount /proc/bus/usb
Jan 22 18:24:07 corralito kernel:  <6>Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
Jan 22 18:24:07 corralito usbmgr[198]: class:0x9 subclass:0x0 protocol:0x0
Jan 22 18:24:07 corralito pppd[191]: not replacing existing default route to eth0 [x.x.x.x]
Jan 22 18:24:07 corralito pppd[191]: Cannot determine ethernet address for proxy ARP
Jan 22 18:24:07 corralito pppd[191]: local  IP address x.x.x.x
Jan 22 18:24:07 corralito pppd[191]: remote IP address x.x.x.x
Jan 22 18:24:07 corralito pppd[191]: primary   DNS address x.x.x.x
Jan 22 18:24:07 corralito pppd[191]: secondary DNS address x.x.x.x
Jan 22 18:24:07 corralito usbmgr[198]: USB device is matched the configuration
Jan 22 18:24:07 corralito usbmgr[198]: "none" isn't loaded
Jan 22 18:24:08 corralito usbmgr[198]: vendor:0x5a4 product:0x9999
Jan 22 18:24:08 corralito usbmgr[198]: class:0x3 subclass:0x1 protocol:0x2
Jan 22 18:24:08 corralito usbmgr[198]: USB device is matched the configuration
(...)
Jan 22 18:28:15 corralito pppd[191]: Terminating on signal 15.
Jan 22 18:28:15 corralito pppoe[192]: Received signal 15.
Jan 22 18:28:15 corralito pppoe[192]: Sent PADT
Jan 22 18:28:15 corralito pppd[191]: Modem hangup
Jan 22 18:28:15 corralito pppd[191]: Connection terminated.
Jan 22 18:28:15 corralito pppd[191]: Connect time 4.2 minutes.
Jan 22 18:28:15 corralito pppd[191]: Sent 262 bytes, received 766 bytes.
Jan 22 18:28:15 corralito kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000008
Jan 22 18:28:15 corralito kernel:  printing eip:
Jan 22 18:28:15 corralito kernel: c0126d2f
Jan 22 18:28:15 corralito kernel: *pde = 00000000
Jan 22 18:28:15 corralito kernel: Oops: 0000
Jan 22 18:28:15 corralito kernel: CPU:    0
Jan 22 18:28:15 corralito kernel: EIP:    0060:[____call_usermodehelper+31/80]    Not tainted
Jan 22 18:28:15 corralito kernel: EFLAGS: 00010286
Jan 22 18:28:15 corralito kernel: EIP is at ____call_usermodehelper+0x1f/0x50
Jan 22 18:28:15 corralito kernel: eax: 00000000   ebx: cdf35e48   ecx: 00000000   edx: ffffffff
Jan 22 18:28:15 corralito kernel: esi: 00000000   edi: 00000000   ebp: 00000000   esp: ceb79fe0
Jan 22 18:28:15 corralito kernel: ds: 007b   es: 007b   ss: 0068
Jan 22 18:28:15 corralito pppd[191]: Couldn't release PPP unit: Invalid argument
Jan 22 18:28:15 corralito kernel: Process events/0 (pid: 458, threadinfo=ceb78000 task=ceb892c0)
Jan 22 18:28:16 corralito kernel: Stack: 0000007b 0000007b ffffffff c0126d10 c010713d cdf35e48 00000000 00000000 
Jan 22 18:28:16 corralito kernel: Call Trace:
Jan 22 18:28:16 corralito kernel:  [____call_usermodehelper+0/80] ____call_usermodehelper+0x0/0x50
Jan 22 18:28:16 corralito kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
Jan 22 18:28:16 corralito kernel: 
Jan 22 18:28:16 corralito kernel: Code: 8b 48 08 85 c9 74 1b 8b 43 0c 89 44 24 08 8b 43 08 89 44 24 
Jan 22 18:28:16 corralito kernel:  <7>PPPIOCDETACH file->f_count=3
Jan 22 18:28:16 corralito pppd[191]: Exit.


====================================================
[6.] A small shell script which triggers the problem
====================================================

Every time I startup ppp (also shuting down)
makes oops the kernel.

[7.] Environment

================================================
[7.1.] Software (output of the ver_linux script)
================================================

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux corralito 2.5.59-mm2-4 #3 Tue Jan 21 02:32:41 ART 2003 i686 unknown unknown GNU/Linux
 
Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
module-init-tools      implemented
e2fsprogs              1.32
pcmcia-cs              3.2.2
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.4

=================================================
[7.2.] Processor information (from /proc/cpuinfo)
=================================================
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 7
model name	: mobile AMD Duron(tm) Processor
stepping	: 0
cpu MHz		: 946.673
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 1863.68

==============================================
[7.3.] Module information (from /proc/modules)
==============================================

No module support compiled.

============================================
[7.4.1.] Hardware information: /proc/ioports
============================================

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
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : VIA Technologies, In VT82C686 AC97 Audio 
  1000-10ff : VIA686A
1400-14ff : Realtek Semiconducto RTL-8139/8139C/8139C
  1400-14ff : 8139too
1800-181f : VIA Technologies, In USB
  1800-181f : uhci-hcd
1840-184f : VIA Technologies, In VT82C586/B/686A/B PI
  1840-1847 : ide0
  1848-184f : ide1
1850-1853 : VIA Technologies, In VT82C686 AC97 Audio 
1854-1857 : VIA Technologies, In VT82C686 AC97 Audio 
1858-185f : Conexant HSF 56k HSFi Modem
1c00-1cff : PCI CardBus #02
2000-20ff : PCI CardBus #02
8100-810f : VIA Technologies, In VT82C686 [Apollo Sup

=========================================
[7.4.2.] Hardware information /proc/iomem
=========================================

00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-0eeeffff : System RAM
  00100000-00342e0d : Kernel code
  00342e0e-004159c3 : Kernel data
0eef0000-0eefefff : ACPI Tables
0eeff000-0eefffff : ACPI Non-volatile Storage
0ef00000-0effffff : System RAM
e8000000-e800ffff : Conexant HSF 56k HSFi Modem
e8010000-e80100ff : Realtek Semiconducto RTL-8139/8139C/8139C
  e8010000-e80100ff : 8139too
e8100000-e81fffff : PCI Bus #01
  e8100000-e817ffff : S3 Inc. VT8636A [ProSavage K
ec000000-efffffff : VIA Technologies, In VT8363/8365 [KT133/K
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : S3 Inc. VT8636A [ProSavage K
    f0000000-f0eeffff : vesafb
fbbfd000-ffbfcfff : PCI CardBus #02
ffbfd000-ffbfdfff : PCI CardBus #02
ffbfe000-ffbfefff : Texas Instruments PCI1410 PC card Card
fff80000-ffffffff : reserved

=====================================
[7.5.] PCI information ('lspci -vvv')
=====================================

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 80)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 8
	Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=x4
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e8100000-e81fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 42)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1840 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at 1800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 10
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
	Subsystem: Compaq Computer Corporation: Unknown device 0097
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at 1000 [size=256]
	Region 1: I/O ports at 1854 [size=4]
	Region 2: I/O ports at 1850 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device 8d88
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 4
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64K]
	Region 1: I/O ports at 1858 [size=8]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device b103
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 10
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ffbfe000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: ffbfd000-ffbfd000 (prefetchable)
	Memory window 1: fbbfd000-ffbfc000
	I/O window 0: 00001c00-00001cff
	I/O window 1: 00002000-000020ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1400 [size=256]
	Region 1: Memory at e8010000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: S3 Inc. VT8636A [ProSavage KN133] AGP4X VGA Controller (TwisterK) (rev 01) (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation: Unknown device 0086
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e8100000 (32-bit, non-prefetchable) [size=512K]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW- Rate=x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=x4

========================
[7.6.] Other information
========================

* Distribution: Debian GNU/Linux unstable

* PPPD version:

pppd version 2.4.1

* PPPOE version:

PPPoE Version 3.3, Copyright (C) 2001 Roaring Penguin Software Inc.
PPPoE comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it under the terms
of the GNU General Public License, version 2 or any later version.
http://www.roaringpenguin.com


Should I cc this kind of messages to someone else?
Thanks!

Horacio de Oro
