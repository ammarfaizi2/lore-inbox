Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269128AbTBWTZz>; Sun, 23 Feb 2003 14:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269134AbTBWTZz>; Sun, 23 Feb 2003 14:25:55 -0500
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:1904 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S269128AbTBWTZv>;
	Sun, 23 Feb 2003 14:25:51 -0500
Date: Sun, 23 Feb 2003 20:35:27 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.62 and NFS, a BUG
Message-ID: <20030223203526.A16183@jaquet.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I just booted 2.5.62 and got the following during boot/init:


Unable to handle kernel NULL pointer dereference at virtual address 00000286
 printing eip:
c0183e11
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0183e11>]    Not tainted
EFLAGS: 00010203
EIP is at d_alloc+0x51/0x370
eax: 00000286   ebx: ca271e4c   ecx: 000000a1   edx: caa1780c
esi: 00000286   edi: caa1780c   ebp: ca2f7c04   esp: ca2f7b7c
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 224, threadinfo=3Dca2f6000 task=3Dca89f320)
Stack: 0000029c 000000d0 00000038 00000000 cbf57148 ca2f6000 ca2f6000 00000=
800=20
       00000000 00000286 cbfef350 00000286 00000000 ca274d48 ca22e724 ca2f7=
c04=20
       fffffff4 ca274d48 ca22e724 ca2f7c04 c01790a9 ca22e724 ca2f7c04 00000=
000=20
Call Trace:
 [<c01790a9>] lookup_hash+0x89/0xd0
 [<c036c793>] rpc_rmdir+0x93/0xe0
 [<c0354d89>] rpc_destroy_client+0x29/0x80
 [<c035d1ff>] rpc_release_task+0x2af/0x4b0
 [<c0355eee>] call_decode+0xde/0x1d0
 [<c035c554>] __rpc_execute+0x514/0x5b0
 [<c035f513>] rpcauth_bindcred+0x83/0xd0
 [<c011e950>] default_wake_function+0x0/0x20
 [<c035537d>] rpc_call_sync+0xbd/0x100
 [<c035a950>] rpc_run_timer+0x0/0x1f0
 [<c0366e35>] rpc_register+0xc5/0x140
 [<c0110000>] handle_vm86_fault+0x50/0x8e0
 [<c036097e>] svc_register+0x26e/0x2e0
 [<c01494c5>] kmalloc+0x95/0xd0
 [<c03602ed>] svc_create+0x10d/0x120
 [<c01f3fb3>] lockd_up+0x73/0x180
 [<c01e332f>] nfs_fill_super+0x35f/0x3f0
 [<c016da82>] sget+0x242/0x300
 [<c0149401>] kmem_cache_alloc+0x71/0xa0
 [<c01e4fcc>] nfs_get_sb+0x1ac/0x240
 [<c016f12b>] do_kern_mount+0x5b/0xd0
 [<c018caf0>] do_add_mount+0xa0/0x1b0
 [<c018ce40>] do_mount+0x160/0x1b0
 [<c018ccda>] copy_mount_options+0xda/0xe0
 [<c018d396>] sys_mount+0xb6/0xf0
 [<c010c28f>] syscall_call+0x7/0xb

Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 8b 45 04 c6 04 10 00=20
=20

Should further elaborations, ksymoops runs or such like be
required, let me know. I am open for testing patches.

Regards,
  Rasmus

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+WSJ+lZJASZ6eJs4RAik+AKCeWZKwILNDQMem6o2L04P1T7Q+3ACeIpLB
aJZFjIF8hCrX+jnakb/NWsI=
=tdK7
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
