Return-Path: <linux-kernel-owner+w=401wt.eu-S1030348AbWLTTXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWLTTXn (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbWLTTXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:23:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:16286 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030348AbWLTTXi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:23:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XheMK5ICt5VAQz2rE4TBgGZ6kiw/6WpLD2GQ1Umgk4BYjSIpjSShLOAnE+QrpRrJhDtM5H7c79PXTqmEpf98kP5Ebl3MYc64pQbcWBE0MbcOGEVH0ysjMyMCXNzHx+9Yhqrnwa0e9hqC3ImsPvamVpfBaowLA/VdyqPiGnXqHPc=
Message-ID: <5c783d910612201123n386a3e77se72cdab80e3cd395@mail.gmail.com>
Date: Wed, 20 Dec 2006 17:23:35 -0200
From: "Martin Alain Kretschek" <martinalain@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: NFS client
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Program stops responding even to kill -9 due to NFS errors. Causes
CPU high load.

2. Program stops responding even to kill -9 due to NFS errors. Causes
CPU high load. Other two equal (HW + OS) servers connected to the same
server still work well. The server do not obey telinit 0. Hard
shutdown (push the power button. Dell 1850 does not show any error
status led.

3. NFS, kernel

4.Linux version 2.6.16.1-1-p4-smp-llatdesktop (root@russell3) (gcc
version 3.3.5 (Debian 1:3.3.5-13)) #1 SMP PREEMPT Thu Apr 6 12:03:29
BRT 2006

5.Dec 18 22:41:57 russell kernel: ------------[ cut here ]------------
Dec 18 22:41:57 russell kernel: kernel BUG at \224^QÀ:60907!
Dec 18 22:41:57 russell kernel: invalid opcode: 0000 [#1]
Dec 18 22:41:57 russell kernel: PREEMPT SMP
Dec 18 22:41:57 russell kernel: Modules linked in: isofs appletalk
ax25 ipx p8023 nfs nfsd lockd sunrpc ipt_REJECT ipt_LOG xt_state
ip_conntrack xt_tcpudp iptable_filter ip_tables x_tables af_packet
autofs4 ipv6 generic piix ide_generic xfs exportfs ext2 ext3 jbd
mbcache megaraid usbmouse usbkbd radeon drm agpgart nbd parport_pc lp
parport floppy rtc pcspkr tsdev shpchp pci_hotplug usbhid ehci_hcd
uhci_hcd usbcore e1000 dm_mod psmouse mousedev ide_disk ide_cd cdrom
ide_core tg3 unix megaraid_mbox megaraid_mm sd_mod scsi_mod
Dec 18 22:41:57 russell kernel: CPU:    2
Dec 18 22:41:57 russell kernel: EIP:
0060:[radix_tree_tag_set+106/114]    Not tainted VLI
Dec 18 22:41:57 russell kernel: EFLAGS: 00210046
(2.6.16.1-1-p4-smp-llatdesktop #1)
Dec 18 22:41:57 russell kernel: EIP is at radix_tree_tag_set+0x6a/0x72
Dec 18 22:41:57 russell kernel: eax: 00000000   ebx: 00000001   ecx:
f1be04ec   edx: 00000002
Dec 18 22:41:57 russell kernel: esi: 00000000   edi: 00000000   ebp:
00000008   esp: ebfa7e78
Dec 18 22:41:57 russell kernel: ds: 007b   es: 007b   ss: 0068
Dec 18 22:41:57 russell kernel: Process gaim (pid: 21320,
threadinfo=ebfa6000 task=d3a38a90)
Dec 18 22:41:57 russell kernel: Stack: <0>c23e4820 d48eae94 00000000
d48eaea4 c01468e3 d48eae98 00000002 00000001
Dec 18 22:41:57 russell kernel:        00200213 eb567ccc eb567d18
c6485c00 eb567b80 f9601e3e c23e4820 00000050
Dec 18 22:41:57 russell kernel:        00000008 d71ae6cc 00000000
00000002 00000000 00000004 ebfa7ef4 00000001
Dec 18 22:41:57 russell kernel: Call Trace:
Dec 18 22:41:57 russell kernel:  [test_set_page_writeback+119/273]
test_set_page_writeback+0x77/0x111
Dec 18 22:41:57 russell kernel:  [pg0+958815806/1069949952]
nfs_flush_one+0xf8/0x1f6 [nfs]
Dec 18 22:41:57 russell kernel:  [pg0+958816150/1069949952]
nfs_flush_list+0x5a/0xa8 [nfs]
Dec 18 22:41:57 russell kernel:  [pg0+958818766/1069949952]
nfs_flush_inode+0x8f/0xc8 [nfs]
Dec 18 22:41:57 russell kernel:  [pg0+958819057/1069949952]
nfs_sync_inode+0x64/0x7e [nfs]
Dec 18 22:41:57 russell kernel:  [pg0+958774017/1069949952]
nfs_file_flush+0x64/0xc5 [nfs]
Dec 18 22:41:57 russell kernel:  [filp_close+101/121] filp_close+0x65/0x79
Dec 18 22:41:57 russell kernel:  [sys_close+115/149] sys_close+0x73/0x95
Dec 18 22:41:57 russell kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Dec 18 22:41:57 russell kernel: Code: 0f a3 91 04 01 00 00 19 c0 85 c0
75 07 0f ab 91 04 01 00 00 8b 74 96 04 85 f6 74 0f 83 ef 06 83 eb 01
75 cd 89 f0 5b 5e 5f 5d c3 <0f> 0b eb ed 31 c0 eb f3 55 31 ed 57 56 53
83 ec 44 8b 4c 24 58
Dec 18 22:41:57 russell kernel:  <6>note: gaim[21320] exited with
preempt_count 1
Dec 18 22:41:57 russell kernel: scheduling while atomic: gaim/0x00000001/21320
Dec 18 22:41:57 russell kernel:  [schedule+1868/1873] schedule+0x74c/0x751
Dec 18 22:41:57 russell kernel:  [pg0+949476029/1069949952]
xs_tcp_send_request+0x11d/0x3a1 [sunrpc]
Dec 18 22:41:57 russell kernel:  [pg0+949483418/1069949952]
rpc_wait_bit_interruptible+0x1d/0x22 [sunrpc]
Dec 18 22:41:57 russell kernel:  [__wait_on_bit+86/95] __wait_on_bit+0x56/0x5f
Dec 18 22:41:57 russell kernel:  [pg0+949483389/1069949952]
rpc_wait_bit_interruptible+0x0/0x22 [sunrpc]
Dec 18 22:41:57 russell kernel:  [pg0+949483389/1069949952]
rpc_wait_bit_interruptible+0x0/0x22 [sunrpc]
Dec 18 22:41:57 russell kernel:  [out_of_line_wait_on_bit+145/153]
out_of_line_wait_on_bit+0x91/0x99
Dec 18 22:41:57 russell kernel:  [wake_bit_function+0/85]
wake_bit_function+0x0/0x55
Dec 18 22:41:57 russell kernel:  [wake_bit_function+0/85]
wake_bit_function+0x0/0x55
Dec 18 22:41:57 russell kernel:  [pg0+949465401/1069949952]
call_transmit+0x67/0xce [sunrpc]
Dec 18 22:41:57 russell kernel:  [pg0+949485451/1069949952]
__rpc_execute+0xb6/0x1de [sunrpc]
Dec 18 22:41:57 russell kernel:  [pg0+949463166/1069949952]
rpc_call_sync+0xb8/0xd1 [sunrpc]
Dec 18 22:41:57 russell kernel:  [pg0+958819386/1069949952]
nfs3_rpc_wrapper+0x3a/0x7a [nfs]
Dec 18 22:41:57 russell kernel:  [pg0+958820068/1069949952]
nfs3_proc_getattr+0x7d/0xb4 [nfs]
Dec 18 22:41:57 russell kernel:  [pg0+958783754/1069949952]
__nfs_revalidate_inode+0xc6/0x279 [nfs]
Dec 18 22:41:57 russell kernel:  [radix_tree_gang_lookup_tag+86/112]
radix_tree_gang_lookup_tag+0x56/0x70
Dec 18 22:41:57 russell kernel:  [_spin_unlock+13/33] _spin_unlock+0xd/0x21
Dec 18 22:41:57 russell kernel:  [pg0+958818905/1069949952]
nfs_commit_inode+0x52/0x86 [nfs]
Dec 18 22:41:57 russell kernel:  [pg0+958819081/1069949952]
nfs_sync_inode+0x7c/0x7e [nfs]
Dec 18 22:41:57 russell kernel:  [pg0+958774073/1069949952]
nfs_file_flush+0x9c/0xc5 [nfs]
Dec 18 22:41:57 russell kernel:  [filp_close+101/121] filp_close+0x65/0x79
Dec 18 22:41:57 russell kernel:  [close_files+126/136] close_files+0x7e/0x88
Dec 18 22:41:57 russell kernel:  [put_files_struct+43/85]
put_files_struct+0x2b/0x55
Dec 18 22:41:57 russell kernel:  [_spin_lock+22/139] _spin_lock+0x16/0x8b
Dec 18 22:41:57 russell kernel:  [do_exit+315/1096] do_exit+0x13b/0x448
Dec 18 22:41:57 russell kernel:  [do_trap+0/264] do_trap+0x0/0x108
Dec 18 22:41:57 russell kernel:  [do_invalid_op+0/195] do_invalid_op+0x0/0xc3
Dec 18 22:41:57 russell kernel:  [do_invalid_op+174/195] do_invalid_op+0xae/0xc3
Dec 18 22:41:57 russell kernel:  [radix_tree_tag_set+106/114]
radix_tree_tag_set+0x6a/0x72
Dec 18 22:41:57 russell kernel:  [default_wake_function+0/18]
default_wake_function+0x0/0x12
Dec 18 22:41:57 russell kernel:  [__sched_text_start+7/12] __down_failed+0x7/0xc
Dec 18 22:41:57 russell kernel:  [__reacquire_kernel_lock+62/82]
__reacquire_kernel_lock+0x3e/0x52
Dec 18 22:41:57 russell kernel:  [schedule+1031/1873] schedule+0x407/0x751
Dec 18 22:41:57 russell kernel:  [pg0+949468496/1069949952]
__xprt_lock_write_next+0x5d/0x71 [sunrpc]
Dec 18 22:41:57 russell kernel:  [error_code+79/84] error_code+0x4f/0x54
Dec 18 22:41:57 russell kernel:  [radix_tree_tag_set+106/114]
radix_tree_tag_set+0x6a/0x72
Dec 18 22:41:57 russell kernel:  [test_set_page_writeback+119/273]
test_set_page_writeback+0x77/0x111
Dec 18 22:41:57 russell kernel:  [pg0+958815806/1069949952]
nfs_flush_one+0xf8/0x1f6 [nfs]
Dec 18 22:41:57 russell kernel:  [pg0+958816150/1069949952]
nfs_flush_list+0x5a/0xa8 [nfs]
Dec 18 22:41:57 russell kernel:  [pg0+958818766/1069949952]
nfs_flush_inode+0x8f/0xc8 [nfs]
Dec 18 22:41:57 russell kernel:  [pg0+958819057/1069949952]
nfs_sync_inode+0x64/0x7e [nfs]
Dec 18 22:41:57 russell kernel:  [pg0+958774017/1069949952]
nfs_file_flush+0x64/0xc5 [nfs]
Dec 18 22:41:57 russell kernel:  [filp_close+101/121] filp_close+0x65/0x79
Dec 18 22:41:57 russell kernel:  [sys_close+115/149] sys_close+0x73/0x95
Dec 18 22:41:57 russell kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

6. gaim           1.2.1-1.4      multi-protocol instant messaging client

7.
7.1 # sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux russell 2.6.16.1-1-p4-smp-llatdesktop #1 SMP PREEMPT Thu Apr 6
12:03:29 BRT 2006 i686 GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.6.20
quota-tools            3.12.
PPP                    2.4.3
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   056
Modules Loaded         nfs nfsd lockd sunrpc ipt_REJECT ipt_LOG
xt_state ip_conntrack xt_tcpudp iptable_filter ip_tables x_tables
af_packet autofs4 ipv6 generic piix ide_generic xfs exportfs ext2 ext3
jbd mbcache megaraid usbmouse usbkbd radeon drm agpgart nbd parport_pc
lp parport floppy rtc pcspkr tsdev shpchp pci_hotplug usbhid ehci_hcd
uhci_hcd usbcore e1000 dm_mod psmouse mousedev ide_disk ide_cd cdrom
ide_core tg3 unix megaraid_mbox megaraid_mm sd_mod scsi_mod

7.2 # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.80GHz
stepping        : 3
cpu MHz         : 3790.651
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx
lm constant_tsc pni monitor ds_cpl est tm2 cid cx16 xtpr
bogomips        : 7587.57

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.80GHz
stepping        : 3
cpu MHz         : 3790.651
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx
lm constant_tsc pni monitor ds_cpl est tm2 cid cx16 xtpr
bogomips        : 7581.17


processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.80GHz
stepping        : 3
cpu MHz         : 3790.651
cache size      : 2048 KB
physical id     : 3
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx
lm constant_tsc pni monitor ds_cpl est tm2 cid cx16 xtpr
bogomips        : 7581.18

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.80GHz
stepping        : 3
cpu MHz         : 3790.651
cache size      : 2048 KB
physical id     : 3
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx
lm constant_tsc pni monitor ds_cpl est tm2 cid cx16 xtpr
bogomips        : 7581.26

7.3 # cat /proc/modules
nfs 234188 1 - Live 0xf95f5000
nfsd 228484 8 - Live 0xf8d77000
lockd 66824 3 nfs,nfsd, Live 0xf8b4d000
sunrpc 158012 4 nfs,nfsd,lockd, Live 0xf8d16000
ipt_REJECT 6784 1 - Live 0xf8a91000
ipt_LOG 8320 2 - Live 0xf8ada000
xt_state 3200 42 - Live 0xf8ad4000
ip_conntrack 54360 1 xt_state, Live 0xf8ae5000
xt_tcpudp 4736 80 - Live 0xf8ad1000
iptable_filter 4096 1 - Live 0xf8a1a000
ip_tables 17012 1 iptable_filter, Live 0xf8ab9000
x_tables 15620 5 ipt_REJECT,ipt_LOG,xt_state,xt_tcpudp,ip_tables, Live
0xf8a8c000
af_packet 25096 0 - Live 0xf8a84000
autofs4 21508 2 - Live 0xf8a7d000
ipv6 273376 45 - Live 0xf8b09000
generic 5892 0 [permanent], Live 0xf8a11000
piix 12036 0 [permanent], Live 0xf8a04000
ide_generic 2560 0 [permanent], Live 0xf88cf000
xfs 619060 7 - Live 0xf8b62000
exportfs 7040 2 nfsd,xfs, Live 0xf896a000
ext2 71176 0 - Live 0xf8a6a000
ext3 146312 1 - Live 0xf8a94000
jbd 64916 1 ext3, Live 0xf8a30000
mbcache 10244 2 ext2,ext3, Live 0xf8966000
megaraid 43976 0 - Live 0xf89a9000
usbmouse 7040 0 - Live 0xf8963000
usbkbd 8576 0 - Live 0xf8905000
radeon 112416 0 - Live 0xf8a4d000
drm 75796 1 radeon, Live 0xf8a1c000
agpgart 37604 1 drm, Live 0xf89b5000
nbd 25120 0 - Live 0xf89a1000
parport_pc 37956 0 - Live 0xf892e000
lp 12804 0 - Live 0xf8900000
parport 40008 2 parport_pc,lp, Live 0xf8958000
floppy 63492 0 - Live 0xf896d000
rtc 14900 0 - Live 0xf881c000
pcspkr 4740 0 - Live 0xf88cc000
tsdev 9024 0 - Live 0xf8891000
shpchp 49760 0 - Live 0xf88b2000
pci_hotplug 32068 1 shpchp, Live 0xf887c000
usbhid 40288 0 - Live 0xf8923000
ehci_hcd 35208 0 - Live 0xf8919000
uhci_hcd 35216 0 - Live 0xf88f6000
usbcore 135684 6 usbmouse,usbkbd,usbhid,ehci_hcd,uhci_hcd, Live 0xf89e1000
e1000 114228 0 - Live 0xf893b000
dm_mod 60568 7 - Live 0xf8909000
psmouse 42504 0 - Live 0xf88c0000
mousedev 13224 0 - Live 0xf8877000
ide_disk 19072 0 - Live 0xf8842000
ide_cd 44164 0 - Live 0xf8885000
cdrom 41632 1 ide_cd, Live 0xf882c000
ide_core 131920 5 generic,piix,ide_generic,ide_disk,ide_cd, Live 0xf88d4000
tg3 109444 0 - Live 0xf8896000
unix 30736 207 - Live 0xf886e000
megaraid_mbox 34704 4 - Live 0xf8838000
megaraid_mm 12964 1 megaraid_mbox, Live 0xf8827000
sd_mod 20224 5 - Live 0xf8821000
scsi_mod 148232 3 megaraid,megaraid_mbox,sd_mod, Live 0xf8848000

7.4 cat /proc/ioports  /proc/iomem
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
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0800-087f : 0000:00:1f.0
  0800-0803 : PM1a_EVT_BLK
  0804-0805 : PM1a_CNT_BLK
  0808-080b : PM_TMR
  0828-082f : GPE0_BLK
0880-08bf : 0000:00:1f.0
  0880-08bf : pnp 00:07
08c0-08df : pnp 00:07
08e0-08e3 : pnp 00:07
0c00-0c0f : pnp 00:07
0c10-0c1f : pnp 00:07
0ca0-0ca7 : pnp 00:07
0ca8-0ca8 : pnp 00:08
0ca9-0cab : pnp 00:07
0cac-0cac : pnp 00:08
bca0-bcbf : 0000:00:1d.2
  bca0-bcbf : uhci_hcd
bcc0-bcdf : 0000:00:1d.1
  bcc0-bcdf : uhci_hcd
bce0-bcff : 0000:00:1d.0
  bce0-bcff : uhci_hcd
c000-cfff : PCI Bus #09
  cc00-ccff : 0000:09:0d.0
d000-efff : PCI Bus #05
  d000-dfff : PCI Bus #07
    dcc0-dcff : 0000:07:08.0
      dcc0-dcff : e1000
  e000-efff : PCI Bus #06
    ecc0-ecff : 0000:06:07.0
      ecc0-ecff : e1000
fc00-fc0f : 0000:00:1f.1
  fc08-fc0f : ide1
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cb000-000cbfff : Adapter ROM
000cc000-000ccfff : Adapter ROM
000cd000-000cf1ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-dffbffff : System RAM
  00100000-002a13b4 : Kernel code
  002a13b5-00337083 : Kernel data
dffc0000-dffcfbff : ACPI Tables
dffcfc00-dfffefff : reserved
e0000000-efffffff : reserved
f0000000-f7ffffff : PCI Bus #09
  f0000000-f7ffffff : 0000:09:0d.0
f8000000-f80fffff : PCI Bus #01
  f8000000-f80fffff : PCI Bus #02
    f80f0000-f80fffff : 0000:02:0e.0
      f80f0000-f80fffff : MegaRAID: LSI Logic Corporation
f8100000-f81003ff : 0000:00:1f.1
fe100000-fe2fffff : PCI Bus #09
  fe100000-fe11ffff : 0000:09:0d.0
  fe1f0000-fe1fffff : 0000:09:0d.0
fe300000-fe7fffff : PCI Bus #05
  fe400000-fe5fffff : PCI Bus #07
    fe4e0000-fe4fffff : 0000:07:08.0
      fe4e0000-fe4fffff : e1000
  fe600000-fe7fffff : PCI Bus #06
    fe6e0000-fe6fffff : 0000:06:07.0
      fe6e0000-fe6fffff : e1000
fe800000-feafffff : PCI Bus #01
  fe900000-feafffff : PCI Bus #02
    fe9e0000-fe9fffff : 0000:02:0e.0
      fe9e0000-fe9fffff : MegaRAID: LSI Logic Corporation
    fea00000-fea1ffff : 0000:02:0e.0
feb00000-feb003ff : 0000:00:1d.7
  feb00000-feb003ff : ehci_hcd
fec00000-fec8ffff : reserved
fed00000-fed003ff : reserved
fee00000-fee0ffff : reserved
ffb00000-ffffffff : reserved

7.5 # lspci -vvv
0000:00:00.0 Host bridge: Intel Corp. Server Memory Controller Hub (rev 09)
        Subsystem: Dell: Unknown device 016c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [40] #09 [4105]

0000:00:02.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express
Port A0 (rev 09) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fe800000-feafffff
        Prefetchable memory behind bridge: 00000000f8000000-00000000f8000000
        Secondary status: SERR
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit-
Queue=0/1 Enable-
                Address: fee00000  Data: 0000
        Capabilities: [64] #10 [0041]

0000:00:04.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express
Port B0 (rev 09) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit-
Queue=0/1 Enable-
                Address: fee00000  Data: 0000
        Capabilities: [64] #10 [0041]

0000:00:05.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express
Port B1 (rev 09) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=00, secondary=05, subordinate=07, sec-latency=0
        I/O behind bridge: 0000d000-0000efff
        Memory behind bridge: fe300000-fe7fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        Secondary status: SERR
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit-
Queue=0/1 Enable-
                Address: fee00000  Data: 0000
        Capabilities: [64] #10 [0041]

0000:00:06.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express
Port C0 (rev 09) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit-
Queue=0/1 Enable-
                Address: fee00000  Data: 0000
        Capabilities: [64] #10 [0041]

0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB
UHCI #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 016c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 169
        Region 4: I/O ports at bce0 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB
UHCI #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 016c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 201
        Region 4: I/O ports at bcc0 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB
UHCI #3 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 016c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 209
        Region 4: I/O ports at bca0 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2
EHCI Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Dell: Unknown device 016c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 217
        Region 0: Memory at feb00000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=09, subordinate=09, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fe100000-fe2fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra
ATA 100 Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Dell: Unknown device 016c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at fc00 [size=16]
        Region 5: Memory at f8100000 (32-bit, non-prefetchable) [size=1K]

0000:01:00.0 PCI bridge: Intel Corp. 80332 [Dobson] I/O processor (rev
06) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fe900000-feafffff
        Prefetchable memory behind bridge: 00000000f8000000-00000000f8000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [44] #10 [0071]
        Capabilities: [5c] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d8]
0000:01:00.2 PCI bridge: Intel Corp. 80332 [Dobson] I/O processor (rev
06) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=01, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [44] #10 [0071]
        Capabilities: [5c] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d8]
0000:02:0e.0 RAID bus controller: Dell PowerEdge Expandable RAID
controller 4 (rev 06)
        Subsystem: Dell PowerEdge Expandable RAID Controller 4e/Si
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping+ SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (32000ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at f80f0000 (32-bit, prefetchable) [size=64K]
        Region 2: Memory at fe9e0000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at fea00000 [disabled] [size=128K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d0] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=3
                Status: Bus=2 Dev=14 Func=0 64bit+ 133MHz+ SCD- USC-,
DC=bridge, DMMRBC=1, DMOST=3, DMCRS=1, RSCEM-

0000:05:00.0 PCI bridge: Intel Corp. PCI Bridge Hub A (rev 09)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=05, secondary=06, subordinate=06, sec-latency=32
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fe600000-fe7fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [44] #10 [0071]
        Capabilities: [5c] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d8]
0000:05:00.2 PCI bridge: Intel Corp. PCI Bridge Hub B (rev 09)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=05, secondary=07, subordinate=07, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fe400000-fe5fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [44] #10 [0071]
        Capabilities: [5c] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d8]
0000:06:07.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit
Ethernet Controller (rev 05)
        Subsystem: Dell: Unknown device 016d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 185
        Region 0: Memory at fe6e0000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at ecc0 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=2, DMOST=0, DMCRS=0, RSCEM-

0000:07:08.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit
Ethernet Controller (rev 05)
        Subsystem: Dell: Unknown device 016d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 193
        Region 0: Memory at fe4e0000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at dcc0 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=2, DMOST=0, DMCRS=0, RSCEM-

0000:09:0d.0 VGA compatible controller: ATI Technologies Inc Radeon
RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA])
        Subsystem: Dell: Unknown device 016c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+
ParErr- Stepping+ SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 209
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at cc00 [size=256]
        Region 2: Memory at fe1f0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at fe100000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

7.6 # cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: PE/PV    Model: 1x2 SCSI BP      Rev: 1.0
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi0 Channel: 01 Id: 00 Lun: 00
  Vendor: MegaRAID Model: LD 0 RAID1   69G Rev: 521X
  Type:   Direct-Access                    ANSI SCSI revision: 02


Thanks,

-- 
Martin Alain Kretschek
