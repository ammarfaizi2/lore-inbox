Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272240AbRIQCle>; Sun, 16 Sep 2001 22:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272244AbRIQCl0>; Sun, 16 Sep 2001 22:41:26 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:58319 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S272240AbRIQClS>;
	Sun, 16 Sep 2001 22:41:18 -0400
Message-ID: <3BA56490.FD898C70@sun.com>
Date: Sun, 16 Sep 2001 19:48:48 -0700
From: Stephane Brossier <stephane.brossier@sun.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Stephane Brossier <Stephane.Brossier@sun.com>
Subject: PROBLEM: [1.] X session randomly crashes because of kernel problem.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] X session randomly crashes because of kernel problem.

[2.] I installed the standart version of Mandrake8.0,
     and I am working under kde2.1.1 with Xfree86 4.0.3.

     Suddenly my X session exits. Looking at the syslog
     I can see the following log:

Sep 16 19:13:30 129 kernel: Unable to handle kernel paging request at
virtual address 6d740010
Sep 16 19:13:30 129 kernel:  printing eip:
Sep 16 19:13:30 129 kernel: c012701b
Sep 16 19:13:30 129 kernel: pgd entry c40306d4: 0000000000000000
Sep 16 19:13:30 129 kernel: pmd entry c40306d4: 0000000000000000
Sep 16 19:13:30 129 kernel: ... pmd not present!
Sep 16 19:13:30 129 kernel: Oops: 0000
Sep 16 19:13:30 129 kernel: CPU:    0
Sep 16 19:13:30 129 kernel: EIP:    0010:[kfree+55/192]
Sep 16 19:13:30 129 kernel: EIP:    0010:[<c012701b>]
Sep 16 19:13:30 129 kernel: EFLAGS: 00013087
Sep 16 19:13:30 129 kernel: eax: 064d0000   ebx: c53e7780   ecx:
c1000010   edx: ac740000
Sep 16 19:13:30 129 kernel: esi: c64d0000   edi: 00003286   ebp:
c05615f4   esp: c4051e98
Sep 16 19:13:30 129 kdm[1216]: Server for display :0 terminated
unexpectedly: 2816
Sep 16 19:13:30 129 kernel: ds: 0018   es: 0018   ss: 0018
Sep 16 19:13:31 129 kernel: Process X (pid: 1224, stackpage=c4051000)
Sep 16 19:13:31 129 kernel: Stack: c53e7780 c53e7780 c53e77dc c05615f4
c4051f80
64d00000 c01b03c3 c64d0000
Sep 16 19:13:31 129 kernel:        c53e7780 00000040 c01b03d7 c53e7780
c53e7780
c01b054d c53e7780 000003f0
Sep 16 19:13:31 129 kernel:        c53e7780 c01e8636 c53e7780 c1e37e94
000003f0
00000040 c4051f84 c53e7780
Sep 16 19:13:31 129 kernel: Call Trace: [skb_release_data+103/112]
[kfree_skbmem+11/88] [__kfree_skb+297/304] [unix_stream_recvmsg+714/924]
[sock_recvmsg+65/176] [unix_stream_recvmsg+0/924] [sock_read+147/156]
Sep 16 19:13:31 129 kernel: Call Trace: [<c01b03c3>] [<c01b03d7>]
[<c01b054d>] [<c01e8636>] [<c01ad881>] [<c01e836c>] [<c01ad98f>]
Sep 16 19:13:31 129 kernel:        [sys_read+142/196]
[system_call+51/64]
Sep 16 19:13:31 129 kernel:        [<c012dca6>] [<c0106f23>]
Sep 16 19:13:31 129 kernel:
Sep 16 19:13:31 129 kernel: Code: 8b 1c 11 8b 4c 11 04 2b 71 0c 89 f0 31
d2 f7 73 0c 89 c5 8b
Sep 16 19:13:41 129 kernel:  <3>[drm:r128_do_wait_for_fifo] *ERROR*
r128_do_wait_for_fifo failed!
Sep 16 19:13:42 129 kernel: [drm:r128_do_wait_for_fifo] *ERROR*
r128_do_wait_for_fifo failed!
Sep 16 19:13:57 129 kernel: [drm:r128_do_wait_for_fifo] *ERROR*
r128_do_wait_for_fifo failed!
Sep 16 19:13:59 129 modprobe: modprobe: Can't locate module binfmt-0000
Sep 16 19:13:59 129 modprobe: modprobe: Can't locate module binfmt-0000
Sep 16 19:13:59 129 kernel: [drm:r128_do_wait_for_fifo] *ERROR*
r128_do_wait_for_fifo failed!

[3.] keywords : kernel, Ooups, pmd

[4.] Kernel version (from /proc/version): 

Linux version 2.4.3-20mdk (chmou@no.mandrakesoft.com) (gcc version
egcs-2.91.66
19990314/Linux (egcs-1.1.2 release / Linux-Mandrake 8.0)) #1 Sun Apr
15 23:03:10 CEST 2001

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)


[6.] A small shell script or example program which triggers the
     problem (if possible)

     Nothing special to trigger the problem. This
     happens randomly and quite often-- almost every day.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux 129.150.111.9 2.4.3-20mdk #1 Sun Apr 15 23:03:10 CEST 2001 i686
unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.1.0.2
util-linux             2.10s
mount                  2.11b
modutils               2.4.3
e2fsprogs              1.19
reiserfsprogs          3.x.0i
PPP                    2.4.0
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.59
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         soundcore r128 agpgart nfs lockd sunrpc autofs
e100 supermount reiserfs

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : CyrixInstead
cpu family      : 6
model           : 2
model name      : 6x86MX 2.5x Core/Bus Clock
stepping        : 6
cpu MHz         : 187.502
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : yes
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 pge cmov mmx cyrix_arr
bogomips        : 374.37

[7.3.] Module information (from /proc/modules):
r128                  144688   1
agpgart                21280   3
nfs                    73632   1 (autoclean)
lockd                  48720   1 (autoclean) [nfs]
sunrpc                 59232   1 (autoclean) [nfs lockd]
autofs                  9232   0 (autoclean) (unused)
e100                   41488   1 (autoclean)
supermount             32496   4 (autoclean)
reiserfs              165760   3

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

/proc/ioports
-------------
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
6000-60ff : VIA Technologies, Inc. VT82C586B ACPI
6400-640f : VIA Technologies, Inc. Bus Master IDE
  6400-6407 : ide0
  6408-640f : ide1
6c00-6c1f : Intel Corporation 82557 [Ethernet Pro 100]
  6c00-6c1f : e100
e000-efff : PCI Bus #01
  e000-e0ff : ATI Technologies Inc Rage 128 RF

/proc/iomem
-----------

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-001f412b : Kernel code
  001f412c-0023bfab : Kernel data
a8000000-afffffff : PCI Bus #01
  a8000000-abffffff : ATI Technologies Inc Rage 128 RF
    a8000000-a8ffffff : vesafb
d8000000-dfffffff : PCI Bus #01
  d8000000-d8003fff : ATI Technologies Inc Rage 128 RF
e0000000-e3ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
e4000000-e40fffff : Intel Corporation 82557 [Ethernet Pro 100]
e4100000-e4100fff : Intel Corporation 82557 [Ethernet Pro 100]
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev
04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 16
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=7 SBA+ 64bit- FW- Rate=x1
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: d8000000-dfffffff
        Prefetchable memory behind bridge: a8000000-afffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA
[Apollo VP] (rev 41)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 6400 [size=16]

00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:0a.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 01)        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 (2000ns min, 14000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e4100000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at 6c00 [size=32]
        Region 2: Memory at e4000000 (32-bit, non-prefetchable)
[size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
 
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF
(prog-if 00
[VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0004
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at a8000000 (32-bit, prefetchable) [size=64M]
        Region 1: I/O ports at e000 [size=256]
        Region 2: Memory at d8000000 (32-bit, non-prefetchable)
[size=16K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=7 SBA+ AGP+ 64bit- FW- Rate=x1
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

N/A

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):


[X.] Other notes, patches, fixes, workarounds:

N/A
