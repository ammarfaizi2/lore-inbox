Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262437AbRENTxW>; Mon, 14 May 2001 15:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262438AbRENTxM>; Mon, 14 May 2001 15:53:12 -0400
Received: from enchanter.real-time.com ([208.20.202.11]:43273 "EHLO
	enchanter.real-time.com") by vger.kernel.org with ESMTP
	id <S262437AbRENTw6>; Mon, 14 May 2001 15:52:58 -0400
Date: Mon, 14 May 2001 14:52:57 -0500
From: Bob Tanner <tanner@real-time.com>
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.4.4 fails to compile for PPC
Message-ID: <20010514145257.A11088@real-time.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem: 
2.4.4 fails to compile for G3 ppc

[2.] Full description of the problem/report:
make[1]: Entering directory `/usr/src/linux-2.4.4/arch/ppc/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.4/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
-Wa,-mppc64bridge    -DEXPORT_SYMTAB -c ppc_ksyms.c
ppc_ksyms.c:335: `down_read_failed' undeclared here (not in a function)
ppc_ksyms.c:335: initializer element is not constant
ppc_ksyms.c:335: (near initialization for `__ksymtab_down_read_failed.value')
ppc_ksyms.c:336: `down_write_failed' undeclared here (not in a function)
ppc_ksyms.c:336: initializer element is not constant
ppc_ksyms.c:336: (near initialization for `__ksymtab_down_write_failed.value')
make[1]: *** [ppc_ksyms.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.4/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Error 2

[3.] Keywords (i.e., modules, networking, kernel):
kernel, failed compile, PPC, ppc, Mac G3

[4.] Kernel version (from /proc/version):
Linux seeker 2.2.17-0.6.1 #1 Thu Jun 29 15:15:56 CDT 2000 ppc unknown

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the
     problem (if possible)

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux seeker 2.2.17-0.6.1 #1 Thu Jun 29 15:15:56 CDT 2000 ppc unknown
 
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.22
util-linux             2.10f
mount                  2.10r
modutils               2.3.10-pre1
e2fsprogs              1.18
pcmcia-cs              3.1.8
PPP                    2.3.11
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         ip_masq_vdolive ip_masq_user ip_masq_raudio ip_masq_quake
ip_masq_portfw ip_masq_mfw ip_masq_irc ip_masq_ftp ip_masq_cuseeme
ip_masq_autofw

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
cpu		: 750
temperature 	: 0 C
clock		: 267MHz
revision	: 2.2
bogomips	: 534.12
zero pages	: total 0 (0Kb) current: 0 (0Kb) hits: 0/647 (0%)
machine		: Power Macintosh
motherboard	: AAPL,PowerMac G3 MacRISC
L2 cache	: 512K unified pipelined-syncro-burst
memory		: 160MB
pmac-generation	: OldWorld

[7.3.] Module information (from /proc/modules):
ip_masq_vdolive         1880   0 (unused)
ip_masq_user            3448   0 (unused)
ip_masq_raudio          3592   0 (unused)
ip_masq_quake           1880   0 (unused)
ip_masq_portfw          3208   0 (unused)
ip_masq_mfw             4616   0 (unused)
ip_masq_irc             2040   0 (unused)
ip_masq_ftp             3096   0 (unused)
ip_masq_cuseeme         1528   0 (unused)
ip_masq_autofw          3272   0 (unused)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Motorola MPC106 [Grackle] (rev 40)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR+
	Latency: 0 set, cache line size 08

00:10.0 Class ff00: Apple Computer Inc. Heathrow Mac I/O (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 set, cache line size 08
	Region 0: Memory at f3000000 (32-bit, non-prefetchable)

00:12.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro 215GP (rev
5c) (prog-if 00 [VGA])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at 81000000 (32-bit, non-prefetchable)
	Region 1: I/O ports at 0c00 [disabled]
	Region 2: Memory at 80800000 (32-bit, non-prefetchable)

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices: 
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: J.03
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:

Looking through the source code, I see rwsem_down_read_failed, but not
down_read_failed, it might just be a typo?

-- 
Bob Tanner <tanner@real-time.com>       | Phone : (952)943-8700
http://www.mn-linux.org                 | Fax   : (952)943-8500
Key fingerprint =  6C E9 51 4F D5 3E 4C 66 62 A9 10 E5 35 85 39 D9 

