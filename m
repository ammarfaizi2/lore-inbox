Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751748AbWEPKRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbWEPKRS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 06:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWEPKRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 06:17:18 -0400
Received: from [195.159.148.250] ([195.159.148.250]:26349 "EHLO zulu.barmen.nu")
	by vger.kernel.org with ESMTP id S1751746AbWEPKRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 06:17:17 -0400
From: "Stian B. Barmen" <stian@barmen.nu>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: ide hdma dma_timer_expiry
Date: Tue, 16 May 2006 12:17:15 +0200
MIME-Version: 1.0
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-Type: multipart/signed;
	boundary="----=_NextPart_000_007A_01C678E2.AAC33660";
	protocol="application/x-pkcs7-signature";
	micalg=SHA1
thread-index: AcZ4y4Oxuho4AebaR1q4wt6YOlHKtw==
Content-Class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Message-ID: <ZULUhx27kBnccYTjr8c00000042@zulu.barmen.nu>
X-OriginalArrivalTime: 16 May 2006 09:33:28.0781 (UTC) FILETIME=[C9E8CFD0:01C678CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_007A_01C678E2.AAC33660
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

[1.] One line summary of the problem:

Kernel Panic every 24-48 hours after upgrade from 2.6.15.4 -> 2.6.16.15

[2.] Full description of the problem/report:

After the upgrade the screen freezes, usually in the night with a kernel 
panic,
but when I get there the screen is black so I never get to see the panic 
itself. Anyways I
looked in the syslog and the last entry was:

May 16 04:22:39 [kernel] [234964.520730] hdi: dma_timer_expiry: dma status == 
0x61

When I downgrade to 2.6.16.4 the problems goes away. Have tried to read the 
changelogs but
I am stumped as to what the problem is.

Hardware IDE wise is alot of disks, 9 IDE disks on 3 controllers, and the hdi 
disk is on a Primise Tech 20269 controller. Smartctl does not report any 
problems.

[3.] Keywords (i.e., modules, networking, kernel):

Kernel panic, dma_timer_expiry ide

[4.] Kernel version (from /proc/version):

kermit proc # cat /proc/version
Linux version 2.6.16.15 (root@kermit) (gcc version 3.3.6 (Gentoo 3.3.6, 
ssp-3.3.6-1.0, pie-8.7.8)) #2 SMP Thu May 11 10:01:19 CEST 2006

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)*
[6.] A small shell script or example program which triggers the
     problem (if possible) *
[7.] Envoironment *
[7.1.] Software (add the output of the ver_linux script here)

kermit scripts # ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux kermit 2.6.16.15 #2 SMP Thu May 11 10:01:19 CEST 2006 i686 Pentium III 
(Coppermine) GNU/Linux

Gnu C                  3.3.6
Gnu make               3.80
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.1
e2fsprogs              1.38
reiserfsprogs          line
reiser4progs           line
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.94
udev                   087
Modules Loaded         aic7xxx scsi_transport_spi parport_pc parport tun nfsd 
exportfs nfs lockd nfs_acl sunrpc aes

[7.2.] Processor information (from /proc/cpuinfo):
kermit scripts # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 825.790
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 1654.45

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 825.790
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 1651.45

[7.3.] Module information (from /proc/modules):
kermit scripts # cat /proc/modules
aic7xxx 154932 0 - Live 0xf092a000
scsi_transport_spi 17216 1 aic7xxx, Live 0xf08e2000
parport_pc 27876 0 - Live 0xf0922000
parport 30056 1 parport_pc, Live 0xf0919000
tun 8384 1 - Live 0xf08d7000
nfsd 199460 13 - Live 0xf0982000
exportfs 4384 1 nfsd, Live 0xf08c7000
nfs 189576 0 - Live 0xf0952000
lockd 53320 3 nfsd,nfs, Live 0xf08e9000
nfs_acl 2976 2 nfsd,nfs, Live 0xf0813000
sunrpc 124092 10 nfsd,nfs,lockd,nfs_acl, Live 0xf08f9000
aes 31264 0 - Live 0xf08ce000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

kermit scripts # cat /proc/ioports
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
01f0-01f7 : ide0
02f8-02ff : serial
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
5000-500f : 0000:00:07.4
6000-607f : 0000:00:07.4
9000-900f : 0000:00:07.1
  9000-9007 : ide0
  9008-900f : ide1
9c00-9c07 : 0000:00:09.0
  9c00-9c07 : ide2
a000-a003 : 0000:00:09.0
  a002-a002 : ide2
a400-a407 : 0000:00:09.0
  a400-a407 : ide3
a800-a803 : 0000:00:09.0
  a802-a802 : ide3
ac00-ac0f : 0000:00:09.0
  ac00-ac07 : ide2
  ac08-ac0f : ide3
b000-b007 : 0000:00:0a.0
  b000-b007 : ide4
b400-b403 : 0000:00:0a.0
  b402-b402 : ide4
b800-b807 : 0000:00:0a.0
  b800-b807 : ide5
bc00-bc03 : 0000:00:0a.0
  bc02-bc02 : ide5
c000-c00f : 0000:00:0a.0
  c000-c007 : ide4
  c008-c00f : ide5
c400-c4ff : 0000:00:0b.0
c800-c83f : 0000:00:0c.0
  c800-c83f : e100

kermit scripts # cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000ca7ff : Adapter ROM
000cb000-000cb1ff : Adapter ROM
000cc000-000ccfff : Adapter ROM
000f0000-000fffff : System ROM
00100000-2ffeffff : System RAM
  00100000-002af2b0 : Kernel code
  002af2b1-0036d653 : Kernel data
2fff0000-2fff2fff : ACPI Non-volatile Storage
2fff3000-2fffffff : ACPI Tables
40000000-400fffff : 0000:00:0c.0
40100000-4011ffff : 0000:00:0b.0
40120000-40123fff : 0000:00:09.0
40124000-40127fff : 0000:00:0a.0
d0000000-d3ffffff : 0000:00:00.0
d4000000-d6ffffff : PCI Bus #01
  d4000000-d4003fff : 0000:01:00.0
  d4010000-d401ffff : 0000:01:00.0
  d5000000-d57fffff : 0000:01:00.0
d7000000-d7ffffff : PCI Bus #01
  d7000000-d7ffffff : 0000:01:00.0
d9000000-d90fffff : 0000:00:0c.0
  d9000000-d90fffff : e100
d9100000-d9103fff : 0000:00:0a.0
d9104000-d9107fff : 0000:00:09.0
d9108000-d9108fff : 0000:00:0c.0
  d9108000-d9108fff : e100
d9109000-d9109fff : 0000:00:0b.0
  d9109000-d9109fff : aic7xxx
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

kermit scripts # lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] 
(rev c4)
        Subsystem: ABIT Computer Corp. Unknown device a204
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x 
AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d4000000-d6ffffff
        Prefetchable memory behind bridge: d7000000-d7ffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
        Subsystem: ABIT Computer Corp. Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a 
[Master SecP PriP])
        Subsystem: VIA Technologies, Inc. 
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at 9000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Mass storage controller: Promise Technology, Inc. 20269 (rev 02) 
(prog-if 85)
        Subsystem: Promise Technology, Inc. Ultra133TX2
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 4500ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 9c00 [size=8]
        Region 1: I/O ports at a000 [size=4]
        Region 2: I/O ports at a400 [size=8]
        Region 3: I/O ports at a800 [size=4]
        Region 4: I/O ports at ac00 [size=16]
        Region 5: Memory at d9104000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at 40120000 [size=16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Mass storage controller: Promise Technology, Inc. 20269 (rev 02) 
(prog-if 85)
        Subsystem: Promise Technology, Inc. Ultra133TX2
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 4500ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at b000 [size=8]
        Region 1: I/O ports at b400 [size=4]
        Region 2: I/O ports at b800 [size=8]
        Region 3: I/O ports at bc00 [size=4]
        Region 4: I/O ports at c000 [size=16]
        Region 5: Memory at d9100000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at 40124000 [size=16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 SCSI storage controller: Adaptec AIC-7892B U160/m (rev 02)
        Subsystem: Adaptec 19160 Ultra160 SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 11
        BIST result: 00
        Region 0: I/O ports at c400 [disabled] [size=256]
        Region 1: Memory at d9109000 (64-bit, non-prefetchable) [size=4K]
        [virtual] Expansion ROM at 40100000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] 
(rev 08)
        Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at d9108000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at c800 [size=64]
        Region 2: Memory at d9000000 (32-bit, non-prefetchable) [size=1M]
        [virtual] Expansion ROM at 40000000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G100 [Productiva] 
AGP (rev 02) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. MGA-G100 AGP
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d7000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at d4000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at d5000000 (32-bit, non-prefetchable) [size=8M]
        [virtual] Expansion ROM at d4010000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 1.0
                Status: RQ=2 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)

kermit scripts # cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: PIONEER  Model: DVD-ROM DVD-303  Rev: 1.06
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):


kermit scripts # cat /proc/ide/drivers
ide-disk version 1.18
ide-cdrom version 4.61
ide-scsi version 0.92


kermit scripts # cat /proc/ide/hdi/settings
name                    value           min             max             mode
----                    -----           ---             ---             ----
acoustic                0               0               254             rw
address                 1               0               2               rw
bios_cyl                30401           0               65535           rw
bios_head               255             0               255             rw
bios_sect               63              0               63              rw
bswap                   0               0               1               r
current_speed           69              0               70              rw
failures                0               0               65535           rw
init_speed              69              0               70              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
multcount               16              0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw
wcache                  1               0               1               rw

kermit proc # hdparm /dev/hdi

/dev/hdi:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 30401/255/63, sectors = 250059350016, start = 0

[X.] Other notes, patches, fixes, workarounds: none

------=_NextPart_000_007A_01C678E2.AAC33660
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIOSDCCBHAw
ggNYoAMCAQICEB+0zZj6uUmxQ2K5VZ1P12EwDQYJKoZIhvcNAQEFBQAwga4xCzAJBgNVBAYTAlVT
MQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VS
VFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYwNAYDVQQD
Ey1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgRW1haWwwHhcNMDUwNjA3
MDgwOTEwWhcNMTkwNzA5MTczNjU4WjBlMQswCQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3Qg
QUIxHTAbBgNVBAsTFEFkZFRydXN0IFRUUCBOZXR3b3JrMSEwHwYDVQQDExhBZGRUcnVzdCBDbGFz
cyAxIENBIFJvb3QwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCWltQhSWDia+hBBwze
xODcEyPNwTXH+9ZOEQpnXvUGW2ulCDtbKRY654eyNAbFvAWlA3yCyykQruGIgb3WntP+LVbBFc7j
Jp0VLhD7Bo8wBN6ntGO0/7Gcrjyvd7ZWxbWroulpOj0OM3kyP3CCkplhbY0wCI9xP6ZIVxn4JdxL
ZlyldI+Yrsj5wAYi56xz36Uu+1LcsRVlIPo1Zmne3yzxbrww2ywkEtvrNTVokMsAsJchPXQhI2U0
K7t4WaPW4XY5mqRJjox0r26kmqPZm9I4XJuiGMx1I4S+6+JNM3GOGvDC+Mcdoq0Dlyz4zyXG9rgk
MbFjXZJ/Y/AlyVMuH79NAgMBAAGjgdEwgc4wHwYDVR0jBBgwFoAUiYJnfcSdJnAAS7RQSHzePa4E
bn0wHQYDVR0OBBYEFJWxtPCUtr3H2tERCSG+wa9J/RB7MA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMB
Af8EBTADAQH/MBEGCWCGSAGG+EIBAQQEAwIAATBYBgNVHR8EUTBPME2gS6BJhkdodHRwOi8vY3Js
LnVzZXJ0cnVzdC5jb20vVVROLVVTRVJGaXJzdC1DbGllbnRBdXRoZW50aWNhdGlvbmFuZEVtYWls
LmNybDANBgkqhkiG9w0BAQUFAAOCAQEAaenDt4Gwt0ps0AgcIC5PrbDFLtmGHU116Z2Ok+MEWh9p
Lgv/mvP50iMHmRqHMGGiIngTqsioHxNL64GxQF6EfG7tEpPCUr6dj4iW4XZvYFF0nT7/3AoLtP27
1e7/k+Dh7/LJxMN9flJEjrQZF5vTiDM1G5g5EMXVLk31lpzXfbxMV6X2iD9BrSNLmk7bZ69/EsDz
W7Y44lu6XPYCWRWdZAuSfoopDa0AdQxf1MzGzSfdlSTlOEV9Y81qezrb2rXVR4y3DQPhCxjzImQo
KXoyoBzj+hY78e3nhaNU4eI8IfyjqXjrzFTM9B8aFinNgbqmbMWOnmDn/WFJQN50NCXR9TCCBKIw
ggOKoAMCAQICEES+DItQACS0EdM2JSVnyYkwDQYJKoZIhvcNAQEFBQAwga4xCzAJBgNVBAYTAlVT
MQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VS
VFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYwNAYDVQQD
Ey1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgRW1haWwwHhcNOTkwNzA5
MTcyODUwWhcNMTkwNzA5MTczNjU4WjCBrjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlVUMRcwFQYD
VQQHEw5TYWx0IExha2UgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMSEwHwYD
VQQLExhodHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20xNjA0BgNVBAMTLVVUTi1VU0VSRmlyc3QtQ2xp
ZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBFbWFpbDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALI5haTyfatBO2JGN67NwWB1vDll+UoaR6K5zEjMapjVTTUZuaRC5c5J4oovHnzSMQfHTrSD
ZJ0uKdWiZMSFvYVRNXmkTmiQexx6pJKoF/KYFfKTzMmkMpW7DE8wvZigC4vlbhuiRvp4vKJvq1le
pS/Pytptqi/rrKGzaqq3Lmc1i3nhHmmI4uZGzaCl6r4LznY6eg6b6vzaJ1s9cx8i5khhxkzzabGo
Lhu21DEgLLyCio6kDqXXiUP8FlqvHXHXEVnauocNr/rz4cLwpMVnjNbWVDreCqS6A3ezZcj9HtN0
YqoYymiTHqGFfvVHZcv4TVcodNI0/zC27vZiMBSMLOsCAwEAAaOBuTCBtjALBgNVHQ8EBAMCAcYw
DwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUiYJnfcSdJnAAS7RQSHzePa4Ebn0wWAYDVR0fBFEw
TzBNoEugSYZHaHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VUTi1VU0VSRmlyc3QtQ2xpZW50QXV0
aGVudGljYXRpb25hbmRFbWFpbC5jcmwwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0G
CSqGSIb3DQEBBQUAA4IBAQCxbWFdphp/fKtK5DD8U28lJMbK7eIxXCsO7u5hVW8EPs853sUbSZTk
6yBMtOaeUC5y2Y31qqOzStpWHGCXgNyCoq1KvYor/wsJtMbXIARF5M2AAbq6K27OqteS/uSv6/Qm
HRYqf2wwlTcvMxKsf93H0RGMUZiy0KOR0K32n56Dkx4dQrhGr2tm8Jt/6uMDAuUCUcGq1TWdckAD
iboxHcUQaFKe36KFxVwIpnjmU0+x6LfTFJ6TpsNk46x+cc28n+kDG8z76awxwa98FXQCmcOyR6bC
MmHXx29IJFEnodWHVfJ7j5g9Fp7udbb40I7y88auKFun8PM2F/zDBdPKA0pUMIIFKjCCBBKgAwIB
AgIRAI4Kp7vwJ39Dcr7RpNaqobcwDQYJKoZIhvcNAQEFBQAwZTELMAkGA1UEBhMCU0UxFDASBgNV
BAoTC0FkZFRydXN0IEFCMR0wGwYDVQQLExRBZGRUcnVzdCBUVFAgTmV0d29yazEhMB8GA1UEAxMY
QWRkVHJ1c3QgQ2xhc3MgMSBDQSBSb290MB4XDTA2MDIwOTAwMDAwMFoXDTA3MDIwOTIzNTk1OVow
gd8xNTAzBgNVBAsTLENvbW9kbyBUcnVzdCBOZXR3b3JrIC0gUEVSU09OQSBOT1QgVkFMSURBVEVE
MUYwRAYDVQQLEz1UZXJtcyBhbmQgQ29uZGl0aW9ucyBvZiB1c2U6IGh0dHA6Ly93d3cuY29tb2Rv
Lm5ldC9yZXBvc2l0b3J5MR8wHQYDVQQLExYoYykyMDAzIENvbW9kbyBMaW1pdGVkMR0wGwYDVQQD
ExRTdGlhbiBCcmVpdmlrIEJhcm1lbjEeMBwGCSqGSIb3DQEJARYPc3RpYW5AYmFybWVuLm51MIGf
MA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDB022vCAja+fE4pkQSW4ZiwosUSjq5+m7QKMWBfRRJ
jtw4o6l+/YJBNtB+Mb5TsbAgNX+2FHw1gaSak2464UXaM3ALdSIZWtlqY1PJPla8oN5YA0uBA22/
pfCjExHsYXeFI/juU81f075XXfnDePOefXzhgCuBPhs0VAjAv/ZEGwIDAQABo4IB3DCCAdgwHQYD
VR0OBBYEFAFKeatr9fKETjjqRPrRh76bvxKbMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAA
MCAGA1UdJQQZMBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAwRgYD
VR0gBD8wPTA7BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29t
b2RvLm5ldC9DUFMwdwYDVR0fBHAwbjA2oDSgMoYwaHR0cDovL2NybC5jb21vZG9jYS5jb20vQWRk
VHJ1c3RDbGFzczFDQVJvb3QuY3JsMDSgMqAwhi5odHRwOi8vY3JsLmNvbW9kby5uZXQvQWRkVHJ1
c3RDbGFzczFDQVJvb3QuY3JsMIGGBggrBgEFBQcBAQR6MHgwOwYIKwYBBQUHMAKGL2h0dHA6Ly9j
cnQuY29tb2RvY2EuY29tL0FkZFRydXN0VVROQ2xpZW50Q0EuY3J0MDkGCCsGAQUFBzAChi1odHRw
Oi8vY3J0LmNvbW9kby5uZXQvQWRkVHJ1c3RVVE5DbGllbnRDQS5jcnQwGgYDVR0RBBMwEYEPc3Rp
YW5AYmFybWVuLm51MA0GCSqGSIb3DQEBBQUAA4IBAQBJmQJ8950aKJwavm774C+qd36h0nCzqgVz
OHeLnHiHYfuEF7W4gt46gE19YYgUiN+aXcrduaPlGdXLP++9lP7+TegfVngMO5lONJMEZfSyxEWx
pTiccB6SsBiLYSJTQAdhlZFIgaTqblY1dHQ45s0i9lHN/LOJ5kQsTKEVUqAh9wPGD/KW8ktloSfA
AFltqk/975DSjtdCLwNQXXzma8cpvraes8+e/UZZ3b9IPU8BaiZXpV1rUufig2cvVDOAUwe2WVCi
hluzHwNcETx5S0Jd/78K8skHiJHAcq/OKGSMt/n2O1OZeLI8PTN3p68WSd2MqlaPOAlMpbGkFaGk
lTFXMYIDBDCCAwACAQEwejBlMQswCQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxHTAb
BgNVBAsTFEFkZFRydXN0IFRUUCBOZXR3b3JrMSEwHwYDVQQDExhBZGRUcnVzdCBDbGFzcyAxIENB
IFJvb3QCEQCOCqe78Cd/Q3K+0aTWqqG3MAkGBSsOAwIaBQCgggHgMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA2MDUxNjEwMTcxNFowIwYJKoZIhvcNAQkEMRYEFCBd
PeFg+NjPWmaoCteasaELcibKMGcGCSqGSIb3DQEJDzFaMFgwCgYIKoZIhvcNAwcwDgYIKoZIhvcN
AwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMAcGBSsOAwIaMAoG
CCqGSIb3DQIFMIGJBgkrBgEEAYI3EAQxfDB6MGUxCzAJBgNVBAYTAlNFMRQwEgYDVQQKEwtBZGRU
cnVzdCBBQjEdMBsGA1UECxMUQWRkVHJ1c3QgVFRQIE5ldHdvcmsxITAfBgNVBAMTGEFkZFRydXN0
IENsYXNzIDEgQ0EgUm9vdAIRAI4Kp7vwJ39Dcr7RpNaqobcwgYsGCyqGSIb3DQEJEAILMXygejBl
MQswCQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxHTAbBgNVBAsTFEFkZFRydXN0IFRU
UCBOZXR3b3JrMSEwHwYDVQQDExhBZGRUcnVzdCBDbGFzcyAxIENBIFJvb3QCEQCOCqe78Cd/Q3K+
0aTWqqG3MA0GCSqGSIb3DQEBAQUABIGAAY31iIgIvWWWUhoVdEy7E/qCTyK8/QgKx5fzQKt95/Je
ELqJqOaX/YhHIem73q5/D/L1GTBuT1vuSm5J+r7c+xkV/UA+TqmmntXh3MEWUI/6qZuAAkjnO0N6
9PCVxQ1NCarfFN0vLxkdk86XqUh9/gHEuYQjKiHYgqEkX+0fp10AAAAAAAA=

------=_NextPart_000_007A_01C678E2.AAC33660--

