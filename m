Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUCAUAh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 15:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUCAUAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 15:00:37 -0500
Received: from smtp3.libero.it ([193.70.192.127]:14238 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S261419AbUCAUAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 15:00:07 -0500
Message-ID: <404396C0.6070605@libero.it>
Date: Mon, 01 Mar 2004 21:02:08 +0100
From: Francesco <lufranlib@libero.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB mouse doesn't often work
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. USB mouse doesn't often work

2. I have a wireless optical USB mouse by Creative, and it doesn't often 
work. At the time of boot, the kernel gives me these messages:

hid 1-2:1.0: usb_probe_interface - got id
input: USB HID v1.10 Mouse [062a:0000] on usb-0000:00:11.2-2


or these:

Element != First TD
0: [cfcff0c0] link (0fcff100) e3 LS Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, 
PID=2d(SETUP) (buf=0fcbfbc0)
1: [cfcff100] link (0fcff140) e3 LS Length=7 MaxLen=7 DT1 EndPt=0 Dev=2, 
PID=69(IN) (buf=0faf9fc0)
2: [cfcff140] link (0fcff180) e3 LS Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, 
PID=69(IN) (buf=0faf9fc8)
3: [cfcff180] link (0fcff1c0) e3 LS Length=7 MaxLen=7 DT1 EndPt=0 Dev=2, 
PID=69(IN) (buf=0faf9fd0)
4: [cfcff1c0] link (0fcff200) e3 LS Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, 
PID=69(IN) (buf=0faf9fd8)
5: [cfcff200] link (0fcff240) e3 LS Length=7 MaxLen=7 DT1 EndPt=0 Dev=2, 
PID=69(IN) (buf=0faf9fe0)
6: [cfcff240] link (0fcff280) e3 LS Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, 
PID=69(IN) (buf=0faf9fe8)
7: [cfcff280] link (0fcff2c0) e3 LS Stalled Babble Length=7ff MaxLen=3 
DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0faf9ff0)
8: [cfcff2c0] link (00000001) e3 LS IOC Active Length=0 MaxLen=7ff DT1 
EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)
hid: probe of 1-2:1.0 failed with error -5


If the kernel gives me the first message the mouse will work, but if it 
gives me the second one it will not work.

4. Kernel version 2.6.3

5. No OOPSes

6. No scripts or programs

7.1. ver_linux output:

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.11z
mount                  2.12pre
module-init-tools      0.9.15-pre4
e2fsprogs              1.34
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.1.15
Net-tools              1.60
Kbd                    [opzione...]
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         nvidia


7.2. The processor I own is an AMD Athlon XP 2400+

7.3. Modules in use:

nvidia 2074440 12 - Live 0xd1baa000


7.3. Output of the command "cat /proc/ioports":

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
b400-b41f : 0000:00:11.3
 b400-b41f : uhci_hcd
b800-b81f : 0000:00:11.2
 b800-b81f : uhci_hcd
d000-d00f : 0000:00:11.1
 d000-d007 : ide0
 d008-d00f : ide1
d400-d4ff : 0000:00:0f.0
 d400-d4ff : 8139too
d800-d8ff : 0000:00:05.0
 d800-d8ff : CMI8738-MC6


Output of the command "cat /proc/iomem

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffbfff : System RAM
 00100000-003ddcba : Kernel code
 003ddcbb-004af8ff : Kernel data
0fffc000-0fffefff : ACPI Tables
0ffff000-0fffffff : ACPI Non-volatile Storage
e5800000-e58000ff : 0000:00:0f.0
 e5800000-e58000ff : 8139too
e6000000-e76fffff : PCI Bus #01
 e6000000-e6ffffff : 0000:01:00.0
e7700000-efffffff : PCI Bus #01
 e7800000-e787ffff : 0000:01:00.0
 e8000000-efffffff : 0000:01:00.0
   e8000000-e8ffffff : vesafb
f0000000-f7ffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


7.5. Output of the command "lspci -vvv" (as root):

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
       Subsystem: Asustek Computer, Inc. A7V333 Mainboard
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
       Latency: 0
       Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
       Capabilities: [a0] AGP version 2.0
               Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
               Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- 
Rate=x4
       Capabilities: [c0] Power Management version 2
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333 AGP] (prog-if 00 [Normal decode])
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
       Latency: 0
       Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
       I/O behind bridge: 0000e000-0000dfff
       Memory behind bridge: e6000000-e76fffff
       Prefetchable memory behind bridge: e7700000-efffffff
       BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
       Capabilities: [80] Power Management version 2
               Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 
10)
       Subsystem: Asustek Computer, Inc. CMI8738 6ch-MX
       Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
       Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 32 (500ns min, 6000ns max)
       Interrupt: pin A routed to IRQ 169
       Region 0: I/O ports at d800 [size=256]
       Capabilities: [c0] Power Management version 2
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
       Subsystem: Realtek Semiconductor Co., Ltd. RT8139
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 32 (8000ns min, 16000ns max)
       Interrupt: pin A routed to IRQ 177
       Region 0: I/O ports at d400 [size=256]
       Region 1: Memory at e5800000 (32-bit, non-prefetchable) [size=256]
       Capabilities: [50] Power Management version 2
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
       Subsystem: Asustek Computer, Inc.: Unknown device 808c
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
       Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 0
       Capabilities: [c0] Power Management version 2
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
       Subsystem: Asustek Computer, Inc. A7V8X motherboard
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 32
       Interrupt: pin A routed to IRQ 0
       Region 4: I/O ports at d000 [size=16]
       Capabilities: [c0] Power Management version 2
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 
[UHCI])
       Subsystem: Asustek Computer, Inc. A7V8X motherboard
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 32, cache line size 08
       Interrupt: pin D routed to IRQ 201
       Region 4: I/O ports at b800 [size=32]
       Capabilities: [80] Power Management version 2
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 
[UHCI])
       Subsystem: Asustek Computer, Inc. A7V8X motherboard
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 32, cache line size 08
       Interrupt: pin D routed to IRQ 201
       Region 4: I/O ports at b400 [size=32]
       Capabilities: [80] Power Management version 2
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX 
440] (rev a3) (prog-if 00 [VGA])
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 248 (1250ns min, 250ns max)
       Interrupt: pin A routed to IRQ 193
       Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=16M]
       Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
       Region 2: Memory at e7800000 (32-bit, prefetchable) [size=512K]
       Expansion ROM at e77e0000 [disabled] [size=128K]
       Capabilities: [60] Power Management version 2
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-
       Capabilities: [44] AGP version 2.0
               Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
               Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- 
Rate=x4


7.6. SCSI support disabled

7.7. I think it would be useful if you know I've got an A7V333 
motherboard by ASUS (with VIA KT333 as chipset)

8. I have got this problem with all the linux distributions I've owned, 
that's why I've thougt the problem was in the kernel but, as I have 
become a quite expert user only since last summer, I didn't know how to 
advise you about this problem. I became a linux user about three years 
ago, when I was 12 years old. I've tried to make the mouse work 
reconfiguring the kernels a lot of times and updading them with their 
newer stable releases, but it doesn't work yet. I'm not a programmer, so 
I don't have any ideas about where and how to edit the souce files of 
the kernel. I hope you will find and fix the problem. I'm sorry I can't 
speak English very well (I'm Italian). Thank you very much for 
everything you have done.
P.S.: I sent this message to "linux-usb-users@lists.sourceforge.net", 
but, as I haven't received any replies yet, I decided to send this to you.
