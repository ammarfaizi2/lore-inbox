Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130433AbRCLO5f>; Mon, 12 Mar 2001 09:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130384AbRCLO50>; Mon, 12 Mar 2001 09:57:26 -0500
Received: from smtp-rt-6.wanadoo.fr ([193.252.19.160]:60844 "EHLO
	caroubier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S130433AbRCLO5Q>; Mon, 12 Mar 2001 09:57:16 -0500
Message-ID: <3AACE307.66677B6A@wanadoo.fr>
Date: Mon, 12 Mar 2001 15:54:00 +0100
From: Pascal Bonfils <abindus@wanadoo.fr>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ISSUE : ppp failure with kernel 2.4.2 - used to work with 2.4.0
Content-Type: multipart/mixed;
 boundary="------------177EA0A4CC73970B4D3C47FD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------177EA0A4CC73970B4D3C47FD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

1 - ppp failure with kernel 2.4.2 - used to work with 2.4.0

2 - Kernel 2.4.2 has been compiled exactly with the same options
(config) as the 2.4.0.
Now when I try to reach my ISP, everything runs well until pppd launch
the serial connection (see the message file attached)

3 - Keywords : kernel ppp

4 - Kernel version : Linux version 2.4.2 (root@a0.abi.org) (gcc version
2.96 20000731 (Red Hat Linux 7.0))

5 - Extract of the /var/log/message file :
Mar 12 14:22:14 a0 ifup-ppp: pppd started for ppp0 on /dev/ttyS2 at
115200
Mar 12 14:22:14 a0 pppd[808]: pppd 2.3.11 started by root, uid 0
Mar 12 14:22:15 a0 WvDial: WvDial: Internet dialer version 1.41
Mar 12 14:22:15 a0 WvDial: Initializing modem.
Mar 12 14:22:15 a0 WvDial: Sending: ATZ
Mar 12 14:22:15 a0 WvDial: ATZ
Mar 12 14:22:15 a0 WvDial: OK
Mar 12 14:22:15 a0 WvDial: Sending: ATQ0 V1 E1 S0=0 &C1 &D2 S11=55
+FCLASS=0
Mar 12 14:22:15 a0 WvDial: ATQ0 V1 E1 S0=0 &C1 &D2 S11=55 +FCLASS=0
Mar 12 14:22:15 a0 WvDial: OK
Mar 12 14:22:15 a0 WvDial: Sending: ATM0L1
Mar 12 14:22:16 a0 WvDial: ATM0L1
Mar 12 14:22:16 a0 WvDial: OK
Mar 12 14:22:16 a0 WvDial: Modem initialized.
Mar 12 14:22:16 a0 WvDial: Sending: ATDT .......................
Mar 12 14:22:16 a0 WvDial: Waiting for carrier.
Mar 12 14:22:16 a0 WvDial: ATDT .................
mar 12 14:22:25 a0 PAM_unix[843]: (su) session opened for user root by
..(uid=....)
Mar 12 14:22:38 a0 WvDial: CONNECT 31200/ARQ/V34/LAPM/V42BIS
Mar 12 14:22:38 a0 WvDial: Carrier detected.  Waiting for prompt.
Mar 12 14:22:38 a0 WvDial: Login:
Mar 12 14:22:38 a0 WvDial: Looks like a login prompt.
Mar 12 14:22:38 a0 WvDial: Sending: ..............
Mar 12 14:22:39 a0 WvDial: ..............
Mar 12 14:22:39 a0 WvDial: Password:
Mar 12 14:22:39 a0 WvDial: Looks like a password prompt.
Mar 12 14:22:39 a0 WvDial: Sending: (password)
Mar 12 14:22:39 a0 WvDial:     Entering PPP Session.
Mar 12 14:22:39 a0 WvDial:     IP address is ............
Mar 12 14:22:39 a0 WvDial:     MTU is 1524.
Mar 12 14:22:39 a0 WvDial: Looks like a welcome message.
Mar 12 14:22:39 a0 pppd[808]: Serial connection established.
Mar 12 14:22:39 a0 pppd[808]: ioctl(PPPIOCGFLAGS): Invalid argument
Mar 12 14:22:39 a0 pppd[808]: Hangup (SIGHUP)
Mar 12 14:22:39 a0 pppd[808]: Exit.

6 - at the end of rp3 (or wvdial, same result), pppd aborts ...

7.1 - output of ver_linux : see file attached

7.2 - /proc/cpuinfo : see file attached

7.3 - /proc/modules : no such file (no option module compiled in kernel)

7.4 - /proc/ioport & /proc/iomem : see files attached

7.5 - output of lspci -vvv : see file attached

7.6 - /proc/scsi/scsi : Attached devices: none


Best regards and good luck (many thanks in advance)

Pascal Bonfils / Paris - France
abindus@wanadoo.fr

--------------177EA0A4CC73970B4D3C47FD
Content-Type: text/plain; charset=us-ascii;
 name="lspci.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.out"

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e4000000-e5ffffff
	Prefetchable memory behind bridge: e7000000-e77fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at e000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:08.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 26)
	Subsystem: Tekram Technology Co.,Ltd. DC390F Ultra Wide SCSI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4250ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e400 [size=256]
	Region 1: Memory at e7801000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at e7800000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at e6000000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at e7802000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
	Capabilities: [60] Vital Product Data

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 (rev 0b) (prog-if 00 [VGA])
	Subsystem: Palit Microsystems Inc. SiS6326 GUI Accelerator
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e7000000 (32-bit, prefetchable) [size=8M]
	Region 1: Memory at e5000000 (32-bit, non-prefetchable) [size=64K]
	Region 2: I/O ports at d000 [size=128]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 1.0
		Status: RQ=1 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


--------------177EA0A4CC73970B4D3C47FD
Content-Type: text/plain; charset=us-ascii;
 name="iomem.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iomem.out"

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c83ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0bffffff : System RAM
  00100000-00240fcb : Kernel code
  00240fcc-002adae3 : Kernel data
e0000000-e3ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
e4000000-e5ffffff : PCI Bus #01
  e5000000-e500ffff : Silicon Integrated Systems [SiS] 86C326
e7000000-e77fffff : PCI Bus #01
  e7000000-e77fffff : Silicon Integrated Systems [SiS] 86C326
e7800000-e7800fff : Symbios Logic Inc. (formerly NCR) 53c875
e7801000-e78010ff : Symbios Logic Inc. (formerly NCR) 53c875
e7802000-e78020ff : Realtek Semiconductor Co., Ltd. RTL-8139
  e7802000-e78020ff : eth0
ffff0000-ffffffff : reserved

--------------177EA0A4CC73970B4D3C47FD
Content-Type: text/plain; charset=us-ascii;
 name="ioport.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ioport.out"

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
02e8-02ef : serial(set)
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03e8-03ef : serial(set)
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
d000-dfff : PCI Bus #01
  d000-d07f : Silicon Integrated Systems [SiS] 86C326
e000-e01f : Intel Corporation 82371AB PIIX4 USB
  e000-e01f : usb-uhci
e400-e4ff : Symbios Logic Inc. (formerly NCR) 53c875
  e400-e47f : sym53c8xx
e800-e8ff : Realtek Semiconductor Co., Ltd. RTL-8139
  e800-e8ff : eth0
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

--------------177EA0A4CC73970B4D3C47FD
Content-Type: text/plain; charset=us-ascii;
 name="cpuinfo.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpuinfo.out"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 3
model name	: Pentium II (Klamath)
stepping	: 4
cpu MHz		: 233.345
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov mmx
bogomips	: 465.30


--------------177EA0A4CC73970B4D3C47FD
Content-Type: text/plain; charset=us-ascii;
 name="ver_linux.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ver_linux.out"

-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux a0.abi.org 2.4.2 #2 lun mar 12 14:04:23 CET 2001 i686 unknown
Kernel modules         2.3.14
Gnu C                  2.96
Binutils               2.10.0.18
Linux C Library        6 -> libc-2.2.so
Procps                 2.0.7
Mount                  2.10m
Net-tools              (2000-05-21)
Kbd                    [option...]
Sh-utils               2.0
Sh-utils               Parker.
Sh-utils               
Sh-utils               Inc.
Sh-utils               NO
Sh-utils               PURPOSE.

--------------177EA0A4CC73970B4D3C47FD--

