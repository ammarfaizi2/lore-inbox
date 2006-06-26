Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWFZFwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWFZFwk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 01:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWFZFwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 01:52:40 -0400
Received: from neo-u2.ops-netman.net ([63.95.249.169]:23979 "EHLO
	neo-u2.ops-netman.net") by vger.kernel.org with ESMTP
	id S932264AbWFZFwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 01:52:39 -0400
Date: Mon, 26 Jun 2006 05:52:37 +0000 (GMT)
From: morrowc+kernel@ops-netman.net
X-X-Sender: morrowc@neo-u2.ops-netman.net
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: crashes of 2.4.31 kernel (oops included)
Message-ID: <Pine.LNX.4.61.0606260544000.10457@arb-h2.bcf-argzna.arg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From URL - http://kernel.org/pub/linux/docs/lkml/reporting-bugs.html

[1.] One line summary of the problem: kernel panic/oops system hangs
[2.] Full description of the problem/report:
After some random period of time (from 1 hour to several days) kernel 
receives an 'oops' and dies. Requires power cycle to recover. I've a few 
of the 'oops' output saved and converted with ksymoops if required 
(included one below) Error appear to be in the iptables 
connection_tracking  actually.

[3.] Keywords (i.e., modules, networking, kernel):
networking kernel oops
[4.] Kernel version (from /proc/version):
Linux version 2.4.31 (root@neo-u2.ops-netman.net) (gcc version 3.3.5 
(Debian 1:3.3.5-13)) #1 SMP Sun Mar 12 15:09:22 GMT 2006


[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)

Unable to handle kernel NULL pointer dereference at virtual address 
00000012
  printing eip:
c0122485
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0122485>]    Not tainted
EFLAGS: 00010006
eax: ca5e47a4   ebx: dc2f3704   ecx: 02932dff   edx: 0000000e
esi: 00000282   edi: 02932e00   ebp: c7a76000   esp: c7a77bf4
ds: 0018   es: 0018   ss: 0018
Process smtp (pid: 11743, stackpage=c7a77000)
Stack: 00000001 00000000 dc2f36c0 dc2f3704 f0b62cb1 dc2f3704 00000001 
e16e1042
        00000001 f0b63bf7 dc2f36c0 02932e00 cc7cab20 c7a77cdc dc2f36c0 
f0b65660
        f0b61dfe dc2f36c0 e16e102e 000005b6 00000000 00000000 00000000 
a9d690db
Call Trace:    [<f0b62cb1>] [<f0b63bf7>] [<f0b65660>] [<f0b61dfe>] 
[<c0231580>]
   [<c0201c74>] [<c0231580>] [<c0231580>] [<c020201b>] [<c0231580>] 
[<f0b64ec0>]
   [<c02313ad>] [<c0231580>] [<c01f85e4>] [<c01f873d>] [<c01f88b5>] 
[<c011ee36>]
   [<c010af16>] [<c010d5b8>] [<c0117e64>] [<c013fe2e>] [<c01f8427>] 
[<c018c3bc>]
   [<c0172a9c>] [<c012e030>] [<c018b2f5>] [<c012e030>] [<c017a0cd>] 
[<c0155bbd>]
   [<c015780c>] [<c012e1e7>] [<c012e030>] [<c013eb09>] [<c0108ebb>]

Code: 89 5a 04 89 13 89 43 04 89 18 c6 05 bc df 2a c0 01 56 9d 8b
  <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

neo-u2:/home/morrowc/work/oops# more output-ksymoops-06-25-01
ksymoops 2.4.9 on i686 2.4.31.  Options used
      -v /usr/src/linux-2.4.31/vmlinux (specified)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.31/ (default)
      -m /usr/src/linux-2.4.31/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 
00000012
c0122485
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0122485>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: ca5e47a4   ebx: dc2f3704   ecx: 02932dff   edx: 0000000e
esi: 00000282   edi: 02932e00   ebp: c7a76000   esp: c7a77bf4
ds: 0018   es: 0018   ss: 0018
Process smtp (pid: 11743, stackpage=c7a77000)
Stack: 00000001 00000000 dc2f36c0 dc2f3704 f0b62cb1 dc2f3704 00000001 
e16e1042
        00000001 f0b63bf7 dc2f36c0 02932e00 cc7cab20 c7a77cdc dc2f36c0 
f0b65660
        f0b61dfe dc2f36c0 e16e102e 000005b6 00000000 00000000 00000000 
a9d690db
Call Trace:    [<f0b62cb1>] [<f0b63bf7>] [<f0b65660>] [<f0b61dfe>] 
[<c0231580>]
   [<c0201c74>] [<c0231580>] [<c0231580>] [<c020201b>] [<c0231580>] 
[<f0b64ec0>]
   [<c02313ad>] [<c0231580>] [<c01f85e4>] [<c01f873d>] [<c01f88b5>] 
[<c011ee36>]
   [<c010af16>] [<c010d5b8>] [<c0117e64>] [<c013fe2e>] [<c01f8427>] 
[<c018c3bc>]
   [<c0172a9c>] [<c012e030>] [<c018b2f5>] [<c012e030>] [<c017a0cd>] 
[<c0155bbd>]
   [<c015780c>] [<c012e1e7>] [<c012e030>] [<c013eb09>] [<c0108ebb>]
Code: 89 5a 04 89 13 89 43 04 89 18 c6 05 bc df 2a c0 01 56 9d 8b


>>EIP; c0122485 <add_timer+55/110>   <=====

>>eax; ca5e47a4 <_end+a29c204/307f8ac0>
>>ebx; dc2f3704 <_end+1bfab164/307f8ac0>
>>ebp; c7a76000 <_end+772da60/307f8ac0>
>>esp; c7a77bf4 <_end+772f654/307f8ac0>

Trace; f0b62cb1 <[ip_conntrack]ip_ct_refresh+b1/c0>
Trace; f0b63bf7 <[ip_conntrack]tcp_packet+177/220>
Trace; f0b65660 <[ip_conntrack]ip_conntrack_protocol_tcp+0/40>
Trace; f0b61dfe <[ip_conntrack]ip_conntrack_in+fe/2b0>
Trace; c0231580 <ip_rcv_finish+0/23f>
Trace; c0201c74 <nf_iterate+54/a0>
Trace; c0231580 <ip_rcv_finish+0/23f>
Trace; c0231580 <ip_rcv_finish+0/23f>
Trace; c020201b <nf_hook_slow+cb/210>
Trace; c0231580 <ip_rcv_finish+0/23f>
Trace; f0b64ec0 <[ip_conntrack]ip_conntrack_in_ops+0/0>
Trace; c02313ad <ip_rcv+3dd/440>
Trace; c0231580 <ip_rcv_finish+0/23f>
Trace; c01f85e4 <netif_receive_skb+e4/1b0>
Trace; c01f873d <process_backlog+8d/130>
Trace; c01f88b5 <net_rx_action+d5/180>
Trace; c011ee36 <do_softirq+d6/e0>
Trace; c010af16 <do_IRQ+e6/f0>
Trace; c010d5b8 <call_do_IRQ+5/d>
Trace; c0117e64 <.text.lock.sched+57/1e3>
Trace; c013fe2e <__wait_on_buffer+5e/90>
Trace; c01f8427 <net_tx_action+57/130>
Trace; c018c3bc <reiserfs_prepare_for_journal+7c/a0>
Trace; c0172a9c <reiserfs_update_sd+cc/1c0>
Trace; c012e030 <file_read_actor+0/100>
Trace; c018b2f5 <journal_begin+25/30>
Trace; c012e030 <file_read_actor+0/100>
Trace; c017a0cd <reiserfs_dirty_inode+6d/e0>
Trace; c0155bbd <__mark_inode_dirty+bd/c0>
Trace; c015780c <update_atime+6c/70>
Trace; c012e1e7 <generic_file_read+b7/1b0>
Trace; c012e030 <file_read_actor+0/100>
Trace; c013eb09 <sys_read+99/110>
Trace; c0108ebb <system_call+33/38>

Code;  c0122485 <add_timer+55/110>
00000000 <_EIP>:
Code;  c0122485 <add_timer+55/110>   <=====
    0:   89 5a 04                  mov    %ebx,0x4(%edx)   <=====
Code;  c0122488 <add_timer+58/110>
    3:   89 13                     mov    %edx,(%ebx)
Code;  c012248a <add_timer+5a/110>
    5:   89 43 04                  mov    %eax,0x4(%ebx)
Code;  c012248d <add_timer+5d/110>
    8:   89 18                     mov    %ebx,(%eax)
Code;  c012248f <add_timer+5f/110>
    a:   c6 05 bc df 2a c0 01      movb   $0x1,0xc02adfbc
Code;  c0122496 <add_timer+66/110>
   11:   56                        push   %esi
Code;  c0122497 <add_timer+67/110>
   12:   9d                        popf
Code;  c0122498 <add_timer+68/110>
   13:   8b 00                     mov    (%eax),%eax

  <0>Kernel panic: Aiee, killing interrupt handler!


[6.] A small shell script or example program which triggers the
      problem (if possible)

N/A

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
s# sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux neo-u2.ops-netman.net 2.4.31 #1 SMP Sun Mar 12 15:09:22 GMT 2006 
i686 GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
util-linux             2.12p
mount                  2.12p
modutils               2.4.26
e2fsprogs              1.37
PPP                    2.4.3
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         sd_mod scsi_mod ipt_LOG ipt_REJECT ipt_state 
ip_conntrack iptable_filter ip_tables ip6t_LOG ip6table_filter ip6_tables

[7.2.] Processor information (from /proc/cpuinfo):
# cat /proc/version
Linux version 2.4.31 (root@neo-u2.ops-netman.net) (gcc version 3.3.5 
(Debian 1:3.3.5-13)) #1 SMP Sun Mar 12 15:09:22 GMT 2006
You have new mail in /var/mail/morrowc
neo-u2:/home/morrowc/work/oops# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 596.009
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
bogomips        : 1189.47

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 596.009
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
bogomips        : 1189.47


[7.3.] Module information (from /proc/modules):
# cat /proc/modules
sd_mod                 10860   0 (autoclean) (unused)
scsi_mod               91636   1 (autoclean) [sd_mod]
ipt_LOG                 3544   1 (autoclean)
ipt_REJECT              3384   1 (autoclean)
ipt_state                536   2 (autoclean)
ip_conntrack           22432   0 (autoclean) [ipt_state]
iptable_filter          1740   1 (autoclean)
ip_tables              12960   4 [ipt_LOG ipt_REJECT ipt_state 
iptable_filter]
ip6t_LOG                4312   1 (autoclean)
ip6table_filter         1836   1 (autoclean)
ip6_tables             13600   2 [ip6t_LOG ip6table_filter]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0400-043f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
0440-045f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
d000-dfff : PCI Bus #02
   df00-df3f : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#3)
     df00-df3f : eepro100
ee80-eebf : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
   ee80-eebf : eepro100
ef00-ef3f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
   ef00-ef3f : eepro100
ef80-ef9f : Intel Corp. 82371AB/EB/MB PIIX4 USB
ffa0-ffaf : Intel Corp. 82371AB/EB/MB PIIX4 IDE
   ffa0-ffa7 : ide0
   ffa8-ffaf : ide1

# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c9800-000ca7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-2fffffff : System RAM
   00100000-0026e208 : Kernel code
   0026e209-002bebbf : Kernel data
fbd00000-fddfffff : PCI Bus #01
   fc000000-fcffffff : Chips and Technologies F69000 HiQVideo
fde00000-fe2fffff : PCI Bus #02
   fe100000-fe1fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#3)
   fe2ff000-fe2fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#3)
     fe2ff000-fe2fffff : eepro100
fe800000-fe8fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
fea00000-feafffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
febfe000-febfefff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
   febfe000-febfefff : eepro100
febff000-febfffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
   febff000-febfffff : eepro100
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ff000000-ff0fffff : PCI Bus #01
ff100000-ff1fffff : PCI Bus #02
ff400000-ff7fffff : Intel Corp. 440GX - 82443GX Host bridge
fffc0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

# lspci -vvv
0000:00:00.0 Host bridge: Intel Corp. 440GX - 82443GX Host bridge
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 64
         Region 0: Memory at ff400000 (32-bit, prefetchable) [size=4M]
         Capabilities: [a0] AGP version 1.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

0000:00:01.0 PCI bridge: Intel Corp. 440GX - 82443GX AGP bridge (prog-if 
00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         I/O behind bridge: 0000c000-0000cfff
         Memory behind bridge: fbd00000-fddfffff
         Prefetchable memory behind bridge: ff000000-ff0fffff
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

0000:00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

0000:00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Region 4: I/O ports at ffa0 [size=16]

0000:00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Interrupt: pin D routed to IRQ 0
         Region 4: I/O ports at ef80 [size=32]

0000:00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin ? routed to IRQ 9

0000:00:11.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
         Subsystem: Intel Corp. 82559 Fast Ethernet LAN on Motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 
bytes)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at febff000 (32-bit, non-prefetchable) [size=4K]
         Region 1: I/O ports at ef00 [size=64]
         Region 2: Memory at fea00000 (32-bit, non-prefetchable) [size=1M]
         Expansion ROM at fe900000 [disabled] [size=1M]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:00:12.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
         Subsystem: Intel Corp. 82559 Fast Ethernet LAN on Motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 
bytes)
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at febfe000 (32-bit, non-prefetchable) [size=4K]
         Region 1: I/O ports at ee80 [size=64]
         Region 2: Memory at fe800000 (32-bit, non-prefetchable) [size=1M]
         Expansion ROM at fe700000 [disabled] [size=1M]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:00:14.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 
03) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, Cache Line Size: 0x08 (32 bytes)
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: fde00000-fe2fffff
         Prefetchable memory behind bridge: 
00000000ff100000-00000000ff100000
         BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                 Bridge: PM- B3+

0000:01:00.0 VGA compatible controller: Chips and Technologies F69000 
HiQVideo (rev 64) (prog-if 00 [VGA])
         Subsystem: Chips and Technologies F69000 HiQVideo
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 0
         Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
         Expansion ROM at fddc0000 [disabled] [size=256K]

0000:02:0e.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
         Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 
bytes)
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at fe2ff000 (32-bit, non-prefetchable) [size=4K]
         Region 1: I/O ports at df00 [size=64]
         Region 2: Memory at fe100000 (32-bit, non-prefetchable) [size=1M]
         Expansion ROM at fe000000 [disabled] [size=1M]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

# cat /proc/scsi/scsi
Attached devices: none


[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):
[X.] Other notes, patches, fixes, workarounds:


If more info is required I believe I can provide it if requested. Thanks!
