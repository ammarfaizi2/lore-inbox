Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbUAHAWe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 19:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbUAHAWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 19:22:33 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:7853 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262308AbUAHAWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 19:22:25 -0500
Date: Wed, 07 Jan 2004 16:22:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1807] New: Kernel Panic with dmx3191d (Fatal	exception in Interrupt Handler) 
Message-ID: <13870000.1073521334@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1807

           Summary: Kernel Panic with dmx3191d (Fatal exception in Interrupt
                    Handler)
    Kernel Version: 2.6.0
            Status: NEW
          Severity: normal
             Owner: andmike@us.ibm.com
         Submitter: mark.morschhaeuser@firemail.de


Distribution: gentoo Linux
Hardware Environment:
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3-
Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ Rate=x4
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dde00000-dfefffff
	Prefetchable memory behind bridge: cdb00000-ddcfffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at e400 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at ec00 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at e000 [size=256]
	Region 1: Memory at dfffff00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture
(rev 02)
	Subsystem: TERRATEC Electronic GmbH: Unknown device 1134
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at dddfe000 (32-bit, prefetchable) [size=4K]

00:08.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
	Subsystem: TERRATEC Electronic GmbH: Unknown device 1134
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at dddff000 (32-bit, prefetchable) [size=4K]

00:09.0 SCSI storage controller: DTC Technology Corp. Domex 536
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at e800 [size=32]

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if
8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235
PIPC Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at fc00 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 4200]
(rev a3) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 2: Memory at ddc80000 (32-bit, prefetchable) [size=512K]
	Expansion ROM at dfee0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3-
Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ Rate=x4



/proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1099.932
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 2162.68


/proc/modules

snd_pcm_oss 53028 1 - Live 0xf1ad1000
snd_mixer_oss 19136 1 snd_pcm_oss, Live 0xf1aba000
snd_emu10k1 69892 1 - Live 0xf1a05000
snd_rawmidi 25056 1 snd_emu10k1, Live 0xf19fd000
snd_pcm 98404 2 snd_pcm_oss,snd_emu10k1, Live 0xf1a1a000
snd_timer 25412 1 snd_pcm, Live 0xf19e5000
snd_seq_device 8136 2 snd_emu10k1,snd_rawmidi, Live 0xf19b8000
snd_ac97_codec 54084 1 snd_emu10k1, Live 0xf19ee000
snd_page_alloc 11716 2 snd_emu10k1,snd_pcm, Live 0xf19a9000
snd_util_mem 4416 1 snd_emu10k1, Live 0xf19b1000
snd_hwdep 9504 1 snd_emu10k1, Live 0xf19ad000
snd 50916 10
snd_pcm_oss,snd_mixer_oss,snd_emu10k1,snd_rawmidi,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep,
Live 0xf19ce000
floppy 59220 0 - Live 0xf19be000
nvidia 1700716 10 - Live 0xf1b57000
parport_pc 18664 1 - Live 0xf1931000
lp 9792 0 - Live 0xf1922000
parport 28832 2 parport_pc,lp, Live 0xf197d000
shfs 67540 0 - Live 0xf193c000
tuner 15372 0 - Live 0xf1937000
bttv 127340 0 - Live 0xf1952000
video_buf 22276 1 bttv, Live 0xf192a000
i2c_algo_bit 10184 1 bttv, Live 0xf18e5000
btcx_risc 4808 1 bttv, Live 0xf18ed000
v4l2_common 4608 1 bttv, Live 0xf18d7000
videodev 9792 1 bttv, Live 0xf18e9000
tvaudio 21964 0 - Live 0xf191b000
via686a 19784 0 - Live 0xf1915000
i2c_sensor 2944 1 via686a, Live 0xf18da000
i2c_viapro 6028 0 - Live 0xf18e2000
i2c_core 25288 7 tuner,bttv,i2c_algo_bit,tvaudio,via686a,i2c_sensor,i2c_viapro,
Live 0xf190d000
sg 32664 0 - Live 0xf1904000
sr_mod 15844 0 - Live 0xf18dd000
scsi_mod 77420 2 sg,sr_mod, Live 0xf18f0000

/proc/scsi/scsi
Attached devices:


Software Environment:
ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux moon 2.6.0 #1 Sun Jan 4 19:27:43 CET 2004 i686 AMD Athlon(tm) Processor
AuthenticAMD GNU/Linux
 
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.15-pre4
e2fsprogs              1.34
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.12
Net-tools              1.60
Kbd                    1.06
Sh-utils               5.0
Modules Loaded         snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi snd_pcm
snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep
snd floppy nvidia parport_pc lp parport shfs tuner bttv video_buf i2c_algo_bit
btcx_risc v4l2_common videodev tvaudio via686a i2c_sensor i2c_viapro i2c_core sg
sr_mod scsi_mod


Problem Description:
With Kernel 2.4.x I was able to use my SCSI-Controller and the connected
Mustek-Scanner but when I try to load the kernel-module for the SCSI-Controller
on 2.6.0 (and 2.6test) kernel, the system hangs (see message above).
I had this error three times: 
the first time I used a 2.6test kernel (I don't know the right version number
any more :-/): 
I had compiled all SCSI-Modules (static) into the kernel (even scsi-cdrom and
ide-scsi for my burner; on 2.6 I don't use ide-scsi anymore) but after booting
IDE-modules I had an endless loop with lots of output (too fast to read it).
The second time I was logged in as user with a root-console and modprobed the
module (I used a newer testkernel that time).
The System hang and after a reboot some KDE-programs had lost their
configuration (for this user only). I use a journalling filesystem (reiser) on
that partition so that error is strange.
The second time I did not log in graphically, I tried modprobe from the console.
(on 2.6.0 stable kernel)
The system died once again and now KDE is totally shreddered (though it didn't
run except from the login-screen): it looks like a normal X-Session but can do
nothing (no windows-resizing, no taskbar; really nothing)

Here is the error-output (I had to write it on a piece of paper, I hope I did no
mistakes):

---snip---
# modprobe dmx3191d
------------[cut here]-------------
Kernel BUG at kernel/printk.c: 526!
invalid operand: 0000 [#1]
CPU: 0
EIP: 0060: [<c011d7e0>] Tainted: PF
EFLAGS: 00010206
EIP is at acquire_console_sem+0x10/0x40
eax: eff8a000  ebx: effedc00  ecx: 00000000  edx: effedc08
esi: c0308c04  edi: c0308c00  ebp: eff8a000  esp: eff8bf64
ds: 007b  es: 007b ss: 0068

Process events/0 (pid:3, threadinfo=eff8a000 task=eff8ec80)
Stack: c021ddac eff8a000 effedc08 c012c13d 00000000 eff8bfa0 00000000
       effedc18 effedc10 00000000 c021dda0 effedc08 eff8a000 effedc00 00000001
       00000000 c0119910 00010000 00000000 eff8eca0 c17b3f10 c010909e 00000000
Call Trace:
[<c021ddac>] console_callback +0xc/0xc0
[<c012c13d>] worker_thread +0x1dd/0x2d0
[<c021dda0>] console_callback +0x0/0xc0
[<c0119910>] default_wake_function +0x0/0x20
[<c012bf60>] worker_thread +0x0/0x2d0
[<c01070c9>] kernel_thread_helper +0x5/0xc

Code: 0f 0b 0e 02 81 68 2c c0 b9 90 df 2f c0 ff 0d 90 df 2f c0 0f

<0> Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing
---snip---
The message ended there and the system was completely frozen: it accepted no
input, just the power/reset-button.

Steps to reproduce:
I have read on a Linuxforum that someone had a similar problem with the atp870u
Controller (though his system "only" had a hangup and no messed up KDE), so
maybe it can be reproduced by using such a controller and just modprobe it's module.

Good luck with that bug, I need to repair my system now...


