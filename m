Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310889AbSCHPCl>; Fri, 8 Mar 2002 10:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310897AbSCHPCd>; Fri, 8 Mar 2002 10:02:33 -0500
Received: from www.activelink.de ([62.138.12.141]:27917 "EHLO
	al-www-mun-00.activelink.de") by vger.kernel.org with ESMTP
	id <S310889AbSCHPCT>; Fri, 8 Mar 2002 10:02:19 -0500
Subject: Linux kernel crashes repeatedly
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF6648ADF3.2CD72017-ONC1256B76.00500C9A@activelink.de>
From: Roland.Boden@activelink.de
Date: Fri, 8 Mar 2002 16:04:55 +0100
X-MIMETrack: Serialize by Router on AL-WWW-MUN-00/ACTIVELINK/DE(Release 5.0.5 |September
 22, 2000) at 08.03.2002 16:02:32
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linux experts,

I suddenly have a problem with Linux kernel crashes. It looks like a kernel
problem.
Maybe I can help to

Here is my "bug report form":

[1.] One line summary of the problem:
Linux crashes without any report/log (everything freezes) when a "special
IP-connection" is made through Linux as router.

[2.] Full description of the problem/report:
On a client in our (private) IP-network the software "Morpheus 1.33" from
http://www.musiccity.com is started. When the Morpheus client connects to
the "Morpheus Server" the Linux box freezes. Linux is our IP-router from
192.168.1.x-network to Internet. On the Linux box iptables with
Masquerading is running. The Internet port is pppoe connected to a ADSL
modem.
There is no logging information about the crash. Keyboard, network and
everything else is frozen. Only hardware reset helps.
We tested several times and the result is alway the same...

[3.] Keywords (i.e., modules, networking, kernel):
networking

[4.] Kernel version (from /proc/version):
root@al-net-mun-00:/usr/src/linux-2.4.4.SuSE > cat /proc/version
Linux version 2.4.4 (root@al-net-mun-00) (gcc version 2.95.3 20010315
(SuSE)) #4 Wed Nov 7 20:07:27 MET 2001

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
root@al-net-mun-00:/usr/src/linux-2.4.4.SuSE > sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux al-net-mun-00 2.4.4 #4 Wed Nov 7 20:07:27 MET 2001 i586 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.91.0.4
util-linux             2.11b
mount                  2.11b
modutils               2.4.5
e2fsprogs              1.19
pcmcia-cs              3.1.25
PPP                    2.4.0
isdn4k-utils           3.1pre1a
Linux C Library        x    1 root     root      1343073 Mai 11  2001
/lib/libc.so.6
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         st pppoe pppox ipt_LOG ipt_limit ipt_state af_packet
ppp_async ppp_generic ipt_MASQUERADE iptable_nat ip_conntrack
ne2k-pci 8390 8139too iptable_filter ip_tables hisax isdn slhc ncr53c8xx

[7.2.] Processor information (from /proc/cpuinfo):
root@al-net-mun-00:/usr/src/linux-2.4.4.SuSE > cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 6
model name      : AMD-K6tm w/ multimedia extensions
stepping        : 2
cpu MHz         : 233.867
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 466.94

[7.3.] Module information (from /proc/modules):
root@al-net-mun-00:/usr/src/linux-2.4.4.SuSE > cat /proc/modules
st                     25264   0 (autoclean)
pppoe                   6624   2 (autoclean)
pppox                   1360   1 (autoclean) [pppoe]
ipt_LOG                 3472   3 (autoclean)
ipt_limit               1152   3 (autoclean)
ipt_state                864   7 (autoclean)
af_packet               8304   2 (autoclean)
ppp_async               6416   0 (autoclean) (unused)
ppp_generic            13344   3 (autoclean) [pppoe pppox ppp_async]
ipt_MASQUERADE          1392   3 (autoclean)
iptable_nat            14256   0 (autoclean) [ipt_MASQUERADE]
ip_conntrack           13424   2 (autoclean) [ipt_state ipt_MASQUERADE
iptable_nat]
ne2k-pci                4576   1 (autoclean)
8390                    6176   0 (autoclean) [ne2k-pci]
8139too                11456   1 (autoclean)
iptable_filter          2016   0 (autoclean) (unused)
ip_tables              10656   8 [ipt_LOG ipt_limit ipt_state
ipt_MASQUERADE iptable_nat iptable_filter]
hisax                 149520   7
isdn                  118544   8 [hisax]
slhc                    4768   3 [ppp_generic isdn]
ncr53c8xx              51888   4

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
root@al-net-mun-00:/usr/src/linux-2.4.4.SuSE > cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0180-019f : HiSax hscx A
02f8-02ff : serial(auto)
03c0-03df : vga+
03f8-03ff : serial(auto)
0580-059f : HiSax hscx B
0980-099f : HiSax isac
0cf8-0cff : PCI conf1
0d80-0d87 : teles3 cfg
6000-60ff : VIA Technologies, Inc. VT82C586B ACPI
f200-f21f : NetVin NV5000SC
  f200-f21f : ne2k-pci
f300-f3ff : Realtek Semiconductor Co., Ltd. RTL-8139
  f300-f3ff : 8139too
f400-f4ff : Symbios Logic Inc. (formerly NCR) 53c875
  f400-f47f : ncr53c8xx

root@al-net-mun-00:/usr/src/linux-2.4.4.SuSE > cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000ca1ff : Extension ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-001b96d0 : Kernel code
  001b96d1-001fb65f : Kernel data
e0000000-e3ffffff : S3 Inc. 86c764/765 [Trio32/64/64V+]
e4000000-e40000ff : Realtek Semiconductor Co., Ltd. RTL-8139
  e4000000-e40000ff : 8139too
e4001000-e40010ff : Symbios Logic Inc. (formerly NCR) 53c875
e4002000-e4002fff : Symbios Logic Inc. (formerly NCR) 53c875
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
root@al-net-mun-00:/usr/src/linux-2.4.4.SuSE > lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C585VP [Apollo VP1/VPX]
(rev 23)

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo
VP] (rev 41)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.3 Non-VGA unclassified device: VIA Technologies, Inc. VT82C586B ACPI
(rev10)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:08.0 Ethernet controller: NetVin NV5000SC
        Subsystem: NetVin RT8029-Based Ethernet Adapter
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at f200 [size=32]

00:09.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (rev
54)(prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev
10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at f300 [size=256]
        Region 1: Memory at e4000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875
(rev 03)
        Subsystem: Tekram Technology Co.,Ltd. DC390F Ultra Wide SCSI
Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4250ns min, 16000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at f400 [size=256]
        Region 1: Memory at e4001000 (32-bit, non-prefetchable) [size=256]
        Region 2: Memory at e4002000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

[7.6.] SCSI information (from /proc/scsi/scsi)
root@al-net-mun-00:/usr/src/linux-2.4.4.SuSE > cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DCAS-34330       Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: HP       Model: C1537A           Rev: L708
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: TOSHIBA  Model: CD-ROM XM-5701TA Rev: 1557
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:


---------------------------------------------------------
Roland Boden

Activelink GmbH

Post: Bahnhofstr. 36, D-85591 Vaterstetten
eMail: rb@activelink.de
Phone: +49 (0) 8106 3795 11
Fax: +49 (0) 8106 3795 20
Internet: http://www.activelink.de
---------------------------------------------------------

