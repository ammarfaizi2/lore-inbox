Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVA3WKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVA3WKn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 17:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVA3WKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 17:10:43 -0500
Received: from mail.euc.de ([62.53.192.33]:41222 "EHLO mail.euc.de")
	by vger.kernel.org with ESMTP id S261802AbVA3WJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 17:09:49 -0500
From: Alexander Kirsch <kirsch@euc.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: oops with ieee1394 + alsa
Date: Sun, 30 Jan 2005 23:09:45 +0100
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_psV/B/hu78is7lv"
Message-Id: <200501302309.45972.kirsch@euc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_psV/B/hu78is7lv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Developers,

I receive kernel oops messages after including alsa sound api functions 
in my program wich receives and displays videostreams from two ieee1394
videocameras with libdc1394. 

videostreaming and alsa audio output work fine on their own, but together it 
seems as if the dma-controlling becomes somehow confused on the kernel-level,
upgrading from kernel 2.6.5 to current 2.6.10 did not help.
my program runs for about 1 second before it crashes with

(dc1394_capture.c) VIDEO1394_IOC_LISTEN_WAIT/POLL_BUFFER ioctl failed!
(dc1394_capture.c) VIDEO1394_IOC_LISTEN_QUEUE_BUFFER failed in done with buffer!
segmentation fault

and the kernelmessages as shown in the attachment. 
trying to start my prog again fails - only reboot enables the program to run briefly again.
unfortunately i cannot send my two cameras with this mail to try out the problem ..

greetings,
alex
 



--Boundary-00=_psV/B/hu78is7lv
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ver_linux.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ver_linux.txt"

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux schmu 2.6.10 #1 Sun Jan 30 21:24:36 CET 2005 i686 athlon i386 GNU/Linux
 
Gnu C                  3.3.3
Gnu make               3.80
binutils               2.15.90.0.1.1
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre10
e2fsprogs              1.34
jfsutils               1.1.5
reiserfsprogs          3.6.13
reiser4progs           line
xfsprogs               2.6.3
PPP                    2.4.2
isdn4k-utils           3.4
nfs-utils              1.0.6
Linux C Library        02 21:53 /lib/tls/libc.so.6
Dynamic linker (ldd)   2.3.3
Linux C++ Library      5.0.5
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         pppoe pppox af_packet ppp_generic slhc edd joydev sg st sd_mod sr_mod scsi_mod ide_cd cdrom nvram usbserial parport_pc lp parport snd_seq_oss speedstep_lib snd_pcm_oss freq_table snd_mixer_oss snd_seq_midi snd_seq_midi_event snd_seq thermal processor fan snd_via82xx snd_mpu401_uart button battery ac snd_ens1371 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd soundcore video1394 ipv6 snd_page_alloc gameport 8139too mii ohci1394 ehci_hcd nvidia_agp agpgart ohci_hcd i2c_nforce2 i2c_core evdev xfrm_user ipcomp esp4 ah4 af_key usbcore forcedeth raw1394 ieee1394 dm_mod reiserfs

--Boundary-00=_psV/B/hu78is7lv
Content-Type: text/plain;
  charset="iso-8859-1";
  name="kerneloops"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kerneloops"

Jan 30 21:46:52 schmu kernel: video1394_0: Iso receive DMA: 4 buffers of size 155648 allocated for a frame size 153600, each with 39 prgs
Jan 30 21:46:52 schmu kernel: video1394_0: iso context 0 listen on channel 1
Jan 30 21:46:52 schmu kernel: mask: 0000000000000004 usage: 0000000000000002
Jan 30 21:46:52 schmu kernel: video1394_0: Iso receive DMA: 4 buffers of size 155648 allocated for a frame size 153600, each with 39 prgs
Jan 30 21:46:52 schmu kernel: video1394_0: iso context 1 listen on channel 2
Jan 30 21:46:52 schmu kernel: video1394_0: Buffer 2 is already used
Jan 30 21:46:52 schmu kernel: video1394_0: Buffer 1 is already used
Jan 30 21:46:52 schmu kernel: video1394_0: Buffer 1 is already used
Jan 30 21:46:52 schmu kernel: video1394_0: Buffer 0 is already used
Jan 30 21:46:52 schmu kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000268
Jan 30 21:46:52 schmu kernel:  printing eip:
Jan 30 21:46:52 schmu kernel: f0aaa388
Jan 30 21:46:52 schmu kernel: *pde = 00000000
Jan 30 21:46:52 schmu kernel: Oops: 0002 [#1]
Jan 30 21:46:52 schmu kernel: Modules linked in: edd joydev sg st sd_mod sr_mod scsi_mod ide_cd cdrom nvram usbserial parport_pc lp parport snd_seq_oss speedstep_lib snd_pcm_oss freq_table snd_mixer_oss snd_seq_midi snd_seq_midi_event snd_seq thermal processor fan snd_via82xx snd_mpu401_uart button battery ac snd_ens1371 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd soundcore video1394 ipv6 snd_page_alloc gameport 8139too mii ohci1394 ehci_hcd nvidia_agp agpgart ohci_hcd i2c_nforce2 i2c_core evdev xfrm_user ipcomp esp4 ah4 af_key usbcore forcedeth raw1394 ieee1394 dm_mod reiserfs
Jan 30 21:46:52 schmu kernel: CPU:    0
Jan 30 21:46:52 schmu kernel: EIP:    0060:[pg0+812192648/1069437952]    Not tainted VLI
Jan 30 21:46:52 schmu kernel: EIP:    0060:[<f0aaa388>]    Not tainted VLI
Jan 30 21:46:52 schmu kernel: EFLAGS: 00210002   (2.6.10) 
Jan 30 21:46:52 schmu kernel: EIP is at video1394_ioctl+0x408/0xe30 [video1394]
Jan 30 21:46:52 schmu kernel: eax: 00000270   ebx: e856dac0   ecx: 00000004   edx: ed23dde0
Jan 30 21:46:52 schmu kernel: esi: 00000000   edi: e975b5e0   ebp: 00200246   esp: e2d71efc
Jan 30 21:46:52 schmu kernel: ds: 007b   es: 007b   ss: 0068
Jan 30 21:46:52 schmu kernel: Process iprod14 (pid: 14693, threadinfo=e2d70000 task=ea801ac0)
Jan 30 21:46:52 schmu kernel: Stack: 00000040 00000000 00013e2c c02666ad e2d71f44 00000001 00013e2c 00000001 
Jan 30 21:46:52 schmu kernel:        c0266680 edc41e84 e7df62e0 c014ea9b 00000000 00000000 00000000 00000000 
Jan 30 21:46:52 schmu kernel:        ec102920 00000001 40610008 00000000 405e08dc 00000001 00000000 dfffe4a0 
Jan 30 21:46:52 schmu kernel: Call Trace:
Jan 30 21:46:52 schmu kernel:  [sock_writev+45/64] sock_writev+0x2d/0x40
Jan 30 21:46:52 schmu kernel:  [<c02666ad>] sock_writev+0x2d/0x40
Jan 30 21:46:52 schmu kernel:  [sock_writev+0/64] sock_writev+0x0/0x40
Jan 30 21:46:52 schmu kernel:  [<c0266680>] sock_writev+0x0/0x40
Jan 30 21:46:52 schmu kernel:  [do_readv_writev+427/528] do_readv_writev+0x1ab/0x210
Jan 30 21:46:52 schmu kernel:  [<c014ea9b>] do_readv_writev+0x1ab/0x210
Jan 30 21:46:52 schmu kernel:  [sys_ioctl+388/544] sys_ioctl+0x184/0x220
Jan 30 21:46:52 schmu kernel:  [<c015dc34>] sys_ioctl+0x184/0x220
Jan 30 21:46:52 schmu kernel:  [pg0+812191616/1069437952] video1394_ioctl+0x0/0xe30 [video1394]
Jan 30 21:46:52 schmu kernel:  [<f0aa9f80>] video1394_ioctl+0x0/0xe30 [video1394]
Jan 30 21:46:52 schmu kernel:  [sysenter_past_esp+82/121] sysenter_past_esp+0x52/0x79
Jan 30 21:46:52 schmu kernel:  [<c0102bd9>] sysenter_past_esp+0x52/0x79
Jan 30 21:46:52 schmu kernel: Code: 44 24 64 01 f2 c1 e0 04 01 f8 8b 40 0c 83 e0 f0 83 c8 01 89 42 f8 8b 4c 24 64 8b 53 70 89 4b 34 8b 43 50 c1 e0 04 8b 34 8a 01 f0 <c7> 40 f8 00 00 00 00 55 9d 8b 4c 24 24 8b bb 88 00 00 00 8b 51 
Jan 30 21:46:52 schmu kernel:  <3>ohci1394: fw-host0: Unrecoverable error!
Jan 30 21:46:52 schmu kernel: ohci1394: fw-host0: Iso Recv 0 Context died: ctrl[8000884e] cmdptr[c17688d1] match[f0000101]

--Boundary-00=_psV/B/hu78is7lv
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lspcivvv.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspcivvv.txt"

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable)
	Capabilities: [40] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x1
	Capabilities: [60] #08 [2001]

0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 0 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [48] #08 [01e1]

0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e400
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at ea003000 (32-bit, non-prefetchable)
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 20
	Region 0: Memory at ea004000 (32-bit, non-prefetchable)
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 22
	Region 0: Memory at ea005000 (32-bit, non-prefetchable)
	Capabilities: [44] #0a [2080]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at ea000000 (32-bit, non-prefetchable)
	Region 1: I/O ports at d000 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
	Subsystem: Asustek Computer, Inc.: Unknown device 8095
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d400
	Region 1: I/O ports at d800 [size=128]
	Region 2: Memory at ea001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e9000000-e9ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Expansion ROM at 0000c000 [disabled] [size=4K]
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e6000000-e8ffffff
	Prefetchable memory behind bridge: e4000000-e5ffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:01:06.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at e9000000 (32-bit, non-prefetchable)
	Region 1: I/O ports at c000 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at c400
	Region 1: Memory at e9001000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:08.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at c800
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SGRAM
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e4000000 (32-bit, prefetchable)
	Region 1: Memory at e6000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at e7000000 (32-bit, non-prefetchable) [size=8M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1


--Boundary-00=_psV/B/hu78is7lv--
