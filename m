Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbTDASOg>; Tue, 1 Apr 2003 13:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262710AbTDASOg>; Tue, 1 Apr 2003 13:14:36 -0500
Received: from smtp-out.comcast.net ([24.153.64.115]:55707 "EHLO
	smtp.comcast.net") by vger.kernel.org with ESMTP id <S262708AbTDASOc>;
	Tue, 1 Apr 2003 13:14:32 -0500
Date: Tue, 01 Apr 2003 13:25:50 -0500
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: 2.5.66 oops with pcmcia cf reader
To: linux-kernel@vger.kernel.org
Message-id: <20030401182550.GA561@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary=RnlQjJ0d97Da+TV1;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

when i insert the card and cardmgr/hotplug start loading modules, i
get this oops.  then mounting it gives me the other oops.
2.5.65 does it too.

thanks.

Linux density 2.5.66 #8 Tue Mar 25 14:57:38 EST 2003 i686 unknown unknown G=
NU/Linux

Apr  1 13:01:03 density kernel: hde: PQI FLASH DISK, CFA DISK drive
Apr  1 13:01:03 density kernel: ide2 at 0x100-0x107,0x10e on irq 10
Apr  1 13:01:03 density kernel: hde: task_no_data_intr: status=3D0x51 { Dri=
veReady SeekComplete Error }
Apr  1 13:01:03 density kernel: hde: task_no_data_intr: error=3D0x04 { Driv=
eStatusError }
Apr  1 13:01:03 density kernel: hde: 256000 sectors (131 MB) w/1KiB Cache, =
CHS=3D500/16/32
Apr  1 13:01:03 density kernel: /dev/ide/host2/bus0/target0/lun0: p1
Apr  1 13:01:03 density kernel: /dev/ide/host2/bus0/target0/lun0: p1
Apr  1 13:01:03 density kernel: Badness in kobject_register at lib/kobject.=
c:152
Apr  1 13:01:03 density kernel: Call Trace:
Apr  1 13:01:03 density kernel: [<c01da298>] kobject_register+0x58/0x70
Apr  1 13:01:03 density kernel: [<c0186ae9>] register_disk+0x149/0x170
Apr  1 13:01:03 density kernel: [<c0233fb8>] blk_register_region+0x48/0xe0
Apr  1 13:01:03 density kernel: [<c0234181>] add_disk+0x51/0x60
Apr  1 13:01:03 density kernel: [<c0234100>] exact_match+0x0/0x10
Apr  1 13:01:03 density kernel: [<c0234110>] exact_lock+0x0/0x20
Apr  1 13:01:03 density kernel: [<c02479bb>] idedisk_attach+0x11b/0x1a0
Apr  1 13:01:03 density kernel: [<c024316e>] ata_attach+0x9e/0x210
Apr  1 13:01:03 density kernel: [<c023be1e>] ideprobe_init+0xfe/0x11d
Apr  1 13:01:03 density kernel: [<c02416d3>] ide_probe_module+0x13/0x20
Apr  1 13:01:03 density kernel: [<c02422f9>] ide_register_hw+0x169/0x1a0
Apr  1 13:01:03 density kernel: [<d8b3c2a3>] idecs_register+0x63/0x80 [ide_=
cs]
Apr  1 13:01:03 density kernel: [<d8b09b50>] CardServices+0x210/0x360 [pcmc=
ia_core]
Apr  1 13:01:03 density kernel: [<d8b3c7de>] ide_config+0x51e/0x880 [ide_cs]
Apr  1 13:01:03 density kernel: [<d8aca2ad>] pci_set_mem_map+0x3d/0x40 [yen=
ta_socket]
Apr  1 13:01:03 density kernel: [<d8acd57c>] +0xbc/0x5e0 [yenta_socket]
Apr  1 13:01:03 density kernel: [<d8b02021>] +0x21/0x60 [pcmcia_core]
Apr  1 13:01:03 density kernel: [<d8b0218f>] read_cis_mem+0x12f/0x1a0 [pcmc=
ia_core]
Apr  1 13:01:03 density kernel: [<d8b03145>] pcmcia_get_tuple_data+0x95/0xa=
0 [pcmcia_core]
Apr  1 13:01:03 density kernel: [<d8b044fc>] pcmcia_parse_tuple+0x10c/0x170=
 [pcmcia_core]
Apr  1 13:01:03 density kernel: [<d8b045d4>] read_tuple+0x74/0x80 [pcmcia_c=
ore]
Apr  1 13:01:03 density kernel: [<d8acae73>] yenta_set_mem_map+0x1a3/0x1f0 =
[yenta_socket]
Apr  1 13:01:03 density kernel: [<d8acd57c>] +0xbc/0x5e0 [yenta_socket]
Apr  1 13:01:03 density kernel: [<d8b0305e>] pcmcia_get_next_tuple+0x26e/0x=
2c0 [pcmcia_core]
Apr  1 13:01:03 density kernel: [<d8b02b85>] pcmcia_get_first_tuple+0xb5/0x=
180 [pcmcia_core]
Apr  1 13:01:03 density kernel: [<d8acd57c>] +0xbc/0x5e0 [yenta_socket]
Apr  1 13:01:03 density kernel: [<d8acae73>] yenta_set_mem_map+0x1a3/0x1f0 =
[yenta_socket]
Apr  1 13:01:03 density kernel: [<d8acd57c>] +0xbc/0x5e0 [yenta_socket]
Apr  1 13:01:03 density kernel: [<d8aca2ad>] pci_set_mem_map+0x3d/0x40 [yen=
ta_socket]
Apr  1 13:01:03 density kernel: [<d8acd57c>] +0xbc/0x5e0 [yenta_socket]
Apr  1 13:01:03 density kernel: [<d8b02021>] +0x21/0x60 [pcmcia_core]
Apr  1 13:01:03 density kernel: [<d8b0218f>] read_cis_mem+0x12f/0x1a0 [pcmc=
ia_core]
Apr  1 13:01:03 density kernel: [<d8b03145>] pcmcia_get_tuple_data+0x95/0xa=
0 [pcmcia_core]
Apr  1 13:01:03 density kernel: [<d8b044fc>] pcmcia_parse_tuple+0x10c/0x170=
 [pcmcia_core]
Apr  1 13:01:03 density kernel: [<d8b045d4>] read_tuple+0x74/0x80 [pcmcia_c=
ore]
Apr  1 13:01:03 density kernel: [<d8acae73>] yenta_set_mem_map+0x1a3/0x1f0 =
[yenta_socket]
Apr  1 13:01:03 density kernel: [<d8acd57c>] +0xbc/0x5e0 [yenta_socket]
Apr  1 13:01:03 density kernel: [<d8b0305e>] pcmcia_get_next_tuple+0x26e/0x=
2c0 [pcmcia_core]
Apr  1 13:01:03 density kernel: [<d8b02b85>] pcmcia_get_first_tuple+0xb5/0x=
180 [pcmcia_core]
Apr  1 13:01:03 density kernel: [<d8acd57c>] +0xbc/0x5e0 [yenta_socket]
Apr  1 13:01:03 density kernel: [<d8b02021>] +0x21/0x60 [pcmcia_core]
Apr  1 13:01:03 density kernel: [<d8b0288b>] read_cis_cache+0x16b/0x1c0 [pc=
mcia_core]
Apr  1 13:01:03 density kernel: [<d8b0305e>] pcmcia_get_next_tuple+0x26e/0x=
2c0 [pcmcia_core]
Apr  1 13:01:03 density kernel: [<d8b046df>] pcmcia_validate_cis+0xff/0x1e0=
 [pcmcia_core]
Apr  1 13:01:03 density kernel: [<c01c2d75>] pathrelse_and_restore+0x45/0x50
Apr  1 13:01:03 density kernel: [<c01adb14>] do_balance+0xc4/0x110
Apr  1 13:01:03 density kernel: [<d8b3ccd8>] ide_event+0x68/0x100 [ide_cs]
Apr  1 13:01:03 density kernel: [<d8b08592>] pcmcia_register_client+0x212/0=
x2b0 [pcmcia_core]
Apr  1 13:01:03 density kernel: [<d8b3d560>] dev_info+0x0/0x20 [ide_cs]
Apr  1 13:01:03 density kernel: [<d8acae73>] yenta_set_mem_map+0x1a3/0x1f0 =
[yenta_socket]
Apr  1 13:01:03 density kernel: [<d8acd57c>] +0xbc/0x5e0 [yenta_socket]
Apr  1 13:01:03 density kernel: [<d8aca2ad>] pci_set_mem_map+0x3d/0x40 [yen=
ta_socket]
Apr  1 13:01:03 density kernel: [<d8b09aeb>] CardServices+0x1ab/0x360 [pcmc=
ia_core]
Apr  1 13:01:03 density kernel: [<d8b3c137>] ide_attach+0x107/0x150 [ide_cs]
Apr  1 13:01:03 density kernel: [<d8b3d560>] dev_info+0x0/0x20 [ide_cs]
Apr  1 13:01:03 density kernel: [<d8b3cc70>] ide_event+0x0/0x100 [ide_cs]
Apr  1 13:01:03 density kernel: [<d8b077c7>] pcmcia_bind_device+0x57/0xd0 [=
pcmcia_core]
Apr  1 13:01:03 density kernel: [<d8ad03f6>] get_pcmcia_driver+0x36/0x48 [d=
s]
Apr  1 13:01:03 density kernel: [<d8acf633>] bind_request+0x103/0x1a0 [ds]
Apr  1 13:01:03 density kernel: [<c01db6a2>] __copy_from_user_ll+0x72/0x78
Apr  1 13:01:03 density kernel: [<d8b3d560>] dev_info+0x0/0x20 [ide_cs]
Apr  1 13:01:03 density kernel: [<d8ad0222>] ds_ioctl+0x5d2/0x710 [ds]
Apr  1 13:01:03 density kernel: [<c025c34f>] sock_def_readable+0x7f/0x90
Apr  1 13:01:03 density kernel: [<c02b6486>] unix_stream_sendmsg+0x2b6/0x3f0
Apr  1 13:01:03 density kernel: [<c0258c6b>] sock_sendmsg+0xcb/0xd0
Apr  1 13:01:03 density kernel: [<c0119f59>] schedule+0x1a9/0x3c0
Apr  1 13:01:03 density kernel: [<c011a2c2>] __wake_up_locked+0x22/0x30
Apr  1 13:01:03 density kernel: [<c014410e>] zap_pmd_range+0x4e/0x70
Apr  1 13:01:03 density kernel: [<c014417e>] unmap_page_range+0x4e/0x90
Apr  1 13:01:03 density kernel: [<c01442a3>] unmap_vmas+0xe3/0x260
Apr  1 13:01:03 density kernel: [<c0147d13>] unmap_vma+0x43/0x80
Apr  1 13:01:03 density kernel: [<c0147d6f>] unmap_vma_list+0x1f/0x30
Apr  1 13:01:03 density kernel: [<c0148148>] do_munmap+0x178/0x1f0
Apr  1 13:01:03 density kernel: [<c01655e0>] sys_ioctl+0x120/0x2a0
Apr  1 13:01:03 density kernel: [<c010a2fb>] syscall_call+0x7/0xb
Apr  1 13:01:03 density kernel:=20
Apr  1 13:01:03 density kernel: Module ide_cs cannot be unloaded due to uns=
afe usage in include/linux/module.h:432
Apr  1 13:01:03 density kernel: ide-cs: hde: Vcc =3D 3.3, Vpp =3D 0.0
Apr  1 13:01:43 density kernel: /dev/ide/host2/bus0/target0/lun0: p1
Apr  1 13:01:43 density kernel: devfs_put(c61531e0): poisoned pointer
Apr  1 13:01:43 density kernel: Forcing Oops
Apr  1 13:01:43 density kernel: ------------[ cut here ]------------
Apr  1 13:01:43 density kernel: kernel BUG at fs/devfs/base.c:921!
Apr  1 13:01:43 density kernel: invalid operand: 0000 [#1]
Apr  1 13:01:43 density kernel: CPU:    0
Apr  1 13:01:43 density kernel: EIP:    0060:[<c01a562c>]    Not tainted
Apr  1 13:01:43 density kernel: EFLAGS: 00210286
Apr  1 13:01:43 density kernel: EIP is at devfs_put+0xfc/0x110
Apr  1 13:01:43 density kernel: eax: 0000000d   ebx: c61531e0   ecx: 000000=
01   edx: c030485c
Apr  1 13:01:43 density kernel: esi: d7d1e960   edi: d122fcc0   ebp: c2709c=
ac   esp: c2709c9c
Apr  1 13:01:43 density kernel: ds: 007b   es: 007b   ss: 0068
Apr  1 13:01:43 density kernel: Process mount (pid: 11708, threadinfo=3Dc27=
08000 task=3Dc43c7260)
Apr  1 13:01:43 density kernel: Stack: c02c96a1 c02bacd2 c61531e0 c278804c =
c2709cbc c0186895 c61531e0 00000002=20
Apr  1 13:01:43 density kernel: c2709ce8 c0186c03 d122fcc0 00000001 0000000=
0 0000003f 00000000 00002100=20
Apr  1 13:01:43 density kernel: 00000000 d122fcc0 d7d1e960 c2709d24 c015b9b=
e d122fcc0 d7d1e960 00000000=20
Apr  1 13:01:43 density kernel: Call Trace:
Apr  1 13:01:43 density kernel: [<c0186895>] delete_partition+0x65/0x80
Apr  1 13:01:43 density kernel: [<c0186c03>] rescan_partitions+0xf3/0x100
Apr  1 13:01:43 density kernel: [<c015b9be>] do_open+0xee/0x410
Apr  1 13:01:43 density kernel: [<c015bd45>] blkdev_get+0x65/0x70
Apr  1 13:01:43 density kernel: [<c015c0fe>] open_bdev_excl+0x5e/0xb0
Apr  1 13:01:43 density kernel: [<c015a6b0>] get_sb_bdev+0x30/0x170
Apr  1 13:01:43 density kernel: [<c01a550e>] vfat_get_sb+0x2e/0x40
Apr  1 13:01:43 density kernel: [<c01a5470>] vfat_fill_super+0x0/0x70
Apr  1 13:01:43 density kernel: [<c015a9ee>] do_kern_mount+0x5e/0x100
Apr  1 13:01:43 density kernel: [<c01d5384>] capable+0x24/0x50
Apr  1 13:01:43 density kernel: [<c017016d>] do_add_mount+0x7d/0x170
Apr  1 13:01:43 density kernel: [<c01704ae>] do_mount+0x16e/0x1c0
Apr  1 13:01:43 density kernel: [<c017032c>] copy_mount_options+0xcc/0xe0
Apr  1 13:01:43 density kernel: [<c0170985>] sys_mount+0xc5/0x120
Apr  1 13:01:43 density kernel: [<c010a2fb>] syscall_call+0x7/0xb
Apr  1 13:01:43 density kernel:=20
Apr  1 13:01:43 density kernel: Code: 0f 0b 99 03 af 96 2c c0 e9 18 ff ff f=
f 8d b4 26 00 00 00 00=20

Module                  Size  Used by
udf                    95044  0=20
ide_cd                 37408  0=20
cdrom                  32928  1 ide_cd
ipv6                  199936  15 [unsafe]
autofs4                13376  2=20
af_packet              17832  1 [unsafe]
8250_cs                 6912  0=20
8250                   16928  1 8250_cs
core                   19392  1 8250
3c574_cs               13380  1 [unsafe]
ds                     10880  4 8250_cs,3c574_cs
yenta_socket           15008  2=20
pcmcia_core            56768  4 8250_cs,3c574_cs,ds,yenta_socket
uhci_hcd               29896  0=20
usbcore               102452  3 uhci_hcd
nls_iso8859_1           3712  1=20
nls_cp437               5376  1=20
apm                    15268  2=20
mousedev                7352  1=20
i8k                     5792  0=20
snd_pcm_oss            48708  0=20
snd_mixer_oss          16800  2 snd_pcm_oss
snd_maestro3           20836  1=20
snd_ac97_codec         45252  1 snd_maestro3
snd_pcm                84704  2 snd_pcm_oss,snd_maestro3
snd_page_alloc          7652  1 snd_pcm
snd_timer              20832  1 snd_pcm
snd                    44388  6 snd_pcm_oss,snd_mixer_oss,snd_maestro3,snd_=
ac97_codec,snd_pcm,snd_timer
soundcore               7104  1 snd
rtc                    10532  0=20

--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+idmuCGPRljI8080RAiTlAKCQB+6DyZ58YnAGcfCCuNG97GRzqQCfWTD9
80Yf4cDTu3taBzMFB8e8/ts=
=ewk9
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
