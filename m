Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbTE2QdC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbTE2QdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:33:01 -0400
Received: from smtp0.libero.it ([193.70.192.33]:44979 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S262348AbTE2Qc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:32:29 -0400
Message-ID: <3ED61DEB.4080307@libero.it>
Date: Thu, 29 May 2003 16:49:15 +0200
From: Antonello Biancalana <promind@libero.it>
Organization: ProMIND software development
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel 2.4.21-rc5 unpredictably hangs
X-Enigmail-Version: 0.71.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] kernel 2.4.21-rc5 unpredictably hangs

[2.] During normal operations the kernel unpredictably hangs. I could 
not find a particular cause to this, however it seems more likely to 
happen when there are some CPU time consuming applications running, such 
as gcc, however this happens in other conditions as well. kernel 2.4.20 
works fine.

[3.] kernel

[4.] Linux version 2.4.21-rc5 (root@Dacey.ProMIND.it) (gcc version 3.2 
20020903 (Red Hat Linux 8.0 3.2-7)) #1 Thu May 29 10:11:35 CEST 2003

[5.]

[6.]

[7.]

[7.1.]
 Linux Dacey.ProMIND.it 2.4.21-rc5 #1 Thu May 29 10:11:35 CEST 2003 i686 
athlon i386 GNU/Linux

Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         snd-pcm-oss snd-mixer-oss it87 i2c-proc i2c-isa 
i2c-core binfmt_misc parport_pc lp parport snd-via82xx snd-pcm snd-timer 
snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-device snd soundcore

[7.2]
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1800+
stepping        : 2
cpu MHz         : 1564.293
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3119.51

[7.3.]
snd-pcm-oss            43748   1 (autoclean)
snd-mixer-oss          15288   1 (autoclean) [snd-pcm-oss]
it87                   12292   0 (unused)
i2c-proc                9168   0 [it87]
i2c-isa                 1928   0 (unused)
i2c-core               19044   0 [it87 i2c-proc i2c-isa]
binfmt_misc             7336   1
parport_pc             31400   1 (autoclean)
lp                      8096   0 (autoclean)
parport                36064   1 (autoclean) [parport_pc lp]
snd-via82xx            11500   2
snd-pcm                82144   0 [snd-pcm-oss snd-via82xx]
snd-timer              15432   0 [snd-pcm]
snd-ac97-codec         35204   0 [snd-via82xx]
snd-mpu401-uart         4668   0 [snd-via82xx]
snd-rawmidi            18592   0 [snd-mpu401-uart]
snd-seq-device          6176   0 [snd-rawmidi]
snd                    39404   0 [snd-pcm-oss snd-mixer-oss snd-via82xx 
snd-pcm snd-timer snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               6532   3 [snd]

[7.4.]
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
0290-0297 : it87
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
d000-d0ff : Adaptec AHA-7850
d400-d41f : VIA Technologies, Inc. USB
  d400-d41f : usb-uhci
d800-d81f : VIA Technologies, Inc. USB (#2)
  d800-d81f : usb-uhci
dc00-dc1f : VIA Technologies, Inc. USB (#3)
  dc00-dc1f : usb-uhci
e000-e00f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  e000-e007 : ide0
  e008-e00f : ide1
e400-e4ff : VIA Technologies, Inc. VT8233 AC97 Audio Controller
  e400-e4ff : VIA8233

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-0027c40e : Kernel code
  0027c40f-0030721f : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d7ffffff : VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
d8000000-d9ffffff : PCI Bus #01
  d8000000-d9ffffff : Matrox Graphics, Inc. MGA G550 AGP
da000000-dcffffff : PCI Bus #01
  da000000-da003fff : Matrox Graphics, Inc. MGA G550 AGP
  db000000-db7fffff : Matrox Graphics, Inc. MGA G550 AGP
dd000000-dd000fff : Adaptec AHA-7850
  dd000000-dd000fff : aic7xxx
dd001000-dd0010ff : VIA Technologies, Inc. USB 2.0
  dd001000-dd0010ff : ehci-hcd
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.]
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189
        Subsystem: Giga-byte Technology: Unknown device 5000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x4
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b168 (prog-if 
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: da000000-dcffffff
        Prefetchable memory behind bridge: d8000000-d9ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
        Subsystem: Adaptec AHA-2904/Integrated AIC-7850
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at d000 [disabled] [size=256]
        Region 1: Memory at dd000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
        Subsystem: Giga-byte Technology: Unknown device 5004
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
        Subsystem: Giga-byte Technology: Unknown device 5004
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
        Subsystem: Giga-byte Technology: Unknown device 5004
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin C routed to IRQ 21
        Region 4: I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 
20 [EHCI])
        Subsystem: Giga-byte Technology: Unknown device 5004
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 10
        Interrupt: pin D routed to IRQ 19
        Region 0: Memory at dd001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
        Subsystem: Giga-byte Technology: Unknown device 5001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master 
IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: Giga-byte Technology: Unknown device 5002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 22
        Region 4: I/O ports at e000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 
Audio Controller (rev 50)
        Subsystem: Giga-byte Technology: Unknown device a002
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 22
        Region 0: I/O ports at e400 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP 
(rev 01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR 32Mb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at da000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at db000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x4


[7.6.]
Attached devices:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: TEAC     Model: CD-W512SB        Rev: 1.0H
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7]

[X.]



-- 

Antonello Biancalana
ProMIND software development - Perugia (ITALY)
e-mail: promind@libero.it

PGP key ID: D40B3BC3
PGP key fp: AC62 7264 4233 5ADD 5ADA  D4D3 9B35 6051 D40B 3BC3



