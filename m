Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265032AbUFMJNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265032AbUFMJNg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 05:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265033AbUFMJNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 05:13:35 -0400
Received: from mid-1.inet.it ([213.92.5.18]:38877 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S265032AbUFMJNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 05:13:20 -0400
Message-ID: <40CC1A93.6040808@yahoo.it>
Date: Sun, 13 Jun 2004 11:12:51 +0200
From: Sandro <nahidesafe-linux@yahoo.it>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.7) Gecko/20040514
X-Accept-Language: it, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Toshiba 1800-100 linux-2.6.x Driver for the SMC Infrared
 Communications Controller does not work
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
[2.] Full description of the problem/report:
[3.] Keywords (i.e., modules, networking, kernel):
[4.] Kernel version (from /proc/version):
[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
      problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
[7.2.] Processor information (from /proc/cpuinfo):
[7.3.] Module information (from /proc/modules):
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[7.5.] PCI information ('lspci -vvv' as root)
[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

====================================================================
[1.] One line summary of the problem
Toshiba 1800-100 linux-2.6.x Driver for the SMC Infrared Communications
Controller does not work

[2.] Full description of the problem/report:
Well, I've not much more to sat than what I've said in the one line
summary. I've a Toshiba 1800-100 and I've tried all the latest versions
of the 2.6.x kernel. The IRDA port doesn't work.
Reading the dmesg output obtained from a 2.6.7-rc3 monolitic kernel:

found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
smsc_superio_flat(): IrDA not enabled
smsc_superio_flat(): fir: 0x00, sir: 0x00, dma: 15, irq: 0, mode: 0x02
ali_ircc_probe_53(), No DMA channel assigned !
ali-ircc, Wrong chip version ff

I've tried to pass the following options as read on the
irda.sourceforge.net site:

ircc_dma=3 ircc_irq=7 ircc_cfg=0x2e ircc_sir=0x2e8 ircc_fir=0x2f8

Then I've tried with those given by windows:
ircc_irq=10 ircc_dma=1
(I've not understand how to use the I/O intervals: 02E8-02EF, 0110-0117)

It simply doesn't want to work.

lspci said:

0000:00:00.0 Host bridge: ALi Corporation M1632M Northbridge+Trident
(rev 01)
0000:00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller (rev 01)
0000:00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
0000:00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
0000:00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI
AC-Link Controller Audio Device (rev 01)
0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge
[Aladdin IV]
0000:00:08.0 Bridge: ALi Corporation M7101 PMU
0000:00:11.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to
Cardbus Bridge with ZV Support (rev 32)
0000:00:11.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to
Cardbus Bridge with ZV Support (rev 32)
0000:01:00.0 VGA compatible controller: Trident Microsystems
CyberBlade/i1 (rev 5d)

[3.] Keywords (i.e., modules, networking, kernel):
irda, toshiba, 1800-100, LPC47N227, networking

[4.] Kernel version (from /proc/version):
Linux 2.6.7-rc3

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux tramontana 2.6.7-rc3 #3 Thu Jun 10 16:19:25 CEST 2004 i686 Celeron
(Coppermine) GenuineIntel GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.8
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.35
pcmcia-cs              3.2.7
PPP                    2.4.2
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         ds ehci_hcd tridentfb yenta_socket pcmcia_core
usbhid usbmouse ohci_hcd ali_agp agpgart evdev snd_ali5451
snd_ac97_codec snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device
snd_pcm_oss snd_pcm snd_page_alloc snd_timer snd_mixer_oss snd soundcore
rtc usbcore

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Celeron (Coppermine)
stepping	: 10
cpu MHz		: 801.537
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips	: 1589.24

[7.3.] Module information (from /proc/modules):
nls_cp437 5312 1 - Live 0xc85b5000
vfat 11968 1 - Live 0xc85b1000
fat 39040 1 vfat, Live 0xc85b8000
ds 13924 4 - Live 0xc8576000
ehci_hcd 26340 0 - Live 0xc8559000
tridentfb 17496 0 - Live 0xc8570000
yenta_socket 18176 0 - Live 0xc856a000
pcmcia_core 58420 2 ds,yenta_socket, Live 0xc857b000
usbhid 29984 0 - Live 0xc8561000
usbmouse 4256 0 - Live 0xc852a000
ohci_hcd 18852 0 - Live 0xc8551000
ali_agp 5248 1 - Live 0xc851f000
agpgart 27336 1 ali_agp, Live 0xc84d4000
evdev 7232 0 - Live 0xc84d1000
snd_ali5451 21096 0 - Live 0xc8518000
snd_ac97_codec 66308 1 snd_ali5451, Live 0xc852e000
snd_seq_oss 31520 0 - Live 0xc84dc000
snd_seq_midi_event 6080 1 snd_seq_oss, Live 0xc84ce000
snd_seq 49520 4 snd_seq_oss,snd_seq_midi_event, Live 0xc850a000
snd_seq_device 6376 2 snd_seq_oss,snd_seq, Live 0xc84cb000
snd_pcm_oss 49800 0 - Live 0xc84fc000
snd_pcm 86152 2 snd_ali5451,snd_pcm_oss, Live 0xc84e5000
snd_page_alloc 8872 1 snd_pcm, Live 0xc849f000
snd_timer 21252 2 snd_seq,snd_pcm, Live 0xc8492000
snd_mixer_oss 17568 1 snd_pcm_oss, Live 0xc8499000
snd 47396 10
snd_ali5451,snd_ac97_codec,snd_seq_oss,snd_seq_midi_event,snd_seq,snd_seq_device,snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss, 



Live 0xc84be000
soundcore 7264 1 snd, Live 0xc848f000
rtc 10168 0 - Live 0xc848b000
usbcore 98560 6 ehci_hcd,usbhid,usbmouse,ohci_hcd, Live 0xc84a4000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)


ioports:
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
4800-48ff : PCI CardBus #06
4c00-4cff : PCI CardBus #06
ed00-edff : 0000:00:06.0
   ed00-edff : ALI 5451
ee00-ee3f : 0000:00:08.0
   ee08-ee0b : ACPI timer
   ee10-ee15 : ACPI CPU throttle
ef00-ef1f : 0000:00:08.0
eff0-efff : 0000:00:04.0
   eff0-eff7 : ide0
   eff8-efff : ide1

iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000e0000-000eedff : reserved
000eee00-000eefff : ACPI Non-volatile Storage
000f0000-000fffff : System ROM
00100000-077effff : System RAM
   00100000-002f97a4 : Kernel code
   002f97a5-003b6adf : Kernel data
077f0000-077fffff : ACPI Tables
07800000-07ffffff : reserved
10000000-10000fff : 0000:00:11.0
   10000000-10000fff : yenta_socket
10001000-10001fff : 0000:00:11.1
   10001000-10001fff : yenta_socket
10400000-107fffff : PCI CardBus #02
10800000-10bfffff : PCI CardBus #02
10c00000-10ffffff : PCI CardBus #06
11000000-113fffff : PCI CardBus #06
f8000000-fbffffff : 0000:00:00.0
fdffe000-fdffefff : 0000:00:06.0
fdfff000-fdffffff : 0000:00:02.0
   fdfff000-fdffffff : ohci_hcd
fe000000-ff7fffff : PCI Bus #01
   fe000000-fe7fffff : 0000:01:00.0
   fefe0000-feffffff : 0000:01:00.0
     fefe0000-feffffff : tridentfb
   ff000000-ff7fffff : 0000:01:00.0
     ff000000-ff2fffff : vesafb
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
0000:00:00.0 Host bridge: ALi Corporation M1632M Northbridge+Trident
(rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable)
	Capabilities: [b0] AGP version 1.0
		Status: RQ=28 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit-
FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x2
	Capabilities: [a4] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller (rev 01)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fe000000-ff7fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
	Subsystem: Toshiba America Info Systems: Unknown device 0004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fdfff000 (32-bit, non-prefetchable)
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c3) (prog-if f0)
	Subsystem: Toshiba America Info Systems: Unknown device 0004
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 255
	Region 4: I/O ports at eff0 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI
AC-Link Controller Audio Device (rev 01)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ed00
	Region 1: Memory at fdffe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge
[Aladdin IV]
	Subsystem: Toshiba America Info Systems: Unknown device 0004
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 Bridge: ALi Corporation M7101 PMU
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:11.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to
Cardbus Bridge with ZV Support (rev 32)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:00:11.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to
Cardbus Bridge with ZV Support (rev 32)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=0
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:01:00.0 VGA compatible controller: Trident Microsystems
CyberBlade/i1 (rev 5d) (prog-if 00 [VGA])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 8
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ff000000 (32-bit, non-prefetchable)
	Region 1: Memory at fefe0000 (32-bit, non-prefetchable) [size=128K]
	Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=8M]
	Capabilities: [80] AGP version 1.0
		Status: RQ=33 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit-
FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [90] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[X.] Other notes, patches, fixes, workarounds:

I've tried to contact directly Daniele Peri some time ago but I've not
received any reply. Then I tried to contact irda-user list, but the list 
doesn't accept any external mail and don't let me subscribe to the list.
As latest resource I have decided to write here.
As other notes I can only say that the Toshiba
Satellite 1800-100 has a lot of trouble under linux. ACPI is not fully
supported, the trident framebuffer driver give some psichedelic effects,
the internal modem does not work, and this: the irda don't work.
If somebody have succesfully configured a toshiba 1800-100, please
contact me at this address: nahidesafe-linux at yahoo dot it
(I'm sorry for my not very good english)



