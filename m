Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSIEEzE>; Thu, 5 Sep 2002 00:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSIEEzD>; Thu, 5 Sep 2002 00:55:03 -0400
Received: from ww23.hostica.com ([216.116.124.23]:16843 "HELO hostica.com")
	by vger.kernel.org with SMTP id <S316853AbSIEEy6>;
	Thu, 5 Sep 2002 00:54:58 -0400
Message-ID: <3D76E4B0.96B525D6@georgetoft.com>
Date: Thu, 05 Sep 2002 00:59:28 -0400
From: George Toft <george@georgetoft.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.10-4GB i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel loses time - 1 min each 10 minutes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    

Kernel loses 1 minute per 10 minutes while buring CD's with xcdroast
(cdrecord).


[2.] Full description of the problem/report:

I burned several CD-Rs one night and noticed my two Linux boxes, which
sync periodically with the Navy's atomic clock, were over 30 minutes
apart.  My SuSE box, with the CD-R, had lost time while burning CD-R's. 
CD burning program is xcdroast, which uses cdrecord on the backend.


[3.] Keywords (i.e., modules, networking, kernel):

kernel, time


[4.] Kernel version (from /proc/version):

# cat /proc/version
Linux version 2.4.10-4GB (root@Pentium.suse.de) (gcc version 2.95.3
20010315 (SuSE)) #1 Fri Sep 28 17:20:21 GMT 2001


[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

N/A


[6.] A small shell script or example program which triggers the
     problem (if possible)

See description (2. above).


[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

donelle:/usr/src/linux-2.4.10.SuSE # sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux donelle 2.4.10-4GB #1 Fri Sep 28 17:20:21 GMT 2001 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.29
util-linux             2.11i
mount                  2.11i
modutils               2.4.8
e2fsprogs              1.24a
reiserfsprogs          3.x.0k-pre9
PPP                    2.4.1
Linux C Library        x    1 root     root      1384040 Jul 14 09:43
/lib/libc.so.6
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         st sg tuner tvaudio bttv i2c-algo-bit videodev
nls_iso8859-1 nls_cp437 via686a i2c-isa snd-pcm-oss snd-pcm-plugin
snd-mixer-oss ipt_MASQUERADE ipt_LOG ipt_limit ipt_REJECT ipt_state
iptable_nat ip_conntrack_ftp ip_conntrack iptable_filter ip_tables
i2c-proc i2c-core snd-seq-midi snd-seq-midi-event snd-seq
snd-card-ens1371 snd-ens1371 snd-pcm snd-timer snd-rawmidi
snd-seq-device snd-ac97-codec snd-mixer snd soundcore lp ipv6 vmnet
vmppuser parport_pc parport vmmon evdev input uhci usbcore 8139too
lvm-mod ext3 jbd ide-scsi


[7.2.] Processor information (from /proc/cpuinfo):

# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) Processor
stepping        : 0
cpu MHz         : 632.759
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1261.56


[7.3.] Module information (from /proc/modules):

# cat /proc/modules
st                     25056   0 (autoclean) (unused)
sg                     23328   0 (autoclean)
tuner                   4496   1 (autoclean)
tvaudio                 8128   0 (autoclean) (unused)
bttv                   56176   0 (autoclean)
i2c-algo-bit            7040   1 (autoclean) [bttv]
videodev                4544   2 (autoclean) [bttv]
nls_iso8859-1           2880   1 (autoclean)
nls_cp437               4384   1 (autoclean)
via686a                 8032   0 (unused)
i2c-isa                 1200   0 (unused)
snd-pcm-oss            18368   1 (autoclean)
snd-pcm-plugin         14480   0 (autoclean) [snd-pcm-oss]
snd-mixer-oss           4768   2 (autoclean) [snd-pcm-oss]
ipt_MASQUERADE          1200   1 (autoclean)
ipt_LOG                 3152  11 (autoclean)
ipt_limit                960  11 (autoclean)
ipt_REJECT              2784  35 (autoclean)
ipt_state                624   4 (autoclean)
iptable_nat            12656   0 (autoclean) [ipt_MASQUERADE]
ip_conntrack_ftp        3184   0 (unused)
ip_conntrack           12848   3 [ipt_MASQUERADE ipt_state iptable_nat
ip_conntrack_ftp]
iptable_filter          1728   0 (unused)
ip_tables              10496   9 [ipt_MASQUERADE ipt_LOG ipt_limit
ipt_REJECT ipt_state iptable_nat iptable_filter]
i2c-proc                5936   0 [via686a]
i2c-core               12288   0 [tuner tvaudio bttv i2c-algo-bit
via686a i2c-isa i2c-proc]
snd-seq-midi            3280   0 (unused)
snd-seq-midi-event      2800   0 [snd-seq-midi]
snd-seq                39584   0 [snd-seq-midi snd-seq-midi-event]
snd-card-ens1371        1984   3
snd-ens1371             9344   0 [snd-card-ens1371]
snd-pcm                29184   0 [snd-pcm-oss snd-pcm-plugin
snd-ens1371]
snd-timer               8336   0 [snd-seq snd-pcm]
snd-rawmidi             9312   0 [snd-seq-midi snd-ens1371]
snd-seq-device          3744   0 [snd-seq-midi snd-seq snd-rawmidi]
snd-ac97-codec         23456   0 [snd-ens1371]
snd-mixer              23488   0 [snd-mixer-oss snd-ens1371
snd-ac97-codec]
snd                    31344   1 [snd-pcm-oss snd-pcm-plugin
snd-mixer-oss snd-seq-midi snd-seq-midi-event snd-seq snd-card-ens1371
snd-ens1371 snd-pcm snd-timer snd-rawmidi snd-seq-device snd-ac97-codec
snd-mixer]
soundcore               3280   5 [snd]
lp                      5248   0 (autoclean)
ipv6                  124736  -1 (autoclean)
vmnet                  17152   6
vmppuser                6720   0 (unused)
parport_pc             19280   1
parport                22240   1 [lp vmppuser parport_pc]
vmmon                  17920   3
evdev                   4160   0 (unused)
input                   3072   0 [evdev]
uhci                   22400   0 (unused)
usbcore                47264   1 [uhci]
8139too                11936   1 (autoclean)
lvm-mod                45632   6 (autoclean)
ext3                   61312   5
jbd                    41504   5 [ext3]
ide-scsi                7552   0


[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

# cat /proc/ioports            
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
0378-037a : parport0
037b-037f : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-40ff : PCI device 1106:3057
5000-500f : PCI device 1106:3057
6000-607f : PCI device 1106:3057
  6000-607f : via686a-sensors
c000-c00f : PCI device 1106:0571
  c000-c007 : ide0
  c008-c00f : ide1
c400-c41f : PCI device 1106:3038
  c400-c41f : usb-uhci
c800-c81f : PCI device 1106:3038
  c800-c81f : usb-uhci
cc00-ccff : PCI device 10ec:8139
  cc00-ccff : 8139too
d000-d03f : PCI device 1274:5880
  d000-d03f : Ensoniq AudioPCI
d400-d407 : PCI device 1095:0649
d800-d803 : PCI device 1095:0649
dc00-dc07 : PCI device 1095:0649
e000-e003 : PCI device 1095:0649
e400-e40f : PCI device 1095:0649
  e400-e407 : ide2
  e408-e40f : ide3


# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-2ffeffff : System RAM
  00100000-002425c9 : Kernel code
  002425ca-002a1d0b : Kernel data
2fff0000-2fff2fff : ACPI Non-volatile Storage
2fff3000-2fffffff : ACPI Tables
d0000000-d3ffffff : PCI device 1106:0305
d4000000-dbffffff : PCI Bus #01
  d4000000-d7ffffff : PCI device 5333:8a13
    d4000000-d43fffff : vesafb
dd000000-dd000fff : PCI device 109e:036e
  dd000000-dd000fff : bttv
dd001000-dd001fff : PCI device 109e:0878
dd002000-dd0020ff : PCI device 10ec:8139
  dd002000-dd0020ff : 8139too
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d4000000-dbffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at c000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at c400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at cc00 [size=256]
        Region 1: Memory at dd002000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
11)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at dd000000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at dd001000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d000 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 01)
        Subsystem: CMD Technology Inc PCI0649
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d400 [size=8]
        Region 1: I/O ports at d800 [size=4]
        Region 2: I/O ports at dc00 [size=8]
        Region 3: I/O ports at e000 [size=4]
        Region 4: I/O ports at e400 [size=16]
        Expansion ROM at <unassigned> [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=3 PME-

01:00.0 VGA compatible controller: S3 Inc. 86c368 [Trio 3D/2X] (rev 02)
(prog-if 00 [VGA])
        Subsystem: S3 Inc. Trio3D/2X
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Region 0: Memory at d4000000 (32-bit, non-prefetchable)
[size=64M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [80] AGP version 1.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=x2


[7.6.] SCSI information (from /proc/scsi/scsi)

# cat /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: LITE-ON  Model: LTR-0841         Rev: MS84
  Type:   CD-ROM                           ANSI SCSI revision: 02


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

When not using CD-R, system is usually only a few seconds off each week.


[X.] Other notes, patches, fixes, workarounds:
Workaround:
# while [ 1 ]; do sleep 1800; /etc/cron.weekly/settime; done

# cat /etc/cron.weekly/settime
#!/bin/bash

ntpdate tock.usno.navy.mil
hwclock --systohc
