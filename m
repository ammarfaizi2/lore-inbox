Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVK2RXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVK2RXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 12:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVK2RXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 12:23:10 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:39982 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932245AbVK2RXJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 12:23:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cdiYV6rxwbdhBPmIj8YkXI/IyKnXho0TRTpiFf7bLgqlefoYDeVsvGAoMQCLVVC9f/fIjgFaWvH3txs9yrhqb9fmKGTQXzPQRr02xRskAF5ffde12Ep2tAJN6ZLZao9wfoVheCyDJHhzJQk8mIliNrn2YUCdBj4+k1cX1EaWAaA=
Message-ID: <bb8e68f40511290923x63129dd8xd9907b94b344a5@mail.gmail.com>
Date: Tue, 29 Nov 2005 09:23:08 -0800
From: Florian <florian.winterstein@gmail.com>
Reply-To: f-win@gmx.net
To: linux-kernel@vger.kernel.org
Subject: Kernal oops with drm radeon
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

Trying to play a recording with mythtv creates a kernel oops (every time)

[2.] Full description of the problem/report:

see above

[3.] Keywords (i.e., modules, networking, kernel):


drm radeon mythtv

[4.] Kernel version (from /proc/version):

Linux version 2.6.14.2 (root@florian) (gcc version 3.3.6 (Debian
1:3.3.6-7)) #2 Wed Nov 23 09:46:25 PST 2005



[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Nov 29 08:58:33 florian kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000004

Nov 29 08:58:33 florian kernel:  printing eip:
Nov 29 08:58:33 florian kernel: c0129955
Nov 29 08:58:33 florian kernel: *pde = 00000000
Nov 29 08:58:33 florian kernel: Oops: 0002 [#3]
Nov 29 08:58:33 florian kernel: Modules linked in: bttv video_buf
v4l2_common btcx_risc lirc_i2c lirc_dev radeon drm ip_nat_ftp
ip_conntrack_ftp snd_pcm_oss snd_mixer_oss forcedeth tulip msp3400
saa7115 tda9887

wm8775 cx25840 firmware_class tuner tveeprom snd_intel8x0
snd_ac97_codec snd_ac97_bus ivtv snd_pcm i2c_algo_bit i2c_nforce2
snd_timer snd videodev i2c_core soundcore snd_page_alloc nvidia_agp
agpgart
Nov 29 08:58:33 florian kernel: CPU:    0

Nov 29 08:58:33 florian kernel: EIP:    0060:[add_wait_queue+21/48]   
Not tainted VLI
Nov 29 08:58:33 florian kernel: EFLAGS: 00010046   (2.6.14.2)
Nov 29 08:58:33 florian kernel: EIP is at add_wait_queue+0x15/0x30

Nov 29 08:58:33 florian kernel: eax: dfd0d208   ebx: 00000000   ecx:
d756bebc   edx: d756beb0
Nov 29 08:58:33 florian kernel: esi: 00000246   edi: d756bea4   ebp:
dfd0d000   esp: d756be6c
Nov 29 08:58:33 florian kernel: ds: 007b   es: 007b   ss: 0068

Nov 29 08:58:33 florian kernel: Process mythfrontend (pid: 5734,
threadinfo=d756a000 task=c63d15a0)
Nov 29 08:58:33 florian kernel: Stack: d756a000 00771005 e1a26f84
dfd0d000 dd6e8800 00000000 dfd0d208 00000000

Nov 29 08:58:33 florian kernel:        dffef0c0 00000000 c63d15a0
c0113b20 00000000 00000000 00000013 00000006
Nov 29 08:58:33 florian kernel:        dfd0d000 00000000 c63d15a0
c0113b20 00000000 00000000 b0a920d0 c01e668c

Nov 29 08:58:33 florian kernel: Call Trace:
Nov 29 08:58:33 florian kernel:  [pg0+560476036/1069917184]
radeon_driver_vblank_wait+0xa4/0x150 [radeon]
Nov 29 08:58:33 florian kernel:  [default_wake_function+0/32] default_wake_funct

ion+0x0/0x20
Nov 29 08:58:33 florian kernel:  [default_wake_function+0/32]
default_wake_function+0x0/0x20
Nov 29 08:58:33 florian kernel:  [copy_from_user+76/192]
copy_from_user+0x4c/0xc0
Nov 29 08:58:33 florian kernel:  [pg0+551788680/1069917184]
drm_wait_vblank+0x1f8/0x210 [drm]

Nov 29 08:58:33 florian kernel:  [chrdev_open+174/336] chrdev_open+0xae/0x150
Nov 29 08:58:33 florian kernel:  [pg0+551782203/1069917184]
drm_ioctl+0xeb/0x1b4 [drm]
Nov 29 08:58:33 florian kernel:  [convert_eip_to_linear+170/176]
convert_eip_to_linear+0xaa/0xb0

Nov 29 08:58:33 florian kernel:  [convert_eip_to_linear+170/176]
convert_eip_to_linear+0xaa/0xb0
Nov 29 08:58:33 florian kernel:  [do_ioctl+88/128] do_ioctl+0x58/0x80
Nov 29 08:58:33 florian kernel:  [convert_eip_to_linear+170/176]
convert_eip_to_linear+0xaa/0xb0

Nov 29 08:58:33 florian kernel:  [vfs_ioctl+101/464] vfs_ioctl+0x65/0x1d0
Nov 29 08:58:33 florian kernel:  [convert_eip_to_linear+170/176]
convert_eip_to_linear+0xaa/0xb0
Nov 29 08:58:33 florian kernel:  [sys_ioctl+69/128] sys_ioctl+0x45/0x80

Nov 29 08:58:33 florian kernel:  [convert_eip_to_linear+170/176]
convert_eip_to_linear+0xaa/0xb0
Nov 29 08:58:33 florian kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 29 08:58:33 florian kernel:  [convert_eip_to_linear+170/176]
convert_eip_to_linear+0xaa/0xb0

Nov 29 08:58:33 florian kernel: Code: 90 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 90 90 90 90 90 83 ec 08 83 22 fe 89 1c 24 89 74 24
04 9c 5e fa 8b 18 8d 4a 0c <89> 4b 04 89 5a 0c 89 41 04 89 08 56 9d 8b

74 24 04 8b 1c 24 83

[6.] A small shell script or example program which triggers the
     problem (if possible)

-

[7.] Environment

Debian testing

[7.1.] Software (add the output of the ver_linux script here)




[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2400+

stepping        : 1
cpu MHz         : 2004.789
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
bogomips        : 4015.44



[7.3.] Module information (from /proc/modules):

bttv 154576 0 - Live 0xe2281000
video_buf 17284 1 bttv, Live 0xe11e9000
v4l2_common 4736 1 bttv, Live 0xe11cc000
btcx_risc 3912 1 bttv, Live 0xe090d000

lirc_i2c 8452 1 - Live 0xe11c8000
lirc_dev 12644 1 lirc_i2c, Live 0xe11c3000
radeon 104000 4 - Live 0xe1a1c000
drm 64148 5 radeon, Live 0xe11d8000
ip_nat_ftp 2752 0 - Live 0xe0811000
ip_conntrack_ftp 6128 1 ip_nat_ftp, Live 0xe0904000

snd_pcm_oss 47456 0 - Live 0xe11b6000
snd_mixer_oss 16832 1 snd_pcm_oss, Live 0xe0959000
forcedeth 18880 0 - Live 0xe08da000
tulip 47456 0 - Live 0xe0971000
msp3400 26992 0 - Live 0xe0951000
saa7115 13328 0 - Live 0xe08ff000

tda9887 12432 0 - Live 0xe08fa000
wm8775 5340 0 - Live 0xe08d7000
cx25840 41172 0 - Live 0xe0945000
firmware_class 7936 2 bttv,cx25840, Live 0xe08d4000
tuner 23264 0 - Live 0xe0868000
tveeprom 12524 1 bttv, Live 0xe08cf000

snd_intel8x0 29536 0 - Live 0xe08f1000
snd_ac97_codec 92092 1 snd_intel8x0, Live 0xe08a2000
snd_ac97_bus 1856 1 snd_ac97_codec, Live 0xe0813000
ivtv 215380 1 - Live 0xe090f000
snd_pcm 79048 3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec, Live 0xe08ba000

i2c_algo_bit 8776 2 bttv,ivtv, Live 0xe0864000
i2c_nforce2 5696 0 - Live 0xe0861000
snd_timer 20356 1 snd_pcm, Live 0xe083a000
snd 45028 6 snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,
Live 0xe0870000

videodev 7104 2 bttv,ivtv, Live 0xe082d000
i2c_core 17360 11
bttv,lirc_i2c,msp3400,saa7115,tda9887,wm8775,cx25840,tuner,tveeprom,i2c_algo_bit,i2c_nforce2,
Live 0xe0834000
soundcore 7200 1 snd, Live 0xe0818000

snd_page_alloc 8456 2 snd_intel8x0,snd_pcm, Live 0xe0829000
nvidia_agp 5980 1 - Live 0xe0815000
agpgart 29320 2 drm,nvidia_agp, Live 0xe081b000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1

01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
5000-5007 : nForce2 SMBus
5040-5047 : nForce2 SMBus
9000-9fff : PCI Bus #01

  9000-90ff : 0000:01:08.0
    9000-90ff : tulip
a000-afff : PCI Bus #02
  a000-a0ff : 0000:02:00.0
b000-b0ff : 0000:00:06.0
  b000-b0ff : NVidia nForce2
b400-b47f : 0000:00:06.0
  b400-b47f : NVidia nForce2

c000-c01f : 0000:00:01.1
c400-c407 : 0000:00:04.0
  c400-c407 : forcedeth
f000-f00f : 0000:00:09.0
  f000-f007 : ide0
  f008-f00f : ide1

cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved

000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000cc000-000cd7ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-002ca789 : Kernel code
  002ca78a-0035bb13 : Kernel data

1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d7ffffff : 0000:00:00.0
d8000000-dfffffff : PCI Bus #02
  d8000000-dfffffff : 0000:02:00.0
e0000000-e7ffffff : PCI Bus #01

  e0000000-e3ffffff : 0000:01:09.0
    e0000000-e200ffff : ivtv0
  e4000000-e7ffffff : 0000:01:0a.0
    e4000000-e600ffff : ivtv1
e8000000-e9ffffff : PCI Bus #02
  e8000000-e801ffff : 0000:02:00.0
  e9000000-e907ffff : 0000:02:
00.0
ea000000-ebffffff : PCI Bus #01
  ea000000-ea01ffff : 0000:01:08.0
  eb000000-eb0003ff : 0000:01:08.0
    eb000000-eb0003ff : tulip
ec000000-ec07ffff : 0000:00:05.0
ec080000-ec080fff : 0000:00:06.0

  ec080000-ec080fff : NVidia nForce2
ec082000-ec082fff : 0000:00:02.1
ec083000-ec0830ff : 0000:00:02.2
ec084000-ec084fff : 0000:00:04.0
  ec084000-ec084fff : forcedeth
ec085000-ec085fff : 0000:00:02.0
fec00000-fec00fff : reserved

fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different
version?) (rev c1)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [40] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit-
FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
	Capabilities: [60] #08 [2001]

0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
	Subsystem: EPoX Computer Co., Ltd.: Unknown device 1000
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
	Subsystem: EPoX Computer Co., Ltd.: Unknown device 1000
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
	Subsystem: EPoX Computer Co., Ltd.: Unknown device 1000
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
	Subsystem: EPoX Computer Co., Ltd.: Unknown device 1000
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
	Subsystem: EPoX Computer Co., Ltd.: Unknown device 1000
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
	Subsystem: EPoX Computer Co., Ltd.: Unknown device 1000
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [48] #08 [01e1]

0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
	Subsystem: EPoX Computer Co., Ltd.: Unknown device 1000
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at c000 [size=32]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a3) (prog-if 10 [OHCI])
	Subsystem: EPoX Computer Co., Ltd.: Unknown device 1000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at ec085000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a3) (prog-if 10 [OHCI])
	Subsystem: EPoX Computer Co., Ltd.: Unknown device 1000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 0
	Region 0: Memory at ec082000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a3) (prog-if 20 [EHCI])
	Subsystem: EPoX Computer Co., Ltd.: Unknown device 1000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 5
	Region 0: Memory at ec083000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] #0a [2080]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
Controller (rev a1)
	Subsystem: EPoX Computer Co., Ltd.: Unknown device 1000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ec084000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at c400 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

0000:00:05.0 Multimedia audio controller: nVidia Corporation nForce
Audio Processing Unit (rev a2)
	Subsystem: EPoX Computer Co., Ltd.: Unknown device 1000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 3000ns max)
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2
AC97 Audio Controler (MCP) (rev a1)
	Subsystem: EPoX Computer Co., Ltd.: Unknown device 1000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at b000 [size=256]
	Region 1: I/O ports at b400 [size=128]
	Region 2: Memory at ec080000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI
Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: ea000000-ebffffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
(prog-if 8a [Master SecP PriP])
	Subsystem: EPoX Computer Co., Ltd.: Unknown device 1000
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: e8000000-e9ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:01:08.0 Ethernet controller: Linksys NC100 Network Everywhere
Fast Ethernet 10/100 (rev 11)
	Subsystem: Linksys: Unknown device 0570
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (16000ns min, 32000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 9000 [size=256]
	Region 1: Memory at eb000000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at ea000000 [disabled] [size=128K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:09.0 Multimedia video controller: Internext Compression Inc
iTVC16 (CX23416) MPEG-2 Encoder (rev 01)
	Subsystem: Hauppauge computer works Inc.: Unknown device 8801
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (32000ns min, 2000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:0a.0 Multimedia video controller: Internext Compression Inc
iTVC15 MPEG-2 Encoder (rev 01)
	Subsystem: Hauppauge computer works Inc. WinTV PVR-250
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (32000ns min, 2000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:00.0 VGA compatible controller: ATI Technologies Inc Radeon
R100 QD [Radeon 7200] (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Radeon AIW
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at a000 [size=256]
	Region 2: Memory at e9000000 (32-bit, non-prefetchable) [size=512K]
	Expansion ROM at e8000000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit-
FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)
 cat /proc/scsi/scsi

cat: /proc/scsi/scsi: No such file or directory


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):


[X.] Other notes, patches, fixes, workarounds:
