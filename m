Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290645AbSA3WKX>; Wed, 30 Jan 2002 17:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290656AbSA3WJi>; Wed, 30 Jan 2002 17:09:38 -0500
Received: from zeus.kernel.org ([204.152.189.113]:2750 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S290657AbSA3WJU>;
	Wed, 30 Jan 2002 17:09:20 -0500
Subject: Re: Oops in bdflush with 2.4.1[4|7]-xfs
From: Austin Gonyou <austin@coremetrics.com>
To: Nathan Poznick <poznick@conwaycorp.net>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020130214108.GA25792@conwaycorp.net>
In-Reply-To: <20020130214108.GA25792@conwaycorp.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-XB4IKG+6EgVjle8B6lmm"
X-Mailer: Evolution/1.0.2 
Date: 30 Jan 2002 16:09:05 -0600
Message-Id: <1012428545.12420.29.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XB4IKG+6EgVjle8B6lmm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Could you see if my XFS-AA patch does anything for you? There are
changes to bdflush in it and I'd be interested to see if they go away.=20

http://www.digitalroadkill.net/Patches/2.4.17-xfs-aa.patch.bz2


On Wed, 2002-01-30 at 15:41, Nathan Poznick wrote:
>=20
> We've got a couple of development machines with hardware raid sets
> that we use XFS on.  A few weeks ago, while running 2.4.14-xfs, there
> was an Oops in bdflush, which caused bdflush to go defunct, and
> kupdated to go into some sort of loop, chewing one of the CPUs.  I
> upgraded the machine to 2.4.17-xfs, and for a few weeks it's been
> fine, but then this afternoon there was again an oops in bdflush,
> which again caused bdflush to go defunct, and kupdated to chew a CPU
> (along with an attempted sync, the shutdown process, etc).  Below is
> the decoded oops.  Any help is appreciated.  Thanks.
>=20
>=20
> ksymoops 0.7c on i686 2.4.17-xfs.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.17-xfs/ (default)
>      -m /boot/System.map-2.4.17-xfs (specified)
>=20
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000030
> c0192fe9
> *pde =3D 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c0192fe9>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010046
> eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
> esi: 00000000   edi: 00000001   ebp: 00000000   esp: c4c49864
> ds: 0018   es: 0018   ss: 0018
> Process bdflush (pid: 6, stackpage=3Dc4c49000)
> Stack: e5187ed8 00000000 00000000 c4c4996c c4c4996c c4c49b68 c4c49b68
> 0b000003=20
>        f3242be0 00000000 00000004 cbf27200 c4c498c8 f3242be0 00000046
> 0b000010=20
>        00000000 00000001 f79fd8f4 00000000 00000016 f71a5400 00000000
> 00000002=20
> Call Trace: [<c0194b68>] [<c018f9ad>] [<c018f746>] [<c01919ce>]
> [<c01a103e>]
>    [<c021a41e>] [<c02208d2>] [<c022004a>] [<c0220244>] [<c02204b1>]
> [<c0238573>]=20
>    [<c01ad063>] [<c01ad063>] [<c01a34b3>] [<c01a515f>] [<c0238573>]
> [<c01d12fb>]=20
>    [<c01d23a6>] [<c01efd74>] [<c012b965>] [<c012b9ac>] [<c012c270>]
> [<c01edcf3>]=20
>    [<c0182854>] [<c018188b>] [<c01edc78>] [<c01ede8b>] [<c01edc78>]
> [<c0133745>]=20
>    [<c0133909>] [<c01369a4>] [<c0105000>] [<c01055db>]=20
> Code: 8b 52 30 89 54 24 58 51 55 8b 44 24 60 50 8b 54 24 78 52 e8=20
>=20
> >>EIP; c0192fe9 <pagebuf_lookup+79/8c>   <=3D=3D=3D=3D=3D
> Trace; c0194b68 <_pagebuf_handle_iovecs+dc/f0>
> Trace; c018f9ad <nlm4svc_callback+19/98>
> Trace; c018f746 <nlm4svc_proc_unshare+2/bc>
> Trace; c01919ce <devpts_root_readdir+12e/134>
> Trace; c01a103e <xfs_dm_punch_hole+1e/27c>
> Trace; c021a41e <vt_ioctl+6ce/2050>
> Trace; c02208d2 <do_con_trol+996/e28>
> Trace; c022004a <do_con_trol+10e/e28>
> Trace; c0220244 <do_con_trol+308/e28>
> Trace; c02204b1 <do_con_trol+575/e28>
> Trace; c0238573 <scsi_init_cmd_errh+a7/e0>
> Trace; c01ad063 <xfs_attr_leaf_toosmall+1af/244>
> Trace; c01ad063 <xfs_attr_leaf_toosmall+1af/244>
> Trace; c01a34b3 <xfs_alloc_ag_vextent_exact+9b/178>
> Trace; c01a515f <xfs_alloc_read_agf+93/23c>
> Trace; c0238573 <scsi_init_cmd_errh+a7/e0>
> Trace; c01d12fb <xfs_dir2_block_to_sf+f3/2f8>
> Trace; c01d23a6 <xfs_dir2_sf_lookup+c6/280>
> Trace; c01efd74 <xfs_trans_init+1384/1f30>
> Trace; c012b965 <vmalloc_area_pages+35/1b0>
> Trace; c012b9ac <vmalloc_area_pages+7c/1b0>
> Trace; c012c270 <kmem_cache_destroy+7c/fc>
> Trace; c01edcf3 <xfs_rename_target_checks+33/b8>
> Trace; c0182854 <nfsd_cache_init+124/138>
> Trace; c018188b <exp_rootfh+10f/278>
> Trace; c01edc78 <xfs_rename_error_checks+c0/108>
> Trace; c01ede8b <xfs_rename+113/c78>
> Trace; c01edc78 <xfs_rename_error_checks+c0/108>
> Trace; c0133745 <sys_ftruncate+4d/154>
> Trace; c0133909 <sys_truncate64+bd/184>
> Trace; c01369a4 <fsync_inode_buffers+140/18c>
> Trace; c0105000 <_stext+0/0>
> Trace; c01055db <kernel_thread+13/30>
> Code;  c0192fe9 <pagebuf_lookup+79/8c>
> 00000000 <_EIP>:
> Code;  c0192fe9 <pagebuf_lookup+79/8c>   <=3D=3D=3D=3D=3D
>    0:   8b 52 30                  mov    0x30(%edx),%edx   <=3D=3D=3D=3D=
=3D
> Code;  c0192fec <pagebuf_lookup+7c/8c>
>    3:   89 54 24 58               mov    %edx,0x58(%esp,1)
> Code;  c0192ff0 <pagebuf_lookup+80/8c>
>    7:   51                        push   %ecx
> Code;  c0192ff1 <pagebuf_lookup+81/8c>
>    8:   55                        push   %ebp
> Code;  c0192ff2 <pagebuf_lookup+82/8c>
>    9:   8b 44 24 60               mov    0x60(%esp,1),%eax
> Code;  c0192ff6 <pagebuf_lookup+86/8c>
>    d:   50                        push   %eax
> Code;  c0192ff7 <pagebuf_lookup+87/8c>
>    e:   8b 54 24 78               mov    0x78(%esp,1),%edx
> Code;  c0192ffb <pagebuf_lookup+8b/8c>
>   12:   52                        push   %edx
> Code;  c0192ffc <pagebuf_readahead+0/3c>
>   13:   e8 00 00 00 00            call   18 <_EIP+0x18> c0193001
> <pagebuf_readahead+5/3c>
--=20
Austin Gonyou
Systems Architect, CCNA
Coremetrics, Inc.
Phone: 512-698-7250
email: austin@coremetrics.com

"It is the part of a good shepherd to shear his flock, not to skin it."
Latin Proverb

--=-XB4IKG+6EgVjle8B6lmm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8WG8B94g6ZVmFMoIRAoM1AJ97bjd1FmZI4HOsvl4qilygZAK+4wCeKySK
Q0RTVd8JHQJsYH65QHgbdq8=
=y6UR
-----END PGP SIGNATURE-----

--=-XB4IKG+6EgVjle8B6lmm--
