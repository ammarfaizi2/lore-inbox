Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWDZEGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWDZEGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 00:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWDZEGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 00:06:31 -0400
Received: from xproxy.gmail.com ([66.249.82.196]:43942 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932353AbWDZEGa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 00:06:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cHvKzZhmvCB/HtROrCrME9/NjWkI/ivlsPqY6PE5HGp+sFM6r28T8oKWSrv5Rzp3OBR6f0soEyoSh93CmnweBf/g1vwpGZ1DsP0Xg9NP+xDvIUXd/LWAk4Ko5NNF27aah9Eklhmc7sjG/y6nxXtYhMcg7bEPEFhRV/FZ9DyKvvk=
Message-ID: <5b9414920604252106x39c48d46ha7f834f7df16cb34@mail.gmail.com>
Date: Wed, 26 Apr 2006 01:06:29 -0300
From: "Gustavo Kellermann" <gakeller@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: system freeze while acessing a specific iso image or the damaged CD from it was taken
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
system freeze while acessing a specific iso image or the damaged CD
from it was taken

[2.] Full description of the problem/report:
I took a CD with the proceedings of a congress (in portuguese) for
copying. I done a copy with something like
# dd if=device of=file.iso
This command finished reporting a "IO error" but I mounted the ISO image with
# mkdir test
# mount -o loop -t iso9660 file.iso test
and tried to list one specific directory with ls, then the system hangs:
# cd test/II_Forum_IA_2001
# ls
Then the system was completely freezed. I was in a X terminal, and
couldn't change to a text terminal, and even the numlock/capslock keys
didn't work anymore.
I tried this in a Ubuntu 5.04 and a Fedora Core 4 systems, with the
same results (I will send information from the Fedora). The same
happened when I tried to access the CD directly.
Interesting enough, I was able to read this directory in a Windows
machine and extract the file I wanted, and I am not sure if that time
all files were present or not.

[3.] Keywords (i.e., modules, networking, kernel):
Not sure.

[4.] Kernel version (from /proc/version):
Linux version 2.6.11-1.1369_FC4 (bhcompile@decompose.build.redhat.com)
(gcc version 4.0.0 20050525 (Red Hat 4.0.0-9)) #1 Thu Jun 2 22:55:56
EDT 2005

[5.] Output of Oops.. message
No Oops message, but I found this in /var/log/messages:
Apr 25 22:54:34 localhost kernel: loop: loaded (max 8 devices)
Apr 25 22:54:36 localhost kernel: SELinux: initialized (dev loop0,
type iso9660), uses genfs_contexts

[6.] A small shell script or example program which triggers the
     problem (if possible)
- download the file example_freeze.iso (14MB)  from:
http://gakeller.no-ip.org:18080/~gakeller/example_freeze.iso
It's my cable at home. It will be a bit slow, but I don't have
anything better now :-(
Please let me know when you downloaded this file, because my server is
normally restricted tto a known range of IPs.
- execute:
mkdir test
mount -o loop -t iso9660 example_freeze.iso test
cd tst/II_Forum_IA_2001
ls

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux localhost.localdomain 2.6.11-1.1369_FC4 #1 Thu Jun 2 22:55:56
EDT 2005 i686 athlon i386 GNU/Linux

Gnu C                  4.0.2
Gnu make               3.80
binutils               2.15.94.0.2.2
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.37
jfsutils               1.1.7
reiserfsprogs          3.6.19
reiser4progs           line
xfsprogs               2.6.13
pcmcia-cs              3.2.8
quota-tools            3.12.
PPP                    2.4.2
isdn4k-utils           3.7
nfs-utils              1.0.7
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   058
Modules Loaded         nls_utf8 loop ipt_MASQUERADE iptable_nat
parport_pc lp parport autofs4 rfcomm l2cap bluetooth sunrpc ipt_REJECT
ipt_state ip_conntrack iptable_filter ip_tables vfat fat dm_mod video
button battery ac md5 ipv6 ohci_hcd i2c_ali15x3 i2c_core snd_ens1371
gameport snd_rawmidi snd_ac97_codec snd_seq_dummy snd_seq_oss
snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss
snd_pcm snd_timer snd soundcore snd_page_alloc 8139too mii ext3 jbd

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(TM)Processor
stepping        : 4
cpu MHz         : 1060.065
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 mtrr pge mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2105.34

[7.3.] Module information (from /proc/modules):
nls_utf8 2113 0 - Live 0xe0953000
loop 18121 0 - Live 0xe0972000
ipt_MASQUERADE 3265 1 - Live 0xe0970000
iptable_nat 21917 2 ipt_MASQUERADE, Live 0xe0a2c000
parport_pc 28933 1 - Live 0xe0aa7000
lp 13001 0 - Live 0xe0997000
parport 40585 2 parport_pc,lp, Live 0xe0a9c000
autofs4 29253 2 - Live 0xe0a93000
rfcomm 42333 0 - Live 0xe0a87000
l2cap 30661 5 rfcomm, Live 0xe0a4e000
bluetooth 56133 4 rfcomm,l2cap, Live 0xe0a3f000
sunrpc 167813 1 - Live 0xe0a5d000
ipt_REJECT 5569 1 - Live 0xe096d000
ipt_state 1857 3 - Live 0xe0955000
ip_conntrack 41497 3 ipt_MASQUERADE,iptable_nat,ipt_state, Live 0xe0a20000
iptable_filter 2881 1 - Live 0xe0802000
ip_tables 19521 5
ipt_MASQUERADE,iptable_nat,ipt_REJECT,ipt_state,iptable_filter, Live
0xe095a000
vfat 13377 1 - Live 0xe0965000
fat 54621 1 vfat, Live 0xe0988000
dm_mod 58101 0 - Live 0xe0978000
video 15941 0 - Live 0xe0960000
button 6609 0 - Live 0xe0957000
battery 9413 0 - Live 0xe0927000
ac 4805 0 - Live 0xe0934000
md5 4033 1 - Live 0xe0887000
ipv6 268097 10 - Live 0xe099c000
ohci_hcd 26849 0 - Live 0xe08c2000
i2c_ali15x3 7621 0 - Live 0xe0878000
i2c_core 21569 1 i2c_ali15x3, Live 0xe0920000
snd_ens1371 31649 2 - Live 0xe092b000
gameport 18633 1 snd_ens1371, Live 0xe08ca000
snd_rawmidi 30305 1 snd_ens1371, Live 0xe0905000
snd_ac97_codec 75961 1 snd_ens1371, Live 0xe0939000
snd_seq_dummy 3653 0 - Live 0xe087e000
snd_seq_oss 37057 0 - Live 0xe08fa000
snd_seq_midi_event 9153 1 snd_seq_oss, Live 0xe08a3000
snd_seq 62289 5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event, Live 0xe090f000
snd_seq_device 8781 4 snd_rawmidi,snd_seq_dummy,snd_seq_oss,snd_seq,
Live 0xe0896000
snd_pcm_oss 51185 0 - Live 0xe08d2000
snd_mixer_oss 17857 3 snd_pcm_oss, Live 0xe089d000
snd_pcm 100169 3 snd_ens1371,snd_ac97_codec,snd_pcm_oss, Live 0xe08e0000
snd_timer 33605 2 snd_seq,snd_pcm, Live 0xe08b8000
snd 57157 10 snd_ens1371,snd_rawmidi,snd_ac97_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,
Live 0xe08a9000
soundcore 10913 3 snd, Live 0xe0892000
snd_page_alloc 9669 1 snd_pcm, Live 0xe0883000
8139too 30017 0 - Live 0xe0889000
mii 5441 1 8139too, Live 0xe087b000
ext3 132553 2 - Live 0xe081d000
jbd 86233 1 ext3, Live 0xe0861000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
040b-040b : pnp 00:01
0480-048f : pnp 00:01
04d6-04d6 : pnp 00:01
0cf8-0cff : PCI conf1
b000-b0ff : 0000:00:0b.0
  b000-b0ff : 8139too
b400-b4ff : 0000:00:0a.0
  b400-b4ff : 8139too
b800-b83f : 0000:00:09.0
  b800-b83f : Ensoniq AudioPCI
d400-d40f : 0000:00:04.0
  d400-d407 : ide0
  d408-d40f : ide1
e400-e43f : 0000:00:11.0
  e400-e403 : PM1a_EVT_BLK
  e404-e405 : PM1a_CNT_BLK
  e408-e40b : PM_TMR
  e418-e427 : GPE0_BLK
e800-e81f : 0000:00:11.0
  e800-e81f : motherboard
    e800-e81f : pnp 00:01

# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ca3ff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffebfff : System RAM
  00100000-00375ab5 : Kernel code
  00375ab6-004223ff : Kernel data
1ffec000-1ffeefff : ACPI Tables
1ffef000-1fffefff : reserved
1ffff000-1fffffff : ACPI Non-volatile Storage
e9000000-e90000ff : 0000:00:0b.0
  e9000000-e90000ff : 8139too
e9800000-e98000ff : 0000:00:0a.0
  e9800000-e98000ff : 8139too
ea800000-ea800fff : 0000:00:06.0
  ea800000-ea800fff : ohci_hcd
eb800000-eb800fff : 0000:00:02.0
  eb800000-eb800fff : ohci_hcd
ec000000-edefffff : PCI Bus #01
  ec000000-ecffffff : 0000:01:00.0
edf00000-efffffff : PCI Bus #01
  ee000000-efffffff : 0000:01:00.0
f0000000-f7ffffff : 0000:00:00.0
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: ALi Corporation M1647 Northbridge [MAGiK 1 /
MobileMAGiK 1] (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [b0] AGP version 2.0
                Status: RQ=28 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit-
FW- Rate=<none>
        Capabilities: [a4] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: ec000000-edefffff
        Prefetchable memory behind bridge: edf00000-efffffff
        Secondary status: 66Mhz+ FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at eb800000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if fa)
        Subsystem: ASUSTeK Computer Inc. A7A266 Motherboard IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 255
        Region 4: I/O ports at d400 [size=16]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at ea800000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
        Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [a0] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq Sound Blaster 16PCI 4.1ch
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 6
        Region 0: I/O ports at b800 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at b400 [size=256]
        Region 1: Memory at e9800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at b000 [size=256]
        Region 1: Memory at e9000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-

01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA
TNT2 Model 64/Model 64 Pro] (rev 15) (prog-if 00 [VGA])
        Subsystem: Palit Microsystems Inc. Palit Microsystems Daytona TNT2 M64
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at ee000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at edff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit-
FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)
No scsi devices

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:
This is a comment.
I was somewhat disappointed with this bug, because I conceive that a
OS must be rock solid in respect to its the devices and the I/O. I was
trying to read a corruped CD? OK, I could got a error message instead
of the files I wanted, but never the system freezed.
Some years ago, I was a novice with Linux and done a confusion with
scsi numbers, so I formatted the root filesystem of a box running a
2.0.x kernel. The system progressively wrote more and more messages to
the console - in the end was impossible to start any new process
because binaries were washed out, but the system didn't freeze! What a
rock solid implementation! That impressed me! Ok, I was happy when
were installed safety mechanisms against formatting the root
filesystem in a running machine, but I am even happier if I have a OS
capable of surviving to any HW failure, including corrupted file
systems. I would be very glad if you fix this bug (unfortunately I
don't know how to do this) and perhaps solve something much more
serious than just reading a corrupted CD.

Thanks very much for you work on the Linux Kernel,
--
-
Gustavo Adolfo Kellermann
gakeller@gmail.com
