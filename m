Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbREaSdt>; Thu, 31 May 2001 14:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263144AbREaSdj>; Thu, 31 May 2001 14:33:39 -0400
Received: from hirosima.martos.bme.hu ([152.66.232.21]:59402 "EHLO
	hirosima.martos.bme.hu") by vger.kernel.org with ESMTP
	id <S263143AbREaSde>; Thu, 31 May 2001 14:33:34 -0400
Date: Thu, 31 May 2001 20:33:30 +0200 (CEST)
From: CZUCZY Gergely <phoemix@mayday.hu>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: isdn connecting error(auth failed) with 2.4.4-ac9 and 2.4.5
Message-ID: <Pine.LNX.4.21.0105312020010.20643-100000@hirosima.martos.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here come the bugreport:
1: isdn connecting error(auth failed) with 2.4.4-ac9 and 2.4.5
2.: when trying to connect to my ISP with kernels 2.4.4-ac9 and 2.4.5 it
always drops my connection with this(from syslog):
May 27 15:00:50 kign kernel: ippp0: dialing 1 0651201201...
May 27 15:00:51 kign kernel: isdn_net: ippp0 connected
May 27 15:00:51 kign ipppd[391]: Local number: 2536889, Remote
number: 0651201201, Type: outgoing
May 27 15:00:51 kign ipppd[391]: PHASE_WAIT -> PHASE_ESTABLISHED,
ifunit: 0, linkunit: 0, fd: 7
May 27 15:00:52 kign ipppd[391]: Remote message: Access Denied
May 27 15:00:52 kign ipppd[391]: PAP authentication failed
May 27 15:00:52 kign ipppd[391]: LCP terminated by peer
May 27 15:00:52 kign kernel: ippp0: remote hangup
May 27 15:00:52 kign kernel: ippp0: Chargesum is 0
May 27 15:00:52 kign kernel: ippp_ccp: freeing reset data structure
c5f43800
May 27 15:00:52 kign kernel: ippp, open, slot: 0, minor: 1, state: 0000
May 27 15:00:52 kign kernel: ippp_ccp: allocated reset data structure
c5f43800
May 27 15:00:52 kign ipppd[391]: Modem hangup
May 27 15:00:52 kign ipppd[391]: Connection terminated.
May 27 15:00:52 kign ipppd[391]: taking down PHASE_DEAD link 0,
linkunit: 0
May 27 15:00:52 kign ipppd[391]: closing fd 7 from unit 0
May 27 15:00:52 kign ipppd[391]: link 0 closed , linkunit: 0
May 27 15:00:52 kign ipppd[391]: reinit_unit: 0

and my ISP do not know what is the problame, it works with the 2.4.4
kernel

3.: keywords: module,isdn, connectionerror
4.: 2.4.4-ac9 and 2.4.5
5.: -- 
6.: --
7.1:
Compare to the current minimal requirements in Documentation/Changes.

Linux kign 2.4.4 #3 Thu May 31 18:28:32 CEST 2001 i686 unknown

Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.37
util-linux
util-linux             Note: /usr/bin/fdformat is obsolete and is no
longer available.
util-linux             Please use /usr/bin/superformat instead (make sure
you have the
util-linux             fdutils package installed first).  Also, there had
been some
util-linux             major changes from version 4.x.  Please refer to
the documentation.
util-linux
mount                  2.10f
modutils               2.3.11
e2fsprogs              1.18
pcmcia-cs              3.1.8
PPP                    2.3.11
isdn4k-utils           3.1pre1
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         NVdriver hisax isdn slhc au8820

7.2:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 834.554
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips        : 1664.61

7.3:
NVdriver              656144  15
hisax                 158704   5
isdn                  123472   6 [hisax]
slhc                    4800   4 [isdn]
au8820                115976   1
7.4:
02:03.0 Network controller: Eicon Technology Corporation: Unknown device
e005 (rev 01)
        Subsystem: Eicon Technology Corporation: Unknown device e005
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at df022000 (32-bit, non-prefetchable) [size=4K]
        Region 1: Memory at df023000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk+ AuxPwr- DSI+ D1+ D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=3 PME-

8.:
my notes:
please reply me when someone read this bug report, and will it be
repaired, or net in the future(if won't i could not use kernel higher then
2.4.4, because of this bug). I read in the Changes about Alan Cox's
changes in the isdn subsystem, maybe there is some connection with this
bug.

thanx!

Gergely "PhOeMiX" Czuczy
mailto: phoemix@mayday.hu
web: http://phoemix.mayday.hu


