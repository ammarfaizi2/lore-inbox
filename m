Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbSJPUDd>; Wed, 16 Oct 2002 16:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261299AbSJPUDd>; Wed, 16 Oct 2002 16:03:33 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:55385 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S261317AbSJPUDa>;
	Wed, 16 Oct 2002 16:03:30 -0400
Date: Wed, 16 Oct 2002 22:09:22 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: (2.5.43mm1) Unable to handle kernel paging request
Message-ID: <20021016220921.A16005@jaquet.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Booting 2.5.43mm1, I get the following oops:

Unable to handle kernel paging request at virtual address 00002004
 printing eip:
c01a1ddd
*pde = 00000000
Oops: 0002
3c59x ide-scsi ide-cd rtc
CPU:    0
EIP:    0060:[<c01a1ddd>]    Not tainted
EFLAGS: 00010246
EIP is at nfs_proc_fsinfo+0x6d/0x110
eax: 00002000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: c7754200   edi: c79459ac   ebp: c72e1ed0   esp: c7257d4c
ds: 0068   es: 0068   ss: 0068
Process mount (pid: 503, threadinfo=c7256000 task=c76f0cc0)
Stack: c11b6084 c7257d58 00000000 00000011 c7945a10 c7257d98 00000000 c015d54c
       c7795a54 c72e1ed0 c02b3fa9 00000001 00000000 c7945a10 c7945a10 c7945a10
       c019c8cc c79459ac c7945a10 00002000 00001000 000f9010 0004b131 0003e6d0
Call Trace:
 [<c015d54c>] d_alloc_root+0x5c/0x70
 [<c019c8cc>] nfs_sb_init+0x11c/0x530
 [<c0117567>] do_schedule+0x1a7/0x320
 [<c0117852>] __wake_up_locked+0x22/0x30
 [<c0117730>] default_wake_function+0x0/0x40
 [<c01082cc>] __down_failed+0x8/0xc
 [<c02a18d9>] .text.lock.sched+0x19/0x40
 [<c019d006>] nfs_fill_super+0x326/0x3d0
 [<c0137274>] kmem_flagcheck+0x64/0x70
 [<c014d02d>] sget+0x11d/0x160
 [<c019ec4c>] nfs_get_sb+0x1ac/0x240
 [<c014da6b>] do_kern_mount+0x5b/0xd0
 [<c0161f90>] do_add_mount+0x90/0x190
 [<c01622d1>] do_mount+0x181/0x1d0
 [<c0162108>] copy_mount_options+0x78/0xc0
 [<c01626b8>] sys_mount+0xc8/0x100
 [<c01093b3>] syscall_call+0x7/0xb

Code: c7 40 04 00 20 00 00 8b 54 24 1c 8b 44 24 4c 89 50 08 8b 54
 MTRR: setting reg 1


I didn't get this with 2.5.42.

Regards,
  Rasmus

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9rcdxlZJASZ6eJs4RApwFAKCUwfW/9v4BfuoVVZR25ZSj5RD3RwCgl4Ee
IxCS3akww6Jztfszyiz6uoI=
=1sg2
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
