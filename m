Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVC1BqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVC1BqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 20:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVC1BqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 20:46:09 -0500
Received: from web54008.mail.yahoo.com ([206.190.36.232]:54403 "HELO
	web54008.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261659AbVC1Boe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 20:44:34 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=kHgl1/BmXIL5nadt2BEX9AIB6mAkZMcyepckB0P/DZVrADZCqCE9gfcsgvOc8XkB1CxHXWMmi1fyQU60C5zTzY6helGeIjJM2o35tZfcJlyWTdUieUwIpzM3c5RfjhgHNu/NMiwup8B4KaJCziTMSL2oWIYegIJSmxknDAuz00M=  ;
Message-ID: <20050328014431.30361.qmail@web54008.mail.yahoo.com>
Date: Mon, 28 Mar 2005 02:44:31 +0100 (BST)
From: Iulian Surugiu <omikorn@yahoo.com>
Subject: Kernel bug when using quagga/zebra
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi I`m using fedora core 3 kernel (2.6.9-1.667). I
would like to mention first that this is not only the
first time i am encountering this error, however , for
the last 3 days i had had setup routers on different
distributions/kernels and quagga/zebra different
packages (source/binaries) and versions but i still
get the same behaviour.

Now by following the documentation you supplied in the
REPORTING-BUGS file here are your details:

1. Kernel panic (Oops) using zebra/quagga
2. This problem i encounter when I`m stopping the
zebra daemon.
3. Networking, zebra, quagga, bgpd, kernel, kernel
panic
4. Linux version 2.6.9-1.667
(bhcompile@tweety.build.redhat.com) (gcc version 3.4.2
20041017 (Red Hat 3.4.2-6.fc3)) #1 Tue Nov 2 14:41:25
EST 2004, Also encountered on debian too, and all
majority of 2.6.x kernels
5. Ooops message (ripped from syslog) 

Jul 25 05:05:02 localhost kernel: Unable to handle
kernel NULL pointer dereference at virtual address
00000000
Jul 25 05:05:02 localhost kernel:  printing eip:
Jul 25 05:05:02 localhost kernel: 022ec14e
Jul 25 05:05:02 localhost kernel: *pde = 00000000
Jul 25 05:05:02 localhost kernel: Oops: 0002 [#1]
Jul 25 05:05:02 localhost kernel: Modules linked in:
autofs4 i2c_dev i2c_core sunrpc md5 ipv6 dm_mod
8139too mii 3c59x ext3 jbd
Jul 25 05:05:02 localhost kernel: CPU:    0
Jul 25 05:05:02 localhost kernel: EIP:   
0060:[<022ec14e>]    Not tainted VLI
Jul 25 05:05:02 localhost kernel: EFLAGS: 00010246  
(2.6.9-1.667)
Jul 25 05:05:02 localhost kernel: EIP is at
fib_release_info+0x72/0xac
Jul 25 05:05:02 localhost kernel: eax: 00000000   ebx:
00000000   ecx: 11f884e4   edx: 11f88480
Jul 25 05:05:02 localhost kernel: esi: 11f884e8   edi:
00000000   ebp: 0e444340   esp: 10dfbc90
Jul 25 05:05:02 localhost kernel: ds: 007b   es: 007b 
 ss: 0068
Jul 25 05:05:02 localhost kernel: Process zebra (pid:
3315, threadinfo=10dfb000 task=11a9a6f0)
Jul 25 05:05:02 localhost kernel: Stack: 10cba1f0
117024c0 00000001 022ee86b 00000024 00000017 11ff4280
11f00580
Jul 25 05:05:02 localhost kernel:        008c74c2
11f00580 11e18810 11e18800 11ff4280 022ebb7c 11e18800
10970db8
Jul 25 05:05:02 localhost kernel:        10970d80
10970d80 02374788 022ebb2c 00000009 022b1f79 0000003c
00000002
Jul 25 05:05:02 localhost kernel: Call Trace:
Jul 25 05:05:02 localhost kernel:  [<022ee86b>]
fn_hash_delete+0x196/0x1c8
Jul 25 05:05:02 localhost kernel:  [<022ebb7c>]
inet_rtm_delroute+0x50/0x5c
Jul 25 05:05:02 localhost kernel:  [<022ebb2c>]
inet_rtm_delroute+0x0/0x5c
Jul 25 05:05:02 localhost kernel:  [<022b1f79>]
rtnetlink_rcv+0x225/0x313
Jul 25 05:05:02 localhost kernel:  [<022bce02>]
netlink_data_ready+0x14/0x43
Jul 25 05:05:02 localhost kernel:  [<022bc607>]
netlink_sendskb+0x52/0x6b
Jul 25 05:05:02 localhost kernel:  [<022bcc1e>]
netlink_sendmsg+0x252/0x261
Jul 25 05:05:02 localhost kernel:  [<022a1959>]
sock_sendmsg+0xdb/0xf7
Jul 25 05:05:02 localhost kernel:  [<022a1a90>]
sock_recvmsg+0xef/0x10c
Jul 25 05:05:02 localhost kernel:  [<0211cf5b>]
autoremove_wake_function+0x0/0x2d
Jul 25 05:05:02 localhost kernel:  [<0215e9d0>]
get_user_size+0x30/0x57
Jul 25 05:05:02 localhost kernel:  [<022a7176>]
verify_iovec+0x3e/0x71
Jul 25 05:05:02 localhost kernel:  [<022a300b>]
sys_sendmsg+0x143/0x191
Jul 25 05:05:02 localhost kernel:  [<0215e45f>]
rw_vm+0x3f7/0x482
Jul 25 05:05:02 localhost kernel:  [<0215ea20>]
put_user_size+0x29/0x2d
Jul 25 05:05:02 localhost kernel:  [<02170bc9>]
cp_new_stat64+0xf5/0x107
Jul 25 05:05:02 localhost kernel:  [<02151de2>]
follow_page_pfn+0xec/0xfd
Jul 25 05:05:02 localhost kernel:  [<0215e45f>]
rw_vm+0x3f7/0x482
Jul 25 05:05:02 localhost kernel:  [<022a3398>]
sys_socketcall+0x160/0x179
Jul 25 05:05:02 localhost kernel: Code: <3>Debug:
sleeping function called from invalid context at
include/linux/rwsem.h:43
Jul 25 05:05:02 localhost kernel:
in_atomic():0[expected: 0], irqs_disabled():1
Jul 25 05:05:02 localhost kernel:  [<0211c8b9>]
__might_sleep+0x7d/0x88
Jul 25 05:05:02 localhost kernel:  [<0215e27e>]
rw_vm+0x216/0x482
Jul 25 05:05:02 localhost kernel:  [<022ec123>]
fib_release_info+0x47/0xac
Jul 25 05:05:02 localhost kernel:  [<022ec123>]
fib_release_info+0x47/0xac
Jul 25 05:05:02 localhost kernel:  [<0215e9d0>]
get_user_size+0x30/0x57
Jul 25 05:05:02 localhost kernel:  [<022ec123>]
fib_release_info+0x47/0xac
Jul 25 05:05:02 localhost kernel:  [<0210682b>]
show_registers+0x109/0x15e
Jul 25 05:05:02 localhost kernel:  [<02106a2f>]
die+0x14a/0x241
Jul 25 05:05:02 localhost kernel:  [<0211937e>]
do_page_fault+0x0/0x511
Jul 25 05:05:02 localhost kernel:  [<0211937e>]
do_page_fault+0x0/0x511
Jul 25 05:05:02 localhost kernel:  [<02119733>]
do_page_fault+0x3b5/0x511
Jul 25 05:05:02 localhost kernel:  [<022ec14e>]
fib_release_info+0x72/0xac
Jul 25 05:05:02 localhost kernel:  [<0224fd89>]
cfq_set_request+0x33/0x6b
Jul 25 05:05:02 localhost kernel:  [<0211ba03>]
__wake_up+0x8d/0xf2
Jul 25 05:05:02 localhost kernel:  [<022bc91d>]
netlink_broadcast+0x1df/0x23b
Jul 25 05:05:02 localhost kernel:  [<0211937e>]
do_page_fault+0x0/0x511
Jul 25 05:05:02 localhost kernel:  [<022ec14e>]
fib_release_info+0x72/0xac
Jul 25 05:05:02 localhost kernel:  [<022ee86b>]
fn_hash_delete+0x196/0x1c8
Jul 25 05:05:02 localhost kernel:  [<022ebb7c>]
inet_rtm_delroute+0x50/0x5c
Jul 25 05:05:03 localhost kernel:  [<022ebb2c>]
inet_rtm_delroute+0x0/0x5c
Jul 25 05:05:03 localhost kernel:  [<022b1f79>]
rtnetlink_rcv+0x225/0x313
Jul 25 05:05:03 localhost kernel:  [<022bce02>]
netlink_data_ready+0x14/0x43
Jul 25 05:05:03 localhost kernel:  [<022bc607>]
netlink_sendskb+0x52/0x6b
Jul 25 05:05:03 localhost kernel:  [<022bcc1e>]
netlink_sendmsg+0x252/0x261
Jul 25 05:05:03 localhost zebra: zebra shutdown
succeeded
Jul 25 05:05:03 localhost kernel:  [<022a1959>]
sock_sendmsg+0xdb/0xf7
Jul 25 05:05:03 localhost kernel:  [<022a1a90>]
sock_recvmsg+0xef/0x10c
Jul 25 05:05:03 localhost kernel:  [<0211cf5b>]
autoremove_wake_function+0x0/0x2d
Jul 25 05:05:03 localhost kernel:  [<0215e9d0>]
get_user_size+0x30/0x57
Jul 25 05:05:03 localhost kernel:  [<022a7176>]
verify_iovec+0x3e/0x71
Jul 25 05:05:03 localhost kernel:  [<022a300b>]
sys_sendmsg+0x143/0x191
Jul 25 05:05:03 localhost kernel:  [<0215e45f>]
rw_vm+0x3f7/0x482
Jul 25 05:05:03 localhost kernel:  [<0215ea20>]
put_user_size+0x29/0x2d
Jul 25 05:05:03 localhost kernel:  [<02170bc9>]
cp_new_stat64+0xf5/0x107
Jul 25 05:05:03 localhost kernel:  [<02151de2>]
follow_page_pfn+0xec/0xfd
Jul 25 05:05:03 localhost kernel:  [<0215e45f>]
rw_vm+0x3f7/0x482
Jul 25 05:05:03 localhost kernel:  [<022a3398>]
sys_socketcall+0x160/0x179
Jul 25 05:05:03 localhost kernel:  Bad EIP value.
Jul 25 05:07:25 localhost zebra: zebra shutdown failed
Jul 25 05:07:30 localhost bgpd: bgpd shutdown
succeeded
6. service zebra stop, service zebra restart? :)
7. Linux software router acting also as a gateway for
about 200 computers (256/512 Kbps (CIR/MIR)) 
7.1. Gnu C                  3.4.2
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12a
mount                  2.12a
module-init-tools      3.1-pre5
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         iptable_filter autofs4 i2c_dev
i2c_core sunrpc md5 ipv6 iptable_nat ip_conntrack
ip_tables dm_mod 8139too mii 3c59x ext3 jbd

7.2. processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Celeron(R) CPU 2.00GHz
stepping        : 7
cpu MHz         : 1992.767
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
apic mtrr pge mca cmov pat pse36 clflush dts acpi mmx
fxsr sse sse2 ss ht tm pbe cid
bogomips        : 3932.16

Please notice that i encountered this error on a P3 @
700 Mhz and Athlon XP@ 2000 Ghz

7.3.iptable_filter 2753 0 - Live 0x1281d000
autofs4 24005 0 - Live 0x12902000
i2c_dev 10433 0 - Live 0x128ec000
i2c_core 22081 1 i2c_dev, Live 0x1290a000
sunrpc 160421 1 - Live 0x12982000
md5 4033 1 - Live 0x12882000
ipv6 232577 18 - Live 0x12948000
iptable_nat 23045 1 - Live 0x128fb000
ip_conntrack 40693 1 iptable_nat, Live 0x128f0000
ip_tables 16193 2 iptable_filter,iptable_nat, Live
0x12861000
dm_mod 54741 0 - Live 0x12873000
8139too 26305 0 - Live 0x1286b000
mii 4673 1 8139too, Live 0x12815000
3c59x 36585 0 - Live 0x1281f000
ext3 116809 1 - Live 0x12884000
jbd 74969 1 ext3, Live 0x1282b000

7.5.
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale)
Chipset Host Bridge (rev 11)
        Subsystem: Quantum Designs (H.K.) Inc: Unknown
device 5628
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d0000000 (32-bit,
prefetchable) [size=128M]
        Capabilities: [e4] Vendor Specific Information
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+
ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP-
GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale)
Chipset AGP Bridge (rev 11) (prog-if 00 [Normal
decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01,
sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: dc000000-ddffffff
        Prefetchable memory behind bridge:
d8000000-dbffffff
        Secondary status: 66Mhz+ FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort-
>Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev
82) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02,
sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: de000000-dfffffff
        Prefetchable memory behind bridge:
fff00000-000fffff
        Secondary status: 66Mhz- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort-
>Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DB/DBL
(ICH4/ICH4-L) LPC Interface Bridge (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DB (ICH4) IDE
Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Intel Corp.: Unknown device 24c2
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 4
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at f000 [size=16]
        Region 5: Memory at 10000000 (32-bit,
non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 02)
        Subsystem: Intel Corp.: Unknown device 24c2
        Control: I/O+ Mem- BusMaster- SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 7
        Region 4: I/O ports at 5000 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation
NV18 [GeForce4 MX 4000 AGP 8x] (rev c1) (prog-if 00
[VGA])
        Subsystem: Giga-byte Technology: Unknown
device 310a
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at dc000000 (32-bit,
non-prefetchable) [size=16M]
        Region 1: Memory at d8000000 (32-bit,
prefetchable) [size=64M]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA-
ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP-
GART64- 64bit- FW- Rate=<none>

02:0a.0 Ethernet controller: Realtek Semiconductor
Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd.
RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at c000 [size=256]
        Region 1: Memory at df000000 (32-bit,
non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

02:0d.0 Ethernet controller: 3Com Corporation 3c905
100BaseTX [Boomerang]
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at c400 [size=64]

7.6. None scsi devices on this computer

I guess it is important to mention the quagga version
currently installed, quagga-0.97.0-1(from FC3 RPM).

I also worked successfully using zebra/quagga on
redhats 9.0 default kernel and after that on its
kernel.x.x.x.rpm that i took from updates.redhat.com
with different versions/packages of quagga/zebra and
it worked great.




Best regards,

Surugiu Iulian

NOC supervisor and lead administrator and programmer

www.hyperactiv.ro

omikorn@yahoo.com

+40744204465




Send instant messages to your online friends http://uk.messenger.yahoo.com 
