Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVLSTBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVLSTBv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVLSTBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:01:51 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:12736 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S932350AbVLSTBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:01:50 -0500
Date: Mon, 19 Dec 2005 20:01:47 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.13.3] occasional oops mostly in iget_locked
Message-ID: <20051219190137.GA13923@vanheusden.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Tue Dec 20 19:38:51 CET 2005
X-Message-Flag: MultiTail - tail on steroids
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

1. occasional oops with 2.6.13.3
2. see 1
3. fs
4. 2.6.13.3
5. 2.6.11.6 (none tested inbetween)
6.=20
[199459.859838] Unable to handle kernel paging request at virtual address 7=
4207475
[199459.859897]  printing eip:
[199459.859917] *pde =3D 00000000
[199459.859947] Oops: 0000 [#1]
[199459.859963] SMP=20
[199459.859986] Modules linked in: wcfxo zaptel snd_intel8x0 snd_seq snd_se=
q_device snd_pcm_oss snd_mixer_oss snd_ac97_codec snd_pcm snd_timer snd tun=
er tvaudio bttv video_buf firmware_class i2c_algo_bit btcx_risc tveeprom po=
lice sch_ingress cls_u32 sch_sfq sch_cbq pl2303 usbserial nfs ipt_limit ipt=
_state ipt_REJECT usbnet ipt_MASQUERADE w83627hf hwmon_vid ipt_TOS eeprom i=
ptable_mangle i2c_isa i2c_core bsd_comp soundcore snd_page_alloc snd_ac97_b=
us ip6table_filter ip6_tables iptable_filter ide_cd cdrom parport_pc parpor=
t microcode netconsole nfsd exportfs lockd sunrpc ipv6 rtl8150 3c59x mii ip=
table_nat ip_nat ip_tables ip_conntrack nfnetlink ppp_deflate zlib_deflate =
zlib_inflate ppp_async crc_ccitt ppp_generic slip slhc genrtc rd
[199459.863603] CPU:    0
[199459.863605] EIP:    0060:[<c0178c60>]    Not tainted VLI
[199459.863608] EFLAGS: 00010202   (2.6.14-pwc)=20
[199459.864346] EIP is at find_inode_fast+0x10/0x50
[199459.864366] eax: d9a7509c   ebx: 0003443a   ecx: 74207475   edx: 742074=
75
[199459.864440] esi: f7d3da00   edi: c18c2a90   ebp: f7d3da00   esp: d0ce9d=
d8
[199459.864508] ds: 007b   es: 007b   ss: 0068
[199459.864577] Process tar (pid: 14803, threadinfo=3Dd0ce8000 task=3Dcd4a8=
540)
[199459.864596] Stack: 0003443a 0003443a 0000ffff c0179375 00000008 c18c2a9=
0 0003443a c84174ec=20
[199459.865748]        f7d3da00 c84174ec c01a36eb e7bc70d0 c034bb60 fffffff=
4 e4a26a9c c016cdde=20
[199459.866111]        d0ce9f14 00000000 d0ce9e64 d0ce9f14 d0ce9e6c c016d0f=
5 c18e7500 da588035=20
[199459.866843] Call Trace:
[199459.866895]  [<c0179375>] iget_locked+0x55/0xd0
[199459.867308]  [<c01a36eb>] ext3_lookup+0x5b/0xb0
[199459.867419]  [<c016cdde>] real_lookup+0xae/0xd0
[199459.867686]  [<c016d0f5>] do_lookup+0x85/0x90
[199459.867731]  [<c016d7c9>] __link_path_walk+0x6c9/0xd40
[199459.867798]  [<c016de87>] link_path_walk+0x47/0xe0
[199459.868173]  [<c016e1eb>] path_lookup+0x9b/0x1a0
[199459.868276]  [<c016e44f>] __user_walk+0x2f/0x50
[199459.868802]  [<c0168dda>] vfs_lstat+0x1a/0x50
[199459.869014]  [<c0169442>] sys_lstat64+0x12/0x30
[199459.869059]  [<c01c78d0>] _atomic_dec_and_lock+0x30/0x50
[199459.869276]  [<c0176808>] dput+0x158/0x1d0
[199459.869329]  [<c01605f0>] __fput+0x100/0x160
[199459.869929]  [<c015ec53>] filp_close+0x43/0x70
[199459.869981]  [<c0102dc9>] syscall_call+0x7/0xb
[199459.870063] Code: 09 89 d8 e8 f3 0d 00 00 eb af 85 db 89 d8 75 d1 eb cd=
 89 f6 8d bc 27 00 00 00 00 57 89 d7 56 89 c6 53 89 cb 8b 0f 85 c9 74 14 90=
 <8b> 11 0f 18 02 90 39 59 20 89 c8 74 13 85 d2 89 d1 75 ed 31 c0=20
[199459.874125]  <3>BUG: soft lockup detected on CPU#0!
[199468.896310]=20
[199468.896326] Pid: 1024, comm:              syslogd
[199468.896342] EIP: 0060:[<c02e76da>] CPU: 0
[199468.896364] EIP is at _spin_lock+0xa/0x10
[199468.896380]  EFLAGS: 00000282    Not tainted  (2.6.14-pwc)
[199468.896401] EAX: c0349274 EBX: 00000001 ECX: 00000000 EDX: f7d6a93c
[199468.896419] ESI: f75048f0 EDI: 00000001 EBP: f750489c DS: 007b ES: 007b
[199468.896447] CR0: 8005003b CR2: 08054424 CR3: 37df2000 CR4: 000006d0
[199468.896465]  [<c01818d2>] __mark_inode_dirty+0x62/0x1d0
[199468.896518]  [<c0121721>] current_fs_time+0x61/0x80
[199468.896564]  [<c017992e>] inode_update_time+0x9e/0xc0
[199468.896681]  [<c014226a>] __generic_file_aio_write_nolock+0x2ea/0x560
[199468.896725]  [<c028359e>] sock_sendmsg+0xbe/0xe0
[199468.896812]  [<c0142621>] __generic_file_write_nolock+0x91/0xc0
[199468.896881]  [<c028488c>] sys_sendto+0xcc/0xe0
[199468.896917]  [<c0130900>] autoremove_wake_function+0x0/0x50
[199468.897034]  [<c0142996>] generic_file_writev+0x36/0xc0
[199468.897073]  [<c0142960>] generic_file_writev+0x0/0xc0
[199468.897106]  [<c015f620>] do_sync_write+0x0/0x110
[199468.897138]  [<c015fd80>] do_readv_writev+0x290/0x2c0
[199468.897212]  [<c015fe49>] vfs_writev+0x49/0x60
[199468.897320]  [<c015ff57>] sys_writev+0x47/0xb0
[199468.897424]  [<c0102dc9>] syscall_call+0x7/0xb
[738678.400635] Unable to handle kernel NULL pointer dereference at virtual=
 address 00000008
[738678.400694]  printing eip:
[738678.400712] *pde =3D 00000000
[738678.400741] Oops: 0000 [#1]
[738678.400757] SMP=20
[738678.400780] Modules linked in: tuner tvaudio bttv video_buf firmware_cl=
ass i2c_algo_bit btcx_risc tveeprom usbnet wcfxo zaptel pl2303 usbserial nf=
s snd_pcm_oss snd_mixer_oss w83627hf hwmon_vid police eeprom sch_ingress i2=
c_isa i2c_core cls_u32 sch_sfq sch_cbq ipt_limit ipt_state ipt_REJECT ipt_M=
ASQUERADE ipt_TOS iptable_mangle bsd_comp snd_intel8x0 snd_ac97_codec snd_p=
cm snd_timer snd soundcore snd_page_alloc snd_ac97_bus iptable_filter ip6ta=
ble_filter ip6_tables ide_cd cdrom parport_pc parport microcode netconsole =
nfsd exportfs lockd sunrpc ipv6 rtl8150 3c59x mii iptable_nat ip_nat ip_tab=
les ip_conntrack nfnetlink ppp_deflate zlib_deflate zlib_inflate ppp_async =
crc_ccitt ppp_generic slip slhc genrtc rd
[738678.404055] CPU:    0
[738678.404057] EIP:    0060:[<c0178c60>]    Not tainted VLI
[738678.404058] EFLAGS: 00010202   (2.6.14-pwc)=20
[738678.404244] EIP is at find_inode_fast+0x10/0x50
[738678.404262] eax: d9a7509c   ebx: 0004479e   ecx: 00000008   edx: 000000=
08
[738678.404283] esi: f7c4f400   edi: c18afbf8   ebp: f7c4f400   esp: e9a75d=
d8
[738678.404302] ds: 007b   es: 007b   ss: 0068
[738678.404319] Process tar (pid: 31041, threadinfo=3De9a74000 task=3Df7dd6=
a50)
[738678.404333] Stack: 0004479e 0004479e 0000ffff c0179375 00000006 c18afbf=
8 0004479e cdec0578=20
[738678.404480]        f7c4f400 cdec0578 c01a36eb d7f1e034 c034bb60 fffffff=
4 c6f7809c c016cdde=20
[738678.405713]        e9a75f14 00000000 e9a75e64 e9a75f14 e9a75e6c c016d0f=
5 c18e7500 c0d8e036=20
[738678.406699] Call Trace:
[738678.406738]  [<c0179375>] iget_locked+0x55/0xd0
[738678.407059]  [<c01a36eb>] ext3_lookup+0x5b/0xb0
[738678.407162]  [<c016cdde>] real_lookup+0xae/0xd0
[738678.407200]  [<c016d0f5>] do_lookup+0x85/0x90
[738678.407244]  [<c016d7c9>] __link_path_walk+0x6c9/0xd40
[738678.407572]  [<c016de87>] link_path_walk+0x47/0xe0
[738678.407698]  [<c016e1eb>] path_lookup+0x9b/0x1a0
[738678.408263]  [<c016e44f>] __user_walk+0x2f/0x50
[738678.408303]  [<c0168dda>] vfs_lstat+0x1a/0x50
[738678.408366]  [<c0169442>] sys_lstat64+0x12/0x30
[738678.408665]  [<c01c78d0>] _atomic_dec_and_lock+0x30/0x50
[738678.408705]  [<c0176808>] dput+0x158/0x1d0
[738678.409454]  [<c01605f0>] __fput+0x100/0x160
[738678.409497]  [<c015ec53>] filp_close+0x43/0x70
[738678.409535]  [<c0102dc9>] syscall_call+0x7/0xb
[738678.409842] Code: 09 89 d8 e8 f3 0d 00 00 eb af 85 db 89 d8 75 d1 eb cd=
 89 f6 8d bc 27 00 00 00 00 57 89 d7 56 89 c6 53 89 cb 8b 0f 85 c9 74 14 90=
 <8b> 11 0f 18 02 90 39 59 20 89 c8 74 13 85 d2 89 d1 75 ed 31 c0=20
[738678.414151]  <3>BUG: soft lockup detected on CPU#1!
[738687.762275]=20
[738687.762296] Pid: 9676, comm:            multitail
[738687.762316] EIP: 0060:[<c02e76d7>] CPU: 1
[738687.762343] EIP is at _spin_lock+0x7/0x10
[738687.762362]  EFLAGS: 00000282    Not tainted  (2.6.14-pwc)
[738687.762382] EAX: c0349274 EBX: c18fc880 ECX: 00000010 EDX: c18e15ac
[738687.762402] ESI: f0000000 EDI: 0000ffff EBP: c18ea200 DS: 007b ES: 007b
[738687.762440] CR0: 80050033 CR2: b7f9b000 CR3: 32af6000 CR4: 000006d0
[738687.762463]  [<c0179368>] iget_locked+0x48/0xd0
[738687.762525]  [<c0190b88>] proc_get_inode+0x28/0x140
[738687.762576]  [<c0193a2c>] proc_lookup+0xbc/0xd0
[738687.762632]  [<c0190d85>] proc_root_lookup+0x25/0x70
[738687.762675]  [<c016cdde>] real_lookup+0xae/0xd0
[738687.762726]  [<c016d0f5>] do_lookup+0x85/0x90
[738687.762775]  [<c016d7c9>] __link_path_walk+0x6c9/0xd40
[738687.762844]  [<c016de87>] link_path_walk+0x47/0xe0
[738687.762886]  [<c0153b2c>] unmap_region+0xfc/0x140
[738687.762932]  [<c015ea09>] get_unused_fd+0x99/0xc0
[738687.762973]  [<c016e1eb>] path_lookup+0x9b/0x1a0
[738687.763013]  [<c016e978>] open_namei+0x88/0x5d0
[738687.763109]  [<c014fb9e>] unmap_vmas+0xfe/0x240
[738687.763876]  [<c016045b>] get_empty_filp+0x5b/0xd0
[738687.763914]  [<c015e8e4>] filp_open+0x54/0x90
[738687.764016]  [<c0153b2c>] unmap_region+0xfc/0x140
[738687.764112]  [<c015ea09>] get_unused_fd+0x99/0xc0
[738687.764154]  [<c015eb31>] do_sys_open+0x41/0xd0
[738687.764962]  [<c0102dc9>] syscall_call+0x7/0xb
(hooray for netconsole!)
7. -
8 P4 3.2GHz, 2GB ram
8.1 system is a quiet busy system doing mail, databases, etc. On average 27=
2 processes.
0 root@muur:/usr/src/linux/scripts$ ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux muur 2.6.14-pwc #1 SMP Wed Nov 9 18:09:12 CET 2005 i686 unknown
unknown GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.15.90.0.1.1
util-linux             2.12h
mount                  2.12h
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          2001------------->
reiser4progs           line
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Linux C++ Library      5.0.5
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.06
Sh-utils               5.2.1
Modules Loaded         tuner tvaudio bttv video_buf firmware_class
i2c_algo_bit btcx_risc tveeprom wcfxo zaptel pl2303 usbserial nfs usbnet
w83627hf hwmon_vid eeprom i2c_isa i2c_core snd_pcm_oss snd_mixer_oss
police sch_ingress cls_u32 sch_sfq sch_cbq snd_intel8x0 snd_ac97_codec
snd_pcm snd_timer snd soundcore ipt_limit snd_page_alloc snd_ac97_bus
ipt_state ipt_REJECT ipt_MASQUERADE ipt_TOS iptable_mangle bsd_comp
ip6table_filter ip6_tables iptable_filter ide_cd cdrom parport_pc
parport microcode netconsole nfsd exportfs lockd sunrpc ipv6 rtl8150
3c59x mii iptable_nat ip_nat ip_tables ip_conntrack nfnetlink
ppp_deflate zlib_deflate zlib_inflate ppp_async crc_ccitt ppp_generic
slip slhc genrtc rd
8.2
0 root@muur:/usr/src/linux/scripts$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping        : 9
cpu MHz         : 3198.487
cache size      : 512 KB
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
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
xtpr
bogomips        : 6403.64

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping        : 9
cpu MHz         : 3198.487
cache size      : 512 KB
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
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
xtpr
bogomips        : 6397.09

8.4
0 root@muur:/usr/src/linux/scripts$ cat /proc/ioports /proc/iomem
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0290-0297 : pnp 00:09
  0290-0297 : w83627hf
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-041f : 0000:00:1f.3
0480-04bf : 0000:00:1f.0
0680-06ff : pnp 00:09
0778-077a : parport0
0800-087f : 0000:00:1f.0
  0800-0803 : PM1a_EVT_BLK
  0804-0805 : PM1a_CNT_BLK
  0808-080b : PM_TMR
  0828-082f : GPE0_BLK
0cf8-0cff : PCI conf1
b000-bfff : PCI Bus #01
  b000-b0ff : 0000:01:00.0
c000-cfff : PCI Bus #02
  cf80-cf9f : 0000:02:01.0
d000-dfff : PCI Bus #03
  d400-d4ff : 0000:03:0b.0
    d400-d4fe : wcfxo
  d880-d8ff : 0000:03:09.0
    d880-d8ff : 0000:03:09.0
  dc00-dc7f : 0000:03:03.0
  df20-df3f : 0000:03:0d.0
    df20-df3f : ne2k-pci
  df40-df5f : 0000:03:0a.0
    df40-df5f : uhci_hcd
  df80-df9f : 0000:03:0a.1
    df80-df9f : uhci_hcd
e800-e8ff : 0000:00:1f.5
  e800-e8ff : Intel ICH5
ee80-eebf : 0000:00:1f.5
  ee80-eebf : Intel ICH5
eec0-eedf : 0000:00:1d.0
  eec0-eedf : uhci_hcd
ef00-ef1f : 0000:00:1d.1
  ef00-ef1f : uhci_hcd
ef20-ef3f : 0000:00:1d.2
  ef20-ef3f : uhci_hcd
ef80-ef9f : 0000:00:1d.3
  ef80-ef9f : uhci_hcd
fc00-fc0f : 0000:00:1f.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1
00000000-0009fbff : System RAM
  00000000-00000000 : Crash kernel
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000f0000-000fffff : System ROM
00100000-7ff2ffff : System RAM
  00100000-002e8c06 : Kernel code
  002e8c07-0039913f : Kernel data
7ff30000-7ff3ffff : ACPI Tables
7ff40000-7ffeffff : ACPI Non-volatile Storage
7fff0000-7fffffff : reserved
88000000-880003ff : 0000:00:1f.1
e0000000-efffffff : 0000:00:00.0
f6600000-fe5fffff : PCI Bus #01
  f8000000-fbffffff : 0000:01:00.0
fe600000-fe6fffff : PCI Bus #03
  fe600000-fe61ffff : 0000:03:09.0
  fe6fe000-fe6fefff : 0000:03:0c.0
    fe6fe000-fe6fefff : bttv0
  fe6ff000-fe6fffff : 0000:03:0c.1
fe800000-fe8fffff : PCI Bus #01
  fe8c0000-fe8dffff : 0000:01:00.0
  fe8fc000-fe8fffff : 0000:01:00.0
fe900000-fe9fffff : PCI Bus #02
  fe9e0000-fe9fffff : 0000:02:01.0
fea00000-feafffff : PCI Bus #03
  feafe000-feafefff : 0000:03:0b.0
  feaff000-feaff0ff : 0000:03:0a.2
    feaff000-feaff0ff : ehci_hcd
  feaff400-feaff47f : 0000:03:09.0
  feaff800-feafffff : 0000:03:03.0
febfb400-febfb4ff : 0000:00:1f.5
  febfb400-febfb4ff : Intel ICH5
febfb800-febfb9ff : 0000:00:1f.5
  febfb800-febfb9ff : Intel ICH5
febfbc00-febfbfff : 0000:00:1d.7
  febfbc00-febfbfff : ehci_hcd
ffb80000-ffffffff : reserved

8.5
00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D256M]
	Capabilities: [e4] #09 [2106]
	Capabilities: [a0] AGP version 3.0
		Status: RQ=3D32 Iso- ArqSz=3D2 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 64bit=
- FW+ AGP3- Rate=3Dx1,x2,x4
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- Rate=3D<no=
ne>

00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)=
 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: fe800000-fe8fffff
	Prefetchable memory behind bridge: f6600000-fe5fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge (rev =
02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fe900000-fe9fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (re=
v 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at eec0 [size=3D32]

00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (re=
v 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at ef00 [size=3D32]

00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (re=
v 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 17
	Region 4: I/O ports at ef20 [size=3D32]

00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (re=
v 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at ef80 [size=3D32]

00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Contr=
oller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 18
	Region 0: Memory at febfbc00 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Br=
idge (rev c2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fea00000-feafffff
	Prefetchable memory behind bridge: fe600000-fe6fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 St=
orage Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at fc00 [size=3D16]
	Region 5: Memory at 88000000 (32-bit, non-prefetchable) [size=3D1K]

00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 0400 [size=3D32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC=
'97 Audio Controller (rev 02)
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 23
	Region 0: I/O ports at e800 [size=3D256]
	Region 1: I/O ports at ee80 [size=3D64]
	Region 2: Memory at febfb800 (32-bit, non-prefetchable) [size=3D512]
	Region 3: Memory at febfb400 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro Ultra =
TF (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage Fury Pro/Xpert 2000 Pro
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 04
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=3D64M]
	Region 1: I/O ports at b000 [size=3D256]
	Region 2: Memory at fe8fc000 (32-bit, non-prefetchable) [size=3D16K]
	Expansion ROM at fe8c0000 [disabled] [size=3D128K]
	Capabilities: [50] AGP version 2.0
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 64bit=
- FW- AGP3- Rate=3Dx1,x2,x4
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA+ AGP- GART64- 64bit- FW- Rate=3D<no=
ne>
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet Controlle=
r (LOM)
	Subsystem: Asustek Computer, Inc.: Unknown device 80f7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0 (63750ns min), cache line size 04
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at fe9e0000 (32-bit, non-prefetchable) [size=3D128K]
	Region 2: I/O ports at cf80 [size=3D32]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-

03:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Control=
ler (rev 80) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns max), cache line size 04
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at feaff800 (32-bit, non-prefetchable) [size=3D2K]
	Region 1: I/O ports at dc00 [size=3D128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

03:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (r=
ev 24)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 04
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at d880 [size=3D128]
	Region 1: Memory at feaff400 (32-bit, non-prefetchable) [size=3D128]
	Expansion ROM at fe600000 [disabled] [size=3D128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

03:0a.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] =
(rev 50) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 04
	Interrupt: pin A routed to IRQ 22
	Region 4: I/O ports at df40 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

03:0a.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] =
(rev 50) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 04
	Interrupt: pin B routed to IRQ 18
	Region 4: I/O ports at df80 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

03:0a.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if 20=
 [EHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID): Unknown device 1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 20
	Interrupt: pin C routed to IRQ 19
	Region 0: Memory at feaff000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk+ DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

03:0b.0 Communication controller: Individual Computers - Jens Schoenfeld In=
tel 537
	Subsystem: Intel Corp.: Unknown device 0003
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at d400 [size=3D256]
	Region 1: Memory at feafe000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=3D55mA PME(D0+,D1-,D2+,D3hot+,D3co=
ld+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

03:0c.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capt=
ure (rev 11)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at fe6fe000 (32-bit, prefetchable) [size=3D4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

03:0c.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (r=
ev 11)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fe6ff000 (32-bit, prefetchable) [size=3D4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

03:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at df20 [size=3D32]

It seems to lead to a crash every weeks or so.
The last messsage I got via netconsole seems to be:
[972250.419638] svc: unknown version (0)
and this svc-thing seems to be triggered by nagios running every 5 minutes =
or so.

Oh in the startupscripts I have:
echo 2000000000 > /proc/sys/vm/dirty_writeback_centisecs
echo 2000000000 > /proc/sys/vm/dirty_expire_centisecs
echo 99 > /proc/sys/vm/dirty_ratio
echo 99 > /proc/sys/vm/dirty_background_ratio


Folkert van Heusden

--=20
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iIMEARECAEMFAkOnA5E8Gmh0dHA6Ly93d3cudmFuaGV1c2Rlbi5jb20vZGF0YS1z
aWduaW5nLXdpdGgtcGdwLXBvbGljeS5odG1sAAoJEDAZDowfKNiu6G4An0ZV1be6
8DdBfiCbIkVWvFZkqFZ7AJ46yvic7r6gktwFO8VOmMZks32mbQ==
=XYvE
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
