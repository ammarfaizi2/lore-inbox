Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSH1Ql7>; Wed, 28 Aug 2002 12:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317054AbSH1Ql7>; Wed, 28 Aug 2002 12:41:59 -0400
Received: from splat.lanl.gov ([128.165.17.254]:911 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S316608AbSH1Ql4>; Wed, 28 Aug 2002 12:41:56 -0400
Date: Wed, 28 Aug 2002 10:46:16 -0600
From: Eric Weigle <ehw@lanl.gov>
To: linux-xfs@oss.sgi.com,
       "Linux kernel mailing list (lkml)" <linux-kernel@vger.kernel.org>
Subject: 2.4.18-xfs (xfs related?) oops report
Message-ID: <20020828164616.GJ348@lanl.gov>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Eric-Conspiracy: There is no conspiracy
X-Editor: Vim, http://www.vim.org
X-GnuPG-fingerprint: 112E F8CA 12A9 771E DB10  6514 D4B0 D758 59EA 9C4F
X-GnuPG-key: http://public.lanl.gov/ehw/ehw.gpg.key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

FYI-

I'm running a disk server off of three 3Ware RAID cards, set up as three
separate drives. Each runs XFS. Under high load, the machine hard locks and
I can't do anything with it. The past time, it was nice enough to leave a
pair of oopses in the log for me, attached below.

I've also seen corruption in that five 200MB files I was working on have
been truncated to length zero.

Machine is a 2x733Mhz PIII with 768M of good ram (tested; it ran memtest86
for 24 hours with no problems).

Kernel is 2.4.18 vanilla with XFS 1.1.0 patch applied in an attempt to fix
the problem (lockups also seen on an earlier version).

Debian linux, GCC 2.95.4.


Thanks
-Eric

---------------------------------------------------------------------------=
-----

ksymoops 2.4.5 on i686 2.4.18-xfs-1.1.  Options used
     -v /usr/src/linux-2.4.18/vmlinux (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-xfs-1.1/ (default)
     -m /boot/System.map-2.4.18 (specified)

invalid operand: 0000
CPU:    0
EIP:    0010:[<c012e418>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c133781c   ebx: c1819c80   ecx: c1819c80   edx: ee169294
esi: c1819c80   edi: 00000000   ebp: 00000200   esp: c1c25f28
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=3Dc1c25000)
Stack: cc4438c0 c1819c80 0000000a 00000200 c1819c80 000001d0 cc4438c0 c1819=
c80=20
       c012dc32 c012eb18 c012dc79 00000020 000001d0 00000020 00000006 c1c24=
000=20
       c1c24000 0000361a 000001d0 c028d9e8 c012dee2 00000006 00000013 00000=
006=20
Call Trace: [<c012dc32>] [<c012eb18>] [<c012dc79>] [<c012dee2>] [<c012df3f>=
]=20
   [<c012dfd3>] [<c012e02e>] [<c012e13d>] [<c01055a4>]=20
Code: 0f 0b 89 d8 2b 05 6c 5b 30 c0 c1 f8 06 3b 05 60 5b 30 c0 72=20


>>EIP; c012e418 <__free_pages_ok+28/20c>   <=3D=3D=3D=3D=3D

>>eax; c133781c <_end+1008b70/3054d354>
>>ebx; c1819c80 <_end+14eafd4/3054d354>
>>ecx; c1819c80 <_end+14eafd4/3054d354>
>>edx; ee169294 <_end+2de3a5e8/3054d354>
>>esi; c1819c80 <_end+14eafd4/3054d354>
>>esp; c1c25f28 <_end+18f727c/3054d354>

Trace; c012dc32 <shrink_cache+21e/39c>
Trace; c012eb18 <__free_pages+1c/20>
Trace; c012dc79 <shrink_cache+265/39c>
Trace; c012dee2 <shrink_caches+56/7c>
Trace; c012df3f <try_to_free_pages+37/58>
Trace; c012dfd3 <kswapd_balance_pgdat+43/8c>
Trace; c012e02e <kswapd_balance+12/28>
Trace; c012e13d <kswapd+99/b4>
Trace; c01055a4 <kernel_thread+28/38>

Code;  c012e418 <__free_pages_ok+28/20c>
00000000 <_EIP>:
Code;  c012e418 <__free_pages_ok+28/20c>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c012e41a <__free_pages_ok+2a/20c>
   2:   89 d8                     mov    %ebx,%eax
Code;  c012e41c <__free_pages_ok+2c/20c>
   4:   2b 05 6c 5b 30 c0         sub    0xc0305b6c,%eax
Code;  c012e422 <__free_pages_ok+32/20c>
   a:   c1 f8 06                  sar    $0x6,%eax
Code;  c012e425 <__free_pages_ok+35/20c>
   d:   3b 05 60 5b 30 c0         cmp    0xc0305b60,%eax
Code;  c012e42b <__free_pages_ok+3b/20c>
  13:   72 00                     jb     15 <_EIP+0x15> c012e42d <__free_pa=
ges_ok+3d/20c>

invalid operand: 0000
CPU:    1
EIP:    0010:[<c012e440>]    Not tainted
EFLAGS: 00010202
eax: 00000005   ebx: c1818c00   ecx: c1818c00   edx: 00000000
esi: 00000000   edi: 00000000   ebp: ee8cca94   esp: e9715e3c
ds: 0018   es: 0018   ss: 0018
Process rpc.nfsd (pid: 297, stackpage=3De9715000)
Stack: c1818c00 00000000 00000000 ee8cca94 ee8cca94 c012630a c1818c00 c1818=
c00=20
       c01261c3 c012eb18 c0126354 c1818c00 c1818c00 c0126466 c1818c00 00000=
000=20
       e9715eac 00000000 ee8cca94 00000000 00000001 e9715eac 00000000 c0126=
51e=20
Call Trace: [<c012630a>] [<c01261c3>] [<c012eb18>] [<c0126354>] [<c0126466>=
]=20
   [<c012651e>] [<c01b9642>] [<c01bc41b>] [<c0199faa>] [<c01b1663>] [<c01c4=
2d4>]=20
   [<c01c33b7>] [<c0148f23>] [<c0147256>] [<c013ff9d>] [<c014007d>] [<c0106=
e5b>]=20
Code: 0f 0b 8b 43 18 a8 40 74 02 0f 0b 8b 43 18 a8 80 74 02 0f 0b=20


>>EIP; c012e440 <__free_pages_ok+50/20c>   <=3D=3D=3D=3D=3D

>>ebx; c1818c00 <_end+14e9f54/3054d354>
>>ecx; c1818c00 <_end+14e9f54/3054d354>
>>ebp; ee8cca94 <_end+2e59dde8/3054d354>
>>esp; e9715e3c <_end+293e7190/3054d354>

Trace; c012630a <do_flushpage+26/2c>
Trace; c01261c3 <remove_inode_page+27/34>
Trace; c012eb18 <__free_pages+1c/20>
Trace; c0126354 <truncate_complete_page+44/4c>
Trace; c0126466 <truncate_list_pages+10a/174>
Trace; c012651e <truncate_inode_pages+4e/7c>
Trace; c01b9642 <pagebuf_inval+1a/20>
Trace; c01bc41b <fs_tosspages+2b/30>
Trace; c0199faa <xfs_itruncate_start+96/a0>
Trace; c01b1663 <xfs_inactive+1cf/480>
Trace; c01c42d4 <vn_put+44/a0>
Trace; c01c33b7 <linvfs_put_inode+17/1c>
Trace; c0148f23 <iput+37/1d0>
Trace; c0147256 <d_delete+62/a0>
Trace; c013ff9d <vfs_unlink+149/180>
Trace; c014007d <sys_unlink+a9/124>
Trace; c0106e5b <system_call+33/38>

Code;  c012e440 <__free_pages_ok+50/20c>
00000000 <_EIP>:
Code;  c012e440 <__free_pages_ok+50/20c>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c012e442 <__free_pages_ok+52/20c>
   2:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c012e445 <__free_pages_ok+55/20c>
   5:   a8 40                     test   $0x40,%al
Code;  c012e447 <__free_pages_ok+57/20c>
   7:   74 02                     je     b <_EIP+0xb> c012e44b <__free_page=
s_ok+5b/20c>
Code;  c012e449 <__free_pages_ok+59/20c>
   9:   0f 0b                     ud2a  =20
Code;  c012e44b <__free_pages_ok+5b/20c>
   b:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c012e44e <__free_pages_ok+5e/20c>
   e:   a8 80                     test   $0x80,%al
Code;  c012e450 <__free_pages_ok+60/20c>
  10:   74 02                     je     14 <_EIP+0x14> c012e454 <__free_pa=
ges_ok+64/20c>
Code;  c012e452 <__free_pages_ok+62/20c>
  12:   0f 0b                     ud2a  =20

--=20
------------------------------------------------
 Eric H. Weigle -- http://public.lanl.gov/ehw/=20
------------------------------------------------

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9bP5Y1LDXWFnqnE8RAv2eAKDvdMyhqnRY5rYtDat+0bcQMpeO5ACeM7xI
OFVvixghxEhjQVr5v7m9HWE=
=87lA
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
