Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbULYNBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbULYNBb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 08:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbULYNBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 08:01:31 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:5412 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261314AbULYNAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 08:00:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=AbXQ+SIaDaonGlB3Xf4xf/aXnlIS02Oj8m6PM6w2ClV53+XZ1veOJY6nWL/i0mjvoiu1qeTMD5vA8vXDfKLQwTCnVgNtr/0kjpsoMY3rMYSkJ0WaeZ9XouVpxtdReZuDra5tiClUnZKwaRLTDI6f+z7x/ShMWkV072Njf0CdHgc=
Message-ID: <9cdfa3e704122505002c0445aa@mail.gmail.com>
Date: Sat, 25 Dec 2004 14:00:16 +0100
From: Ioannis Fikouras <fikouras@gmail.com>
Reply-To: Ioannis Fikouras <fikouras@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Bug report
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_341_22910498.1103979616542"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_341_22910498.1103979616542
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[1.] One line summary of the problem: 
Kernel error message related to RAID5 and mldonkey

[2.] Full description of the problem/report:
I get this error message from the kernel shortly after stating
mldonkey. I run mldonkey on a RAID5 (3x250GB) with reiserfs. I had
similar issues witrh XFS. This error however does not seem to impact
the RAID, the FS or the apps runing on it (i.e. mldonkey, samba etc.)

[3.] Keywords (i.e., modules, networking, kernel):
RAID5, mldonkey?

[4.] Kernel version (from /proc/version):
2.6.10

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
Please find attached.

[6.] A small shell script or example program which triggers the
     problem (if possible)
For me its 100% reproducible. I just need to start mldonkey. Let me
know if I can help you out with more info. A remote login would be
possible.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Is attached

[7.2.] Processor information (from /proc/cpuinfo):
Is attached

[7.3.] Module information (from /proc/modules):
Is attached

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
Is attached

[7.5.] PCI information ('lspci -vvv' as root)
Is attached

[7.6.] SCSI information (from /proc/scsi/scsi)
No SCSI devices, funcionality only compiled as a module. Its not loaded.

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
/proc/mdstat is included

  Thanks a bunch, please let me know how I can help you any further.

------=_Part_341_22910498.1103979616542
Content-Type: text/plain; name="bug.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="bug.txt"


sh scripts/ver_linux
~~~~~~~~~~~~~~~~~~~~~~
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux babylon 2.6.10 #1 Sat Dec 25 13:48:14 CET 2004 i686 GNU/Linux
=20
Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15
util-linux             2.12
mount                  2.12
module-init-tools      3.1
e2fsprogs              1.35
reiserfsprogs          3.6.19
reiser4progs           line
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         ipt_TCPMSS iptable_filter ipt_MASQUERADE iptable_nat=
 ip_conntrack ip_tables af_packet nvidia_agp ehci_hcd ohci_hcd usbcore agpg=
art rtc unix



/var/log/mesages
~~~~~~~~~~~~~~~~~~~~~~
Dec 25 14:40:15 babylon kernel: ------------[ cut here ]------------
Dec 25 14:40:15 babylon kernel: PREEMPT=20
Dec 25 14:40:15 babylon kernel: Modules linked in: ipt_TCPMSS iptable_filte=
r ipt_MASQUERADE iptable_nat ip_conntrack ip_tables af_packet nvidia_agp eh=
ci_hcd ohci_hcd usbcore agpgart rtc unix
Dec 25 14:40:15 babylon kernel: CPU:    0
Dec 25 14:40:15 babylon kernel: EIP:    0060:[add_stripe_bio+337/384]    No=
t tainted VLI
Dec 25 14:40:15 babylon kernel: EFLAGS: 00010016   (2.6.10)=20
Dec 25 14:40:15 babylon kernel: EIP is at add_stripe_bio+0x151/0x180
Dec 25 14:40:15 babylon kernel: eax: 1dd1cf30   ebx: c15f7798   ecx: 1dd1cf=
08   edx: c721cee0
Dec 25 14:40:15 babylon kernel: esi: c721ce60   edi: 00000000   ebp: c721ce=
60   esp: d6589b0c
Dec 25 14:40:15 babylon kernel: ds: 007b   es: 007b   ss: 0068
Dec 25 14:40:15 babylon kernel: Process mlnet (pid: 2626, threadinfo=3Dd658=
8000 task=3Ddafc0ac0)
Dec 25 14:40:15 babylon kernel: Stack: c15f76c0 d6588000 1dd1cf08 c721ce60 =
c02414fa c15f76c0 c721ce60 00000001=20
Dec 25 14:40:15 babylon kernel:        00000000 d6589b50 c15d7460 1dd1cf20 =
00000002 00000003 c15d7460 c15b49c0=20
Dec 25 14:40:15 babylon kernel:        00000001 00000002 c159c1b0 df558060 =
d6589b8c c721ce60 c020f0e7 c159c1b0=20
Dec 25 14:40:15 babylon kernel: Call Trace:
Dec 25 14:40:15 babylon kernel:  [make_request+314/624] make_request+0x13a/=
0x270
Dec 25 14:40:15 babylon kernel:  [generic_make_request+327/480] generic_mak=
e_request+0x147/0x1e0
Dec 25 14:40:15 babylon kernel:  [autoremove_wake_function+0/96] autoremove=
_wake_function+0x0/0x60
Dec 25 14:40:15 babylon kernel:  [autoremove_wake_function+0/96] autoremove=
_wake_function+0x0/0x60
Dec 25 14:40:15 babylon kernel:  [mempool_alloc+117/368] mempool_alloc+0x75=
/0x170
Dec 25 14:40:15 babylon kernel:  [autoremove_wake_function+0/96] autoremove=
_wake_function+0x0/0x60
Dec 25 14:40:15 babylon kernel:  [ip_local_deliver_finish+0/480] ip_local_d=
eliver_finish+0x0/0x1e0
Dec 25 14:40:15 babylon kernel:  [submit_bio+93/256] submit_bio+0x5d/0x100
Dec 25 14:40:15 babylon kernel:  [mpage_bio_submit+35/64] mpage_bio_submit+=
0x23/0x40
Dec 25 14:40:15 babylon kernel:  [do_mpage_readpage+386/944] do_mpage_readp=
age+0x182/0x3b0
Dec 25 14:40:15 babylon kernel:  [radix_tree_insert+226/256] radix_tree_ins=
ert+0xe2/0x100
Dec 25 14:40:15 babylon kernel:  [add_to_page_cache+104/176] add_to_page_ca=
che+0x68/0xb0
Dec 25 14:40:15 babylon kernel:  [mpage_readpages+288/336] mpage_readpages+=
0x120/0x150
Dec 25 14:40:15 babylon kernel:  [reiserfs_get_block+0/5296] reiserfs_get_b=
lock+0x0/0x14b0
Dec 25 14:40:15 babylon kernel:  [read_pages+299/320] read_pages+0x12b/0x14=
0
Dec 25 14:40:15 babylon kernel:  [reiserfs_get_block+0/5296] reiserfs_get_b=
lock+0x0/0x14b0
Dec 25 14:40:15 babylon kernel:  [__alloc_pages+464/880] __alloc_pages+0x1d=
0/0x370
Dec 25 14:40:15 babylon kernel:  [need_resched+39/50] need_resched+0x27/0x3=
2
Dec 25 14:40:15 babylon kernel:  [do_page_cache_readahead+260/400] do_page_=
cache_readahead+0x104/0x190
Dec 25 14:40:15 babylon kernel:  [page_cache_readahead+388/480] page_cache_=
readahead+0x184/0x1e0
Dec 25 14:40:15 babylon kernel:  [do_generic_mapping_read+313/1328] do_gene=
ric_mapping_read+0x139/0x530
Dec 25 14:40:15 babylon kernel:  [__generic_file_aio_read+501/560] __generi=
c_file_aio_read+0x1f5/0x230
Dec 25 14:40:15 babylon kernel:  [file_read_actor+0/224] file_read_actor+0x=
0/0xe0
Dec 25 14:40:15 babylon kernel:  [ip_rcv_finish+521/656] ip_rcv_finish+0x20=
9/0x290
Dec 25 14:40:15 babylon kernel:  [generic_file_read+186/224] generic_file_r=
ead+0xba/0xe0
Dec 25 14:40:15 babylon kernel:  [scheduler_tick+31/1120] scheduler_tick+0x=
1f/0x460
Dec 25 14:40:15 babylon kernel:  [update_process_times+70/96] update_proces=
s_times+0x46/0x60
Dec 25 14:40:15 babylon kernel:  [autoremove_wake_function+0/96] autoremove=
_wake_function+0x0/0x60
Dec 25 14:40:15 babylon kernel:  [timer_interrupt+85/256] timer_interrupt+0=
x55/0x100
Dec 25 14:40:15 babylon kernel:  [vfs_read+219/320] vfs_read+0xdb/0x140
Dec 25 14:40:15 babylon kernel:  [sys_read+81/128] sys_read+0x51/0x80
Dec 25 14:40:15 babylon kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Dec 25 14:40:15 babylon kernel: Code: c1 72 08 0f ba aa 84 00 00 00 02 5b 5=
e 5f 5d c3 e8 d5 3c 06 00 e9 70 ff ff ff e8 cb 3c 06 00 e9 58 ff ff ff 8b 1=
3 e9 17 ff ff ff <0f> 0b 2d 03 7c 26 2c c0 e9 f2 fe ff ff 89 f6 6b 44 24 1c=
 64 8b=20
Dec 25 14:40:15 babylon kernel:  <6>note: mlnet[2626] exited with preempt_c=
ount 2


------=_Part_341_22910498.1103979616542
Content-Type: text/plain; name="cpu.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="cpu.txt"

processor=09: 0
vendor_id=09: AuthenticAMD
cpu family=09: 6
model=09=09: 3
model name=09: AMD Duron(tm) processor
stepping=09: 1
cpu MHz=09=09: 801.890
cache size=09: 64 KB
fdiv_bug=09: no
hlt_bug=09=09: no
f00f_bug=09: no
coma_bug=09: no
fpu=09=09: yes
fpu_exception=09: yes
cpuid level=09: 1
wp=09=09: yes
flags=09=09: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 mmx fxsr pni syscall mmxext 3dnowext 3dnow
bogomips=09: 1581.05


------=_Part_341_22910498.1103979616542
Content-Type: text/plain; name="io.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="io.txt"

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c87ff : Video ROM
000cc000-000cd7ff : Adapter ROM
000ce000-000d13ff : Adapter ROM
000d2000-000d27ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-002a5b62 : Kernel code
  002a5b63-0034df3f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
e0000000-e1ffffff : 0000:00:00.0
e2000000-e3ffffff : PCI Bus #03
  e2000000-e3ffffff : 0000:03:00.0
    e2000000-e3ffffff : matroxfb FB
e4000000-e5ffffff : PCI Bus #02
  e5000000-e500007f : 0000:02:01.0
e6000000-e8ffffff : PCI Bus #03
  e6000000-e6003fff : 0000:03:00.0
    e6000000-e6003fff : matroxfb MMIO
  e7000000-e77fffff : 0000:03:00.0
e9000000-eaffffff : PCI Bus #01
  ea000000-ea000fff : 0000:01:08.1
    ea000000-ea000fff : ohci_hcd
  ea001000-ea0010ff : 0000:01:08.2
    ea001000-ea0010ff : ehci_hcd
  ea002000-ea002fff : 0000:01:08.0
    ea002000-ea002fff : ohci_hcd
  ea003000-ea0031ff : 0000:01:0b.0
eb003000-eb003fff : 0000:00:04.0
  eb003000-eb003fff : forcedeth
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved
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
0376-0376 : ide1
03c0-03df : vga+
  03c0-03df : matrox
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
a000-cfff : PCI Bus #01
  a000-a007 : 0000:01:09.0
    a000-a007 : ide2
  a400-a403 : 0000:01:09.0
    a402-a402 : ide2
  a800-a807 : 0000:01:09.0
    a800-a807 : ide3
  ac00-ac03 : 0000:01:09.0
    ac02-ac02 : ide3
  b000-b0ff : 0000:01:09.0
    b000-b007 : ide2
    b008-b00f : ide3
    b010-b0ff : HPT370
  b400-b407 : 0000:01:0b.0
  b800-b803 : 0000:01:0b.0
  bc00-bc07 : 0000:01:0b.0
  c000-c003 : 0000:01:0b.0
  c400-c40f : 0000:01:0b.0
d000-dfff : PCI Bus #02
  d000-d07f : 0000:02:01.0
    d000-d07f : 0000:02:01.0
e000-e01f : 0000:00:01.1
e400-e407 : 0000:00:04.0
  e400-e407 : forcedeth
f000-f00f : 0000:00:09.0
  f000-f007 : ide0
  f008-f00f : ide1

------=_Part_341_22910498.1103979616542
Content-Type: text/plain; name="md.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="md.txt"

Personalities : [raid5]=20
md0 : active raid5 hdg1[2] hde1[1] hdc1[0]
      488391680 blocks level 5, 128k chunk, algorithm 2 [3/3] [UUU]
     =20
unused devices: <none>

------=_Part_341_22910498.1103979616542
Content-Type: text/plain; name="mods.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="mods.txt"

ipt_TCPMSS 4352 1 - Live 0xe2bb8000
iptable_filter 3648 1 - Live 0xe2bb1000
ipt_MASQUERADE 3584 1 - Live 0xe2b52000
iptable_nat 27080 2 ipt_MASQUERADE, Live 0xe2be2000
ip_conntrack 46836 2 ipt_MASQUERADE,iptable_nat, Live 0xe2b93000
ip_tables 18880 4 ipt_TCPMSS,iptable_filter,ipt_MASQUERADE,iptable_nat, Liv=
e 0xe2b8d000
af_packet 22408 4 - Live 0xe2b86000
nvidia_agp 7708 1 - Live 0xe2b4a000
ehci_hcd 30980 0 - Live 0xe2b54000
ohci_hcd 18568 0 - Live 0xe2b44000
usbcore 119416 3 ehci_hcd,ohci_hcd, Live 0xe2b67000
agpgart 34344 1 nvidia_agp, Live 0xe2b3a000
rtc 12664 0 - Live 0xe083a000
unix 28724 14 - Live 0xe0831000

------=_Part_341_22910498.1103979616542
Content-Type: text/plain; name="mods.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="mods.txt"

ipt_TCPMSS 4352 1 - Live 0xe2bb8000
iptable_filter 3648 1 - Live 0xe2bb1000
ipt_MASQUERADE 3584 1 - Live 0xe2b52000
iptable_nat 27080 2 ipt_MASQUERADE, Live 0xe2be2000
ip_conntrack 46836 2 ipt_MASQUERADE,iptable_nat, Live 0xe2b93000
ip_tables 18880 4 ipt_TCPMSS,iptable_filter,ipt_MASQUERADE,iptable_nat, Liv=
e 0xe2b8d000
af_packet 22408 4 - Live 0xe2b86000
nvidia_agp 7708 1 - Live 0xe2b4a000
ehci_hcd 30980 0 - Live 0xe2b54000
ohci_hcd 18568 0 - Live 0xe2b44000
usbcore 119416 3 ehci_hcd,ohci_hcd, Live 0xe2b67000
agpgart 34344 1 nvidia_agp, Live 0xe2b3a000
rtc 12664 0 - Live 0xe083a000
unix 28724 14 - Live 0xe0831000

------=_Part_341_22910498.1103979616542
Content-Type: text/plain; name="pci.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pci.txt"

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version=
?) (rev a2)
=09Subsystem: Asustek Computer, Inc.: Unknown device 80ac
=09Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
=09Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
=09Latency: 0
=09Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D32M]
=09Capabilities: [40] AGP version 2.0
=09=09Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 6=
4bit- FW+ AGP3- Rate=3Dx1,x2,x4
=09=09Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- Rate=
=3Dx1
=09Capabilities: [60] #08 [2001]

0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (re=
v a2)
=09Subsystem: nVidia Corporation: Unknown device 0c17
=09Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
=09Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-

0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (re=
v a2)
=09Subsystem: nVidia Corporation: Unknown device 0c17
=09Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
=09Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-

0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (re=
v a2)
=09Subsystem: nVidia Corporation: Unknown device 0c17
=09Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
=09Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-

0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (re=
v a2)
=09Subsystem: nVidia Corporation: Unknown device 0c17
=09Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
=09Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-

0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (re=
v a2)
=09Subsystem: nVidia Corporation: Unknown device 0c17
=09Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
=09Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-

0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
=09Subsystem: Asustek Computer, Inc. A7N8X Mainboard
=09Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
=09Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
=09Latency: 0
=09Capabilities: [48] #08 [01e1]

0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
=09Subsystem: Asustek Computer, Inc.: Unknown device 0c11
=09Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
=09Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
=09Interrupt: pin A routed to IRQ 10
=09Region 0: I/O ports at e000 [size=3D32]
=09Capabilities: [44] Power Management version 2
=09=09Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D=
3cold+)
=09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Contr=
oller (rev a1)
=09Subsystem: Asustek Computer, Inc. A7N8X Mainboard onboard nForce2 Ethern=
et
=09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
=09Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
=09Latency: 0 (250ns min, 5000ns max)
=09Interrupt: pin A routed to IRQ 12
=09Region 0: Memory at eb003000 (32-bit, non-prefetchable) [size=3D4K]
=09Region 1: I/O ports at e400 [size=3D8]
=09Capabilities: [44] Power Management version 2
=09=09Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D=
3cold+)
=09=09Status: D0 PME-Enable+ DSel=3D0 DScale=3D0 PME-

0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (re=
v a3) (prog-if 00 [Normal decode])
=09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B-
=09Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
=09Latency: 0
=09Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D32
=09I/O behind bridge: 0000a000-0000cfff
=09Memory behind bridge: e9000000-eaffffff
=09Prefetchable memory behind bridge: fff00000-000fffff
=09BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-i=
f 8a [Master SecP PriP])
=09Subsystem: Asustek Computer, Inc.: Unknown device 0c11
=09Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
=09Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
=09Latency: 0 (750ns min, 250ns max)
=09Region 4: I/O ports at f000 [size=3D16]
=09Capabilities: [44] Power Management version 2
=09=09Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
=09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:0c.0 PCI bridge: nVidia Corporation nForce2 PCI Bridge (rev a3) (pr=
og-if 00 [Normal decode])
=09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B-
=09Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
=09Latency: 0
=09Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D32
=09I/O behind bridge: 0000d000-0000dfff
=09Memory behind bridge: e4000000-e5ffffff
=09Prefetchable memory behind bridge: fff00000-000fffff
=09BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev a2) (prog-if 0=
0 [Normal decode])
=09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B-
=09Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
=09Latency: 32
=09Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D32
=09I/O behind bridge: 0000f000-00000fff
=09Memory behind bridge: e6000000-e8ffffff
=09Prefetchable memory behind bridge: e2000000-e3ffffff
=09BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:01:08.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI=
])
=09Subsystem: NEC Corporation USB
=09Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
=09Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
=09Latency: 32 (250ns min, 10500ns max), Cache Line Size: 0x08 (32 bytes)
=09Interrupt: pin A routed to IRQ 11
=09Region 0: Memory at ea002000 (32-bit, non-prefetchable) [size=3D4K]
=09Capabilities: [40] Power Management version 2
=09=09Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D=
3cold-)
=09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:01:08.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI=
])
=09Subsystem: NEC Corporation USB
=09Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
=09Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
=09Latency: 32 (250ns min, 10500ns max), Cache Line Size: 0x08 (32 bytes)
=09Interrupt: pin B routed to IRQ 7
=09Region 0: Memory at ea000000 (32-bit, non-prefetchable) [size=3D4K]
=09Capabilities: [40] Power Management version 2
=09=09Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D=
3cold-)
=09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:01:08.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 20 [=
EHCI])
=09Subsystem: HaSoTec GmbH: Unknown device 2928
=09Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
=09Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
=09Latency: 32 (4000ns min, 8500ns max), Cache Line Size: 0x10 (64 bytes)
=09Interrupt: pin C routed to IRQ 3
=09Region 0: Memory at ea001000 (32-bit, non-prefetchable) [size=3D256]
=09Capabilities: [40] Power Management version 2
=09=09Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D=
3cold-)
=09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:01:09.0 Unknown mass storage controller: Triones Technologies, Inc. HP=
T366/368/370/370A/372 (rev 03)
=09Subsystem: Triones Technologies, Inc. HPT370 UDMA100
=09Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
=09Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
=09Latency: 120 (2000ns min, 2000ns max)
=09Interrupt: pin A routed to IRQ 10
=09Region 0: I/O ports at a000 [size=3D8]
=09Region 1: I/O ports at a400 [size=3D4]
=09Region 2: I/O ports at a800 [size=3D8]
=09Region 3: I/O ports at ac00 [size=3D4]
=09Region 4: I/O ports at b000 [size=3D256]

0000:01:0b.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technol=
ogy Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 01)
=09Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) Asus A7N8X
=09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
=09Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
=09Latency: 32, Cache Line Size: 0x08 (32 bytes)
=09Interrupt: pin A routed to IRQ 11
=09Region 0: I/O ports at b400 [size=3D8]
=09Region 1: I/O ports at b800 [size=3D4]
=09Region 2: I/O ports at bc00 [size=3D8]
=09Region 3: I/O ports at c000 [size=3D4]
=09Region 4: I/O ports at c400 [size=3D16]
=09Region 5: Memory at ea003000 (32-bit, non-prefetchable) [size=3D512]
=09Capabilities: [60] Power Management version 2
=09=09Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
=09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

0000:02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB Integrated Fa=
st Ethernet Controller [Tornado] (rev 40)
=09Subsystem: Asustek Computer, Inc. A7N8X Deluxe onboard 3C920B-EMB Integr=
ated Fast Ethernet Controller
=09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
=09Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
=09Latency: 32 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 bytes)
=09Interrupt: pin A routed to IRQ 5
=09Region 0: I/O ports at d000 [size=3D128]
=09Region 1: Memory at e5000000 (32-bit, non-prefetchable) [size=3D128]
=09Capabilities: [dc] Power Management version 2
=09=09Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D=
3cold+)
=09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

0000:03:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP =
(rev 82) (prog-if 00 [VGA])
=09Subsystem: Matrox Graphics, Inc. Millennium G450 Dual Head
=09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
=09Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
=09Latency: 32 (4000ns min, 8000ns max), Cache Line Size: 0x08 (32 bytes)
=09Interrupt: pin A routed to IRQ 7
=09Region 0: Memory at e2000000 (32-bit, prefetchable) [size=3D32M]
=09Region 1: Memory at e6000000 (32-bit, non-prefetchable) [size=3D16K]
=09Region 2: Memory at e7000000 (32-bit, non-prefetchable) [size=3D8M]
=09Capabilities: [dc] Power Management version 2
=09=09Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
=09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
=09Capabilities: [f0] AGP version 2.0
=09=09Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 6=
4bit- FW- AGP3- Rate=3Dx1,x2,x4
=09=09Command: RQ=3D32 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64bit- FW- Rate=
=3Dx1


------=_Part_341_22910498.1103979616542--
