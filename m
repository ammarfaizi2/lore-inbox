Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270222AbRHMOUJ>; Mon, 13 Aug 2001 10:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270220AbRHMOTz>; Mon, 13 Aug 2001 10:19:55 -0400
Received: from tag.witbe.net ([62.161.213.166]:51984 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S270222AbRHMOTo>;
	Mon, 13 Aug 2001 10:19:44 -0400
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Cc: "Paul Rolland \(AS2917\)" <rol@as2917.net>
Subject: Ooops... probably IPv6 related, kernel 2.4.4
Date: Mon, 13 Aug 2001 16:19:51 +0200
Message-ID: <NEBBIPOEBBGDFEJAJJBCIEKKEOAA.rol@as2917.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Let me follow the BUGS-REPORTING procedure :

[1.] Ooops following the 5th or 6th IPv6 ping received thru a tap
     interface (using VTun).
[2.] I'm using VTun to link two machines, thus having IPv4 and IPv6 set
     up on two boxes. I also have a two sit interfaces as the machine
     is also connected to an IPv6 network. I've activated IPv6 forwarding.
     From the second machine (not routing anything) at the end of the
     VTun/tap tunnel, I start a ping6 command either directly to the end
     of the tunnel or involving routing action.
     Following receipt of the 5th or 6th IPv6 packet, the machine crashes.
     When using only IPv4 traffic, no problem occurs.
[3.] Networking - IPv6
[4.] Linux version 2.4.4 (root@www-dev.witbe.net) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #7 Fri Jul 13 13:35:54 GMT 2001
[5.] Oops printing :
Printing eip: c022e864
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c022e864>]
EFLAGS: 00010206
eax: c14c5400 ebx: fffffffd ecx: 00000000 edx: ce3a5a1c
esi: 00000000 edi: 00000000 ebp: ce3a5a1c esp: c02d9ea0
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0 stackpage=c02d90000)
Stack: c02345e7 00000000 fffffffd cf9e4384 00000000 cf9e4320 00000018
00000000
       c14c5400 c1453800 00000000 c01fcd30 c1453800 cf8cebc0 c0234b82
ce3a5a1c
       cf9e4320 cf9e4384 cf9e4384 00000000 00018d52 cf9e4320 cf9e4320
c01f5998
Call Trace: [<c02345e7>] [<c01fcd30>] [<c0234b82>] [<c01f5958>] [<c01f5aa8>]
[<c
011b9ec>] [<c010ac56>]
            [<c0118757>] [<c0118698>] [<c011859e>] [<c0107f38>] [<ef1342a0>]
[<c
0106b88>] [<ef1342a0>] [<ef1342a0>]
            [<c01ebbcd>] [<c01eb98c>] [<c0105160>] [<c01051e4>] [<c0105000>]
[<c
0100198>]

Code: 8b 11 f6 c2 e0 74 15 89 d0 25 e0 00 00 00 3d e0 00 00 00 74
Kernel panic: Aiee, killing interrupt handler!
[6.]
[7.1] sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux www-dev.witbe.net 2.4.4 #7 Fri Jul 13 13:35:54 GMT 2001 i686 unknown

Gnu C                  egcs-2.91.66
Gnu make               3.77
binutils               2.9.1.0.24
usage: fdformat [ -n ] device
mount                  2.9u
modutils               2.4.6
e2fsprogs              1.15
pcmcia-cs              3.1.4
PPP                    2.3.10
Linux C Library        2.1.2
Dynamic linker (ldd)   2.1.2
Procps                 2.0.4
Net-tools              1.58
Console-tools          1999.03.02
Sh-utils               2.0
Modules Loaded
[7.2] cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 1
cpu MHz         : 598.147
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
bogomips        : 1192.75
[7.3] cat /proc/modules
# Nothing returned
[7.4] cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
08b0-08bf : PCI device 1166:0211 (ServerWorks)
0cf8-0cff : PCI conf1
ccc0-ccff : Intel Corporation 82557 [Ethernet Pro 100]
  ccc0-ccff : eepro100
d000-dfff : PCI Bus #02
  d800-d8ff : Adaptec 7899P
  dc00-dcff : PCI device 9005:00c5 (Adaptec)
e800-e8ff : ATI Technologies Inc 3D Rage IIC
ec80-ecff : PCI device 101e:9063 (American Megatrends Inc.)

cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffdfff : System RAM
  00100000-002524f1 : Kernel code
  002524f2-002d78a3 : Kernel data
0fffe000-0fffffff : reserved
f0000000-f3ffffff : Dell Computer Corporation PowerEdge Expandable RAID
Controller 3/Si
f5000000-f5ffffff : PCI Bus #02
f8000000-f9ffffff : PCI Bus #02
  f8ffe000-f8ffefff : Adaptec 7899P
  f8fff000-f8ffffff : PCI device 9005:00c5 (Adaptec)
fa000000-fa0fffff : Intel Corporation 82557 [Ethernet Pro 100]
fa100000-fa100fff : Intel Corporation 82557 [Ethernet Pro 100]
  fa100000-fa100fff : eepro100
fc000000-fcffffff : ATI Technologies Inc 3D Rage IIC
fe000000-fe000fff : PCI device 1166:0220 (ServerWorks)
fe001000-fe001fff : ATI Technologies Inc 3D Rage IIC
fe002000-fe002fff : PCI device 101e:9063 (American Megatrends Inc.)
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
fff80000-ffffffff : reserved
[7.5] lspci -vvv
lspci -vvv
00:00.0 Host bridge: Pequr Technology: Unknown device 0009 (rev 05)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 48 set, cache line size 08

00:00.1 Host bridge: Pequr Technology: Unknown device 0009 (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 48 set, cache line size 08

00:04.0 System peripheral: American Megatrends Inc.: Unknown device 9063
(rev 04)
        Subsystem: Unknown device 101e:0767
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 17
        BIST result: 00
        Region 0: I/O ports at ec80
        Region 1: Memory at fe002000 (32-bit, non-prefetchable)

00:0e.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4759
(rev 7a)
        Subsystem: Unknown device 1028:00a6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 32 set, cache line size 08
        Region 0: Memory at fc000000 (32-bit, prefetchable)
        Region 1: I/O ports at e800
        Region 2: Memory at fe001000 (32-bit, non-prefetchable)
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: Pequr Technology: Unknown device 0200 (rev 4f)
        Subsystem: Unknown device 1166:0200
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:0f.1 IDE interface: Pequr Technology: Unknown device 0211 (prog-if 8a)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Region 4: I/O ports at 08b0

00:0f.2 USB Controller: Pequr Technology: Unknown device 0220 (rev 04)
(prog-if 10)
        Subsystem: Unknown device 1166:0220
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 80 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fe000000 (32-bit, non-prefetchable)

01:02.0 PCI bridge: Intel Corporation: Unknown device 0962 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set, cache line size 10
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: f8000000-f9ffffff
        Prefetchable memory behind bridge: f5000000-f5ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

01:02.1 RAID bus controller: Dell Computer Corporation: Unknown device 0003
(rev 01)
        Subsystem: Unknown device 1028:0003
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 31
        Region 0: Memory at f0000000 (32-bit, prefetchable)

01:08.0 Ethernet controller: Intel Corporation 82557 (rev 08)
        Subsystem: Unknown device 1028:009b
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 56 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fa100000 (32-bit, non-prefetchable)
        Region 1: I/O ports at ccc0
        Region 2: Memory at fa000000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:04.0 SCSI storage controller: Adaptec: Unknown device 00c5 (rev 01)
        Subsystem: Unknown device 1028:0003
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 40 min, 25 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 31
        BIST result: 00
        Region 0: I/O ports at dc00
        Region 1: Memory at f8fff000 (64-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:04.1 SCSI storage controller: Adaptec 7899P (rev 01)
        Subsystem: Unknown device 1028:00a6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 40 min, 25 max, 32 set, cache line size 08
        Interrupt: pin B routed to IRQ 30
        BIST result: 00
        Region 0: I/O ports at d800
        Region 1: Memory at f8ffe000 (64-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
[7.6] cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: DELL     Model: PERCRAID Mirror  Rev: 0001
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: DELL     Model: PERCRAID Mirror  Rev: 0001
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7]
[X] ksymoops -v /usr/src/linux-2.4.4/vmlinux oops.file
ksymoops 2.4.1 on i686 2.4.4.  Options used
     -v /usr/src/linux-2.4.4/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4/ (default)
     -m /boot/System.map (default)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod
file?
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(shmem_file_setup) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol ip_ct_attach_R__ver_ip_ct_attach
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
netlink_attach_R__ver_netlink_attach not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
netlink_detach_R__ver_netlink_detach not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol netlink_post_R__ver_netlink_post
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol nf_getsockopt_R__ver_nf_getsockopt
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol nf_hook_slow_R__ver_nf_hook_slow
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol nf_hooks_R__ver_nf_hooks not found
in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_register_hook_R__ver_nf_register_hook not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_register_queue_handler_R__ver_nf_register_queue_handler not found in
vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_register_sockopt_R__ver_nf_register_sockopt not found in vmlinux.
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol nf_reinject_R__ver_nf_reinject not
found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol nf_setsockopt_R__ver_nf_setsockopt
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_unregister_hook_R__ver_nf_unregister_hook not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_unregister_queue_handler_R__ver_nf_unregister_queue_handler not found in
vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_unregister_sockopt_R__ver_nf_unregister_sockopt not found in vmlinux.
Ignoring ksyms_base entry
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c022e864>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c14c5400 ebx: fffffffd ecx: 00000000 edx: ce3a5a1c
esi: 00000000 edi: 00000000 ebp: ce3a5a1c esp: c02d9ea0
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0 stackpage=c02d90000)
Stack: c02345e7 00000000 fffffffd cf9e4384 00000000 cf9e4320 00000018
00000000
       c14c5400 c1453800 00000000 c01fcd30 c1453800 cf8cebc0 c0234b82
ce3a5a1c
       cf9e4320 cf9e4384 cf9e4384 00000000 00018d52 cf9e4320 cf9e4320
c01f5998
Call Trace: [<c02345e7>] [<c01fcd30>] [<c0234b82>] [<c01f5958>] [<c01f5aa8>]
[<c011b9ec>] [<c010ac56>]
            [<c0118757>] [<c0118698>] [<c011859e>] [<c0107f38>] [<ef1342a0>]
[<c0106b88>] [<ef1342a0>] [<ef1342a0>]
            [<c01ebbcd>] [<c01eb98c>] [<c0105160>] [<c01051e4>] [<c0105000>]
[<c0100198>]
Code: 8b 11 f6 c2 e0 74 15 89 d0 25 e0 00 00 00 3d e0 00 00 00 74

>>EIP; c022e864 <addrconf_verify+54/c0>   <=====
Trace; c02345e7 <ndisc_send_ns+37/260>
Trace; c01fcd30 <ip_local_deliver_finish+0/178>
Trace; c0234b82 <ndisc_solicit+e2/f0>
Trace; c01f5958 <neigh_timer_handler+0/170>
Trace; c01f5aa8 <neigh_timer_handler+150/170>
Trace; c011b9ec <timer_bh+21c/258>
Trace; c010ac56 <timer_interrupt+86/104>
Trace; c0118757 <bh_action+1b/68>
Trace; c0118698 <tasklet_hi_action+3c/60>
Trace; c011859e <do_softirq+4e/74>
Trace; c0107f38 <do_IRQ+9c/ac>
Trace; ef1342a0 <END_OF_CODE+2ededdb0/????>
Trace; c0106b88 <ret_from_intr+0/20>
Trace; ef1342a0 <END_OF_CODE+2ededdb0/????>
Trace; ef1342a0 <END_OF_CODE+2ededdb0/????>
Trace; c01ebbcd <acpi_idle+241/26c>
Trace; c01eb98c <acpi_idle+0/26c>
Trace; c0105160 <default_idle+0/28>
Trace; c01051e4 <cpu_idle+3c/50>
Trace; c0105000 <init+0/150>
Trace; c0100198 <L6+0/2>
Code;  c022e864 <addrconf_verify+54/c0>
00000000 <_EIP>:
Code;  c022e864 <addrconf_verify+54/c0>   <=====
   0:   8b 11                     movl   (%ecx),%edx   <=====
Code;  c022e866 <addrconf_verify+56/c0>
   2:   f6 c2 e0                  testb  $0xe0,%dl
Code;  c022e869 <addrconf_verify+59/c0>
   5:   74 15                     je     1c <_EIP+0x1c> c022e880
<addrconf_verify+70/c0>
Code;  c022e86b <addrconf_verify+5b/c0>
   7:   89 d0                     movl   %edx,%eax
Code;  c022e86d <addrconf_verify+5d/c0>
   9:   25 e0 00 00 00            andl   $0xe0,%eax
Code;  c022e872 <addrconf_verify+62/c0>
   e:   3d e0 00 00 00            cmpl   $0xe0,%eax
Code;  c022e877 <addrconf_verify+67/c0>
  13:   74 00                     je     15 <_EIP+0x15> c022e879
<addrconf_verify+69/c0>

Kernel panic: Aiee, killing interrupt handler!

17 warnings issued.  Results may not be reliable.

Paul Rolland, rol@as2917.net

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur

"Some people dreams of success... while others wake up and work hard at it"



