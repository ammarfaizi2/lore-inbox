Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031310AbWI1F3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031310AbWI1F3q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 01:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031357AbWI1F3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 01:29:46 -0400
Received: from smtp11.poczta.interia.pl ([80.48.65.11]:39960 "EHLO
	smtp4.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1031310AbWI1F3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 01:29:44 -0400
Message-ID: <451B7ACA.1000504@interia.pl>
Date: Thu, 28 Sep 2006 07:33:30 +0000
From: =?ISO-8859-2?Q?Arkadiusz_Ja=B3owiec?= <ajalowiec@interia.pl>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: PROBLEM: Kernel 2.6.x freeze
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-EMID: c193cacc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have problem with kernels 2.6.x and I don't know what I do. My 
computer always freeze with kernel 2.6.x (I test all kernel stable 
versions with different distributions ). Computer work 2-6 hours and 
crash. I can't do anything. My keyboard don't work. I've never had this 
problem with kernel 2.4.x. I use linux about 2 years. I am not 
programmer. Maybe I found bug ?

OOps:

ivalid opcode: 0000 [#1]
Modules linked in ppp_deflate zlib_deflate bsd_comp pppoatm ipv6 
partport_pc partport snd_pcm_oss snd_mixer oss via_agp agpgart 
ueagle_atm usbatm uhci_hcd ehci_hcd usbcore i2c_viapro 12c_core 
snd_via82xx snd_ac97_code snd_mpu401_uart snd_rawmidi opt_LOG 
snd_seq_device xt limit snd soundcore via_rhine mill xt_tcpudp xt_state 
iptables_filter nls_iso8859-2 nls_cp852 ip_contract_irc ip_contract_ftp 
xt_contract ip_contract ip_tables x_tables

CPU: 0
EIP: 0060: [<d0d184dc>] Not tainted VLI
EFLAGS: 00010003 (2.6.18#1)
EIP is at uhci_giveback_urb+0x59/0x126 [uhci_hcd]
eax: cefeeed1 ebx: cf3935a0 ecx: ce2a9bc0 edx: cf3935a0
esi: ce2a9bc0 edi: 00000000 epb: ce4933bc esp: c6b79f00
ds: 007b es: 007b ss:0068

Process removepkg (pid: 11084, ti=c6b78000 task=c126e560 task.ti=c6b78000)

Stack:    00000046 c9936060 cf3935a0 ce4933bc d0d17e17 00000000 cefeeed0 
cf3935a0
    ce2a9bc0 00000000 cefeeed0 d0d18627 c6b79fbc c6b79fbc cefeeed0 cf3935a0
    00000009 c6b79fbc d0d18846 00000246 00000000 00000000 cefeed00 d0d192ad

Call Trace:

[<d0d17e17>] uhci_result_common+0xb7/0x146 [uhci_hcd]
[<d0d18627>] uhci_scan_qh+0x7e/0x174 [uhci_hcd]
[<d0d18846>] uhci_scan_schedule+0x72/0xec [uhci_hcd]
[<d0d192ad>] uhci_irq+0xe8/0xf8 [uhci_hcd]
[<d0d365f8>] udb_hcd_irq+0x27/0x4e [usbcore]
[<c012c4c4>] handle_IRQ_event+0x21/0x47
[<c012c545>] do_IRQ+0x5b/0xa2
[<c0104106>] do_IRQ+0x40/0x4d
[<c0102c4a>] common_interrupt+0x1a/0x20

Code:     5c 89 57 2c 8b 40 44 c7 47 40 00 00 00 00 89
                47 3c 8b 45 00 8b 55 04 89 02 89 50 04 89
                6d 00 8d 47 18 89 6d 04 39 47 18 75
                4b 0f <b6> 47 50 a8 02 88 44 24 08 74 3f 0f b6
                46 20 8b 4e 20 ba fe ff

EIP:    [<d0d184dc>] uhci_giveback_urb+0x59/0x126
    [uhci_hcd] SS: ESP 0068: c6b79f00
<0> Kernel panic - not syncing: Fatal exception in interrupt

KSYMOOPS:

ksymoops 2.4.11 on i686 2.6.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.18/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
CPU: 0
EIP: 0060: [<d0d184dc>] Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010003 (2.6.18#1)
eax: cefeeed1 ebx: cf3935a0 ecx: ce2a9bc0 edx: cf3935a0
esi: ce2a9bc0 edi: 00000000 epb: ce4933bc esp: c6b79f00
Warning (Oops_set_regs): garbage 'epb: ce4933bc esp: c6b79f00' at end of 
register line ignored
ds: 007b es: 007b ss:0068
Stack:  00000046 c9936060 cf3935a0 ce4933bc d0d17e17 00000000 cefeeed0 
cf3935a0
        ce2a9bc0 00000000 cefeeed0 d0d18627 c6b79fbc c6b79fbc cefeeed0 
cf3935a0
        00000009 c6b79fbc d0d18846 00000246 00000000 00000000 cefeed00 
d0d192ad
Call Trace:
[<d0d17e17>] uhci_result_common+0xb7/0x146 [uhci_hcd]
[<d0d18627>] uhci_scan_qh+0x7e/0x174 [uhci_hcd]
[<d0d18846>] uhci_scan_schedule+0x72/0xec [uhci_hcd]
[<d0d192ad>] uhci_irq+0xe8/0xf8 [uhci_hcd]
[<d0d365f8>] udb_hcd_irq+0x27/0x4e [usbcore]
[<c012c4c4>] handle_IRQ_event+0x21/0x47
[<c012c545>] do_IRQ+0x5b/0xa2
[<c0104106>] do_IRQ+0x40/0x4d
[<c0102c4a>] common_interrupt+0x1a/0x20
Code:   5c 89 57 2c 8b 40 44 c7 47 40 00 00 00 00 89 47 3c 8b


 >>EIP; d0d184dc <pg0+109164dc/3fbfc400>   <=====

 >>eax; cefeeed1 <pg0+ebeced1/3fbfc400>
 >>ebx; cf3935a0 <pg0+ef915a0/3fbfc400>
 >>ecx; ce2a9bc0 <pg0+dea7bc0/3fbfc400>
 >>edx; cf3935a0 <pg0+ef915a0/3fbfc400>
 >>esi; ce2a9bc0 <pg0+dea7bc0/3fbfc400>

Trace; d0d17e17 <pg0+10915e17/3fbfc400>
Trace; d0d18627 <pg0+10916627/3fbfc400>
Trace; d0d18846 <pg0+10916846/3fbfc400>
Trace; d0d192ad <pg0+109172ad/3fbfc400>
Trace; d0d365f8 <pg0+109345f8/3fbfc400>
Trace; c012c4c4 <handle_IRQ_event+21/47>
Trace; c012c545 <__do_IRQ+5b/a2>
Trace; c0104106 <do_IRQ+40/4d>
Trace; c0102c4a <common_interrupt+1a/20>

Code;  d0d184dc <pg0+109164dc/3fbfc400>
00000000 <_EIP>:
Code;  d0d184dc <pg0+109164dc/3fbfc400>   <=====
   0:   5c                        pop    %esp   <=====
Code;  d0d184dd <pg0+109164dd/3fbfc400>
   1:   89 57 2c                  mov    %edx,0x2c(%edi)
Code;  d0d184e0 <pg0+109164e0/3fbfc400>
   4:   8b 40 44                  mov    0x44(%eax),%eax
Code;  d0d184e3 <pg0+109164e3/3fbfc400>
   7:   c7 47 40 00 00 00 00      movl   $0x0,0x40(%edi)
Code;  d0d184ea <pg0+109164ea/3fbfc400>
   e:   89 47 3c                  mov    %eax,0x3c(%edi)
Code;  d0d184ed <pg0+109164ed/3fbfc400>
  11:   8b 00                     mov    (%eax),%eax

EIP:    [<d0d184dc>] uhci_giveback_urb+0x59/0x126
<0> Kernel panic - not syncing: Fatal exception in interrupt
Warning (Oops_read): Code line not seen, dumping what data is available


 >>EIP; d0d184dc <pg0+109164dc/3fbfc400>   <=====


3 warnings and 1 error issued.  Results may not be reliable.


CPUINFO:

processor    : 0
vendor_id    : GenuineIntel
cpu family    : 15
model        : 2
model name    : Intel(R) Celeron(R) CPU 2.20GHz
stepping    : 7
cpu MHz        : 2200.144
cache size    : 128 KB
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 2
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
bogomips    : 4403.03

IOMEM:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cebff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-002e0e24 : Kernel code
  002e0e25-003aa737 : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-dfffffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
    d0000000-d3ffffff : vesafb
  d8000000-d807ffff : 0000:01:00.0
  d8080000-d809ffff : 0000:01:00.0
e0000000-e3ffffff : 0000:00:00.0
e4000000-e5ffffff : PCI Bus #01
  e4000000-e4ffffff : 0000:01:00.0
e6000000-e600ffff : 0000:00:09.0
e6010000-e60100ff : 0000:00:10.3
  e6010000-e60100ff : ehci_hcd
e6011000-e60110ff : 0000:00:12.0
  e6011000-e60110ff : via-rhine
ffff0000-ffffffff : reserved

IOPORTS:

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
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f2-03f5 : floppy
03f6-03f6 : ide0
03f7-03f7 : floppy DIR
0400-047f : 0000:00:11.0
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-0423 : ACPI GPE0_BLK
0500-050f : 0000:00:11.0
  0500-0507 : vt596_smbus
0cf8-0cff : PCI conf1
d000-d007 : 0000:00:09.0
d400-d41f : 0000:00:10.0
  d400-d41f : uhci_hcd
d800-d81f : 0000:00:10.1
  d800-d81f : uhci_hcd
dc00-dc1f : 0000:00:10.2
  dc00-dc1f : uhci_hcd
e000-e00f : 0000:00:11.1
  e000-e007 : ide0
  e008-e00f : ide1
e400-e4ff : 0000:00:11.5
  e400-e4ff : VIA8233
ec00-ecff : 0000:00:12.0
  ec00-ecff : via-rhine

LSPCI:

00:00.0 Host bridge: VIA Technologies, Inc. P4M266 Host Bridge
    Subsystem: VIA Technologies, Inc. P4M266 Host Bridge
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
    Latency: 8
    Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
    Capabilities: [a0] AGP version 2.0
        Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2,x4
        Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] 
(prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
    Latency: 0
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: e4000000-e5ffffff
    Prefetchable memory behind bridge: d0000000-dfffffff
    BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
    Subsystem: Conexant Dynalink 56PMi
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32
    Interrupt: pin A routed to IRQ 3
    Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=64K]
    Region 1: I/O ports at d000 [size=8]
    Capabilities: [40] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80) (prog-if 00 [UHCI])
    Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32, cache line size 08
    Interrupt: pin A routed to IRQ 11
    Region 4: I/O ports at d400 [size=32]
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80) (prog-if 00 [UHCI])
    Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32, cache line size 08
    Interrupt: pin B routed to IRQ 3
    Region 4: I/O ports at d800 [size=32]
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80) (prog-if 00 [UHCI])
    Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32, cache line size 08
    Interrupt: pin C routed to IRQ 5
    Region 4: I/O ports at dc00 [size=32]
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 
20 [EHCI])
    Subsystem: VIA Technologies, Inc. USB 2.0
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32, cache line size 20
    Interrupt: pin D routed to IRQ 11
    Region 0: Memory at e6010000 (32-bit, non-prefetchable) [size=256]
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
    Subsystem: VIA Technologies, Inc. VT8235 ISA Bridge
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
    Subsystem: VIA Technologies, Inc. 
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32
    Interrupt: pin A routed to IRQ 11
    Region 4: I/O ports at e000 [size=16]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
    Subsystem: VIA Technologies, Inc. K7VT2 motherboard
    Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Interrupt: pin C routed to IRQ 5
    Region 0: I/O ports at e400 [size=256]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] 
(rev 74)
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (750ns min, 2000ns max), cache line size 08
    Interrupt: pin A routed to IRQ 11
    Region 0: I/O ports at ec00 [size=256]
    Region 1: Memory at e6011000 (32-bit, non-prefetchable) [size=256]
    Capabilities: [40] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX 
440] (rev a3) (prog-if 00 [VGA])
    Subsystem: Micro-Star International Co., Ltd.: Unknown device 8601
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (1250ns min, 250ns max)
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
    Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
    Region 2: Memory at d8000000 (32-bit, prefetchable) [size=512K]
    Expansion ROM at d8080000 [disabled] [size=128K]
    Capabilities: [60] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [44] AGP version 2.0
        Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 
64bit- FW+ AGP3- Rate=x1,x2,x4
        Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>


MOSULES:

parport_pc 24260 0 - Live 0xd0d68000
parport 23616 1 parport_pc, Live 0xd0d71000
snd_pcm_oss 40736 0 - Live 0xd0d53000
snd_mixer_oss 15872 1 snd_pcm_oss, Live 0xd0c91000
via_agp 9984 1 - Live 0xd0c63000
agpgart 32816 1 via_agp, Live 0xd0d5e000
ueagle_atm 25128 0 - Live 0xd0d12000
usbatm 17792 1 ueagle_atm, Live 0xd0d2a000
uhci_hcd 21516 0 - Live 0xd0d23000
ehci_hcd 26760 0 - Live 0xd0d1b000
usbcore 115844 5 ueagle_atm,usbatm,uhci_hcd,ehci_hcd, Live 0xd0d35000
i2c_viapro 8724 0 - Live 0xd0c52000
i2c_core 20368 1 i2c_viapro, Live 0xd0c8b000
snd_via82xx 25236 0 - Live 0xd0c5b000
snd_ac97_codec 84256 1 snd_via82xx, Live 0xd0c96000
snd_ac97_bus 2560 1 snd_ac97_codec, Live 0xd0c30000
snd_pcm 69896 3 snd_pcm_oss,snd_via82xx,snd_ac97_codec, Live 0xd0c67000
snd_timer 21636 1 snd_pcm, Live 0xd0c4b000
snd_page_alloc 10120 2 snd_via82xx,snd_pcm, Live 0xd0c18000
snd_mpu401_uart 7808 1 snd_via82xx, Live 0xd0c2b000
snd_rawmidi 22816 1 snd_mpu401_uart, Live 0xd0c44000
snd_seq_device 8204 1 snd_rawmidi, Live 0xd0c27000
snd 47844 9 
snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, 
Live 0xd0c37000
soundcore 9440 1 snd, Live 0xd0c1c000
via_rhine 22536 0 - Live 0xd0c20000
ipt_LOG 6400 2 - Live 0xd0c12000
mii 5632 1 via_rhine, Live 0xd0c15000
xt_limit 2944 2 - Live 0xd087e000
xt_tcpudp 3584 5 - Live 0xd0863000
xt_state 2432 3 - Live 0xd0865000
iptable_filter 3328 1 - Live 0xd0870000
nls_iso8859_2 4992 1 - Live 0xd086d000
nls_cp852 5248 1 - Live 0xd086a000
ip_conntrack_irc 7152 0 - Live 0xd0867000
ip_conntrack_ftp 7664 0 - Live 0xd0853000
xt_conntrack 2816 0 - Live 0xd0856000
ip_conntrack 44980 4 
xt_state,ip_conntrack_irc,ip_conntrack_ftp,xt_conntrack, Live 0xd0872000
ip_tables 12760 1 iptable_filter, Live 0xd085e000
x_tables 13572 6 
ipt_LOG,xt_limit,xt_tcpudp,xt_state,xt_conntrack,ip_tables, Live 0xd0859000

SCSI:

Attached devices:

VERSION:

Linux version 2.6.18 (root@darkstar) (gcc version 3.3.6) #1 Wed Sep 27 
08:23:45 UTC 2006







----------------------------------------------------------------------
Jestes kierowca? To poczytaj! >>> http://link.interia.pl/f199e

