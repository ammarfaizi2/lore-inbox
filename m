Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310234AbSCFW5n>; Wed, 6 Mar 2002 17:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310228AbSCFW5f>; Wed, 6 Mar 2002 17:57:35 -0500
Received: from [200.68.186.6] ([200.68.186.6]:5248 "EHLO Voyager.noldata.com")
	by vger.kernel.org with ESMTP id <S310234AbSCFW5a>;
	Wed, 6 Mar 2002 17:57:30 -0500
Message-ID: <3C869F87.6060106@noldata.com>
Date: Wed, 06 Mar 2002 18:00:23 -0500
From: Gustavo Lozano <glozano@noldata.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: System semihanging when accessing filesystems.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.3.1(snapshot 20020108) (Voyager)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@Voyager:/usr/src/linux/scripts# sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux Voyager 2.4.18 #2 Tue Mar 5 07:33:03 COT 2002 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11f
mount                  2.11b
modutils               2.4.6
e2fsprogs              1.22
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    command
Sh-utils               2.0

Hello.

I have installed latest kernel last week, and since then have the next 
problem:

Everytime I do a job involving filesystem access in large amounts (tasks 
like cp -R, find, ....) the system becomes to slow, it stops responding 
to the keyboard or mouse, and multimedia apps starts becoming to slow 
playing music and then it is just a noise what I hear.
Just when the task end, the system comes to a normal state again.

By example:
I have :
root@Voyager:/usr/src/linux/scripts# cd /mnt/home/glozano
root@Voyager:/mnt/home/glozano# du -s
101892    .
root@Voyager:/mnt/home/glozano# cp -R * /home/glozano
then the system comes to slow.... when copy ends everything is normal again.
I booted my system with the 2.4.17 and it does not happen.


root@Voyager:/mnt/home/glozano# cat /proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 15
model        : 1
model name    : Intel(R) Pentium(R) 4 CPU 1.60GHz
stepping    : 2
cpu MHz        : 1594.887
cache size    : 256 KB
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 2
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips    : 3185.04

No modules support in the kernel.

root@Voyager:/mnt/home/glozano# cat /proc/ioports
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c800-c8ff : ATI Technologies Inc Rage 128 PF
d000-dfff : PCI Bus #02
  df00-df3f : Intel Corp. 82820 (ICH2) Chipset Ethernet Controller
    df00-df3f : eepro100
  df80-df9f : Creative Labs SB Live! EMU10k1
    df80-df9f : EMU10K1
  dff0-dff7 : Creative Labs SB Live!
    dff0-dff7 : emu10k1-gp
ef40-ef5f : Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub A)
  ef40-ef5f : usb-uhci
ef80-ef9f : Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub B)
  ef80-ef9f : usb-uhci
efa0-efaf : Intel Corp. 82820 820 (Camino 2) Chipset SMBus
ffa0-ffaf : Intel Corp. 82820 820 (Camino 2) Chipset IDE U100
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1
root@Voyager:/mnt/home/glozano# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000c9000-000c9fff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffbffff : System RAM
  00100000-0025d2ea : Kernel code
  0025d2eb-002b9bff : Kernel data
0ffc0000-0fff7fff : ACPI Tables
0fff8000-0fffffff : ACPI Non-volatile Storage
ee900000-f69fffff : PCI Bus #01
  f0000000-f3ffffff : ATI Technologies Inc Rage 128 PF
f6a00000-f6afffff : PCI Bus #02
f8000000-fbffffff : Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ff800000-ff8fffff : PCI Bus #01
  ff8fc000-ff8fffff : ATI Technologies Inc Rage 128 PF
ff900000-ff9fffff : PCI Bus #02
  ff9ff000-ff9fffff : Intel Corp. 82820 (ICH2) Chipset Ethernet Controller
    ff9ff000-ff9fffff : eepro100
ffb80000-ffbfffff : reserved
fff00000-ffffffff : reserved

root@Voyager:/mnt/home/glozano# lspci -vvv > /tmp/lspci
root@Voyager:/mnt/home/glozano# cat /tmp/lspci | more
00:00.0 Host bridge: Intel Corporation: Unknown device 1a30 (rev 03)
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
    Latency: 0
    Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
    Capabilities: [e4] #09 [0104]
    Capabilities: [a0] AGP version 2.0
        Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
        Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation: Unknown device 1a31 (rev 03) 
(prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
    I/O behind bridge: 0000c000-0000cfff
    Memory behind bridge: ff800000-ff8fffff
    Prefetchable memory behind bridge: ee900000-f69fffff
    BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corporation: Unknown device 244e (rev 12) 
(prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
    I/O behind bridge: 0000d000-0000dfff
    Memory behind bridge: ff900000-ff9fffff
    Prefetchable memory behind bridge: f6a00000-f6afffff
    BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation: Unknown device 2440 (rev 12)
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0

00:1f.1 IDE interface: Intel Corporation: Unknown device 244b (rev 12) 
(prog-if 80 [Master])
    Subsystem: Intel Corporation: Unknown device 4856
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corporation: Unknown device 2442 (rev 12) 
(prog-if 00 [UHCI])
    Subsystem: Intel Corporation: Unknown device 4856
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Interrupt: pin D routed to IRQ 11
    Region 4: I/O ports at ef40 [size=32]

00:1f.3 SMBus: Intel Corporation: Unknown device 2443 (rev 12)
    Subsystem: Intel Corporation: Unknown device 4856
    Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Interrupt: pin B routed to IRQ 10
    Region 4: I/O ports at efa0 [size=16]

00:1f.4 USB Controller: Intel Corporation: Unknown device 2444 (rev 12) 
(prog-if 00 [UHCI])
    Subsystem: Intel Corporation: Unknown device 4856
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Interrupt: pin C routed to IRQ 9
    Region 4: I/O ports at ef80 [size=32]

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF 
(prog-if 00 [VGA])
    Subsystem: Unknown device 174b:7106
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (2000ns min), cache line size 04
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
    Region 1: I/O ports at c800 [size=256]
    Region 2: Memory at ff8fc000 (32-bit, non-prefetchable) [size=16K]
    Expansion ROM at ff8c0000 [disabled] [size=128K]
    Capabilities: [50] AGP version 2.0
        Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
        Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
    Capabilities: [5c] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

NO SCSI devices


Regards...




-- 



_________________
Gustavo A. Lozano
Noldata Corp.
We know how!
CTO

I know not with what weapons World War III will be fought,
but World War IV will be fought with sticks and stones. 
                                        Albert Einstein



