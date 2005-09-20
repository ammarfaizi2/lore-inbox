Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVITWme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVITWme (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVITWme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:42:34 -0400
Received: from smtp05.auna.com ([62.81.186.15]:33276 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S1750707AbVITWmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:42:33 -0400
Date: Wed, 21 Sep 2005 00:42:30 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: one more oops on sensor modules removal
Message-ID: <20050921004230.64ed395d@werewolf.able.es>
In-Reply-To: <20050916022319.12bf53f3.akpm@osdl.org>
References: <20050916022319.12bf53f3.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 1.9.15-rc3 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Wed__21_Sep_2005_00_42_30_+0200_X.ZWgcBrd5h0ygsv;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.222.72] Login:jamagallon@able.es Fecha:Wed, 21 Sep 2005 00:42:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Wed__21_Sep_2005_00_42_30_+0200_X.ZWgcBrd5h0ygsv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Sep 2005 02:23:19 -0700
Andrew Morton <akpm@osdl.org> wrote:

>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc1/=
2.6.14-rc1-mm1/
> (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc1-=
mm1.gz)
>=20

Sep 20 23:55:58 werewolf kernel: Unable to handle kernel NULL pointer deref=
erence at virtual address 00000038
Sep 20 23:55:58 werewolf kernel:  printing eip:
Sep 20 23:55:58 werewolf kernel: b01baebb
Sep 20 23:55:58 werewolf kernel: *pde =3D 00000000
Sep 20 23:55:58 werewolf kernel: Oops: 0000 [#1]
Sep 20 23:55:58 werewolf kernel: PREEMPT SMP
Sep 20 23:55:58 werewolf kernel: last sysfs file: /class/vc/vcsa12/dev
Sep 20 23:55:58 werewolf kernel: Modules linked in: soundcore w83627hf hwmo=
n_vid hwmon i2c_isa i2c_i801 i2c_core ohci1394 eth1394 ieee1394 usblp e1000=
 3c59x usbhid intel_agp agpgart ide_floppy ehci_hcd uhci_hcd
Sep 20 23:55:58 werewolf kernel: CPU:    1
Sep 20 23:55:58 werewolf kernel: EIP:    0060:[kref_put+21/138]    Not tain=
ted VLI
Sep 20 23:55:58 werewolf kernel: EIP:    0060:[<b01baebb>]    Not tainted V=
LI
Sep 20 23:55:58 werewolf kernel: EFLAGS: 00010206   (2.6.13-jam5)
Sep 20 23:55:58 werewolf kernel: EIP is at kref_put+0x15/0x8a
Sep 20 23:55:58 werewolf kernel: eax: 00000038   ebx: 00000038   ecx: b18ff=
400   edx: b01ba6de
Sep 20 23:55:58 werewolf kernel: esi: b01ba6de   edi: 0805c178   ebp: ee03b=
000   esp: ee03bf54
Sep 20 23:55:58 werewolf kernel: ds: 007b   es: 007b   ss: 0068
Sep 20 23:55:58 werewolf kernel: Process modprobe (pid: 2070, threadinfo=3D=
ee03b000 task=3Def384a90)
Sep 20 23:55:58 werewolf kernel: Stack: ee50dea0 00000000 ee50de80 00000000=
 f0a86a00 00000000 b0132bd6 6e756f73
Sep 20 23:55:58 werewolf kernel:        726f6364 b0140065 a7f03000 eeb89a80=
 b0149fc7 a7f03000 a7f04000 ef08e284
Sep 20 23:55:58 werewolf kernel:        eeb89a80 eeb89ab0 ffff0001 ee03b000=
 b014a02d 00000004 00000000 0805c178
Sep 20 23:55:58 werewolf kernel: Call Trace:
Sep 20 23:55:58 werewolf kernel:  [sys_delete_module+296/356] sys_delete_mo=
dule+0x128/0x164
Sep 20 23:55:58 werewolf kernel:  [<b0132bd6>] sys_delete_module+0x128/0x164
Sep 20 23:55:58 werewolf kernel:  [kmem_cache_create+1083/1748] kmem_cache_=
create+0x43b/0x6d4
Sep 20 23:55:58 werewolf kernel:  [<b0140065>] kmem_cache_create+0x43b/0x6d4
Sep 20 23:55:58 werewolf kernel:  [do_munmap+202/247] do_munmap+0xca/0xf7
Sep 20 23:55:58 werewolf kernel:  [<b0149fc7>] do_munmap+0xca/0xf7
Sep 20 23:55:58 werewolf kernel:  [sys_munmap+57/85] sys_munmap+0x39/0x55
Sep 20 23:55:58 werewolf kernel:  [<b014a02d>] sys_munmap+0x39/0x55
Sep 20 23:55:58 werewolf kernel:  [sysenter_past_esp+84/117] sysenter_past_=
esp+0x54/0x75
Sep 20 23:55:58 werewolf kernel:  [<b0102b53>] sysenter_past_esp+0x54/0x75
Sep 20 23:55:58 werewolf kernel: Code: 24 2d b0 c7 04 24 3e ce 2d b0 e8 6b =
fc f5 ff e8 3e 8b f4 ff eb cd 56 53 83 ec 10 89 c3 89 d6 85 d2 74 3e 81 fa =
39 0f 14 b0 74 61 <8b> 03 85 c0 74 1d f0 ff 0b 0f 94 c0 31 d2 84 c0 74 09 8=
9 d8 ff

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.0 (2006 rc2) for i586
Linux 2.6.13-jam5 (gcc 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0))

--Signature_Wed__21_Sep_2005_00_42_30_+0200_X.ZWgcBrd5h0ygsv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDMJBWRlIHNEGnKMMRAsuSAJ9p7rkQGr8Z7lHLld2dI8o4utrg0wCfQE4R
IolyhB/xdKvWLTLg5P7G2o8=
=j/db
-----END PGP SIGNATURE-----

--Signature_Wed__21_Sep_2005_00_42_30_+0200_X.ZWgcBrd5h0ygsv--
