Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265177AbTF1M52 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 08:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbTF1M51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 08:57:27 -0400
Received: from main.gmane.org ([80.91.224.249]:61078 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265177AbTF1M5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 08:57:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: 2.4.21 USB oops
Date: Sat, 28 Jun 2003 06:11:57 -0700
Message-ID: <m2smpu73du.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Portable Code, linux)
X-Spammers-Please: blackholeme@rychter.com
Cancel-Lock: sha1:jnVaujEf46ezJz7RpyC7YH6sv1U=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

I got the following oops after doing "modprobe uhci". The system froze
completely about 30 seconds after that.

Before that, I have unloaded uhci, loaded usb-uhci, and then unloaded
usb-uhci again. This could be relevant.

Please contact me if you need more information.

=2D-J.

ksymoops 2.4.5 on i686 2.4.21.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21/ (default)
     -m /boot/bzI-2.4.21-a20030523s10p12l.map (specified)

Jun 28 03:20:20 tnuctip kernel: kernel BUG at slab.c:815!
Jun 28 03:20:20 tnuctip kernel: invalid operand: 0000
Jun 28 03:20:20 tnuctip kernel: CPU:    0
Jun 28 03:20:20 tnuctip kernel: EIP:    0010:[<c013267d>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 28 03:20:20 tnuctip kernel: EFLAGS: 00010246
Jun 28 03:20:20 tnuctip kernel: eax: 00000000   ebx: c12c7bb0   ecx: c12c7c=
18   edx: c12c7ba8
Jun 28 03:20:20 tnuctip kernel: esi: c12c7ba2   edi: d083bd1a   ebp: 000000=
3c   esp: ce159eec
Jun 28 03:20:20 tnuctip kernel: ds: 0018   es: 0018   ss: 0018
Jun 28 03:20:20 tnuctip kernel: Process modprobe (pid: 19676, stackpage=3Dc=
e159000)
Jun 28 03:20:20 tnuctip kernel: Stack: fffffff4 00000001 d0836000 00006b90 =
ce159f08 c12c7bd0 00000004 0000001c=20
Jun 28 03:20:20 tnuctip kernel:        d083a7c0 d083bd0c 0000003c 00000020 =
00020000 00000000 00000000 00000001=20
Jun 28 03:20:20 tnuctip kernel:        c0117361 ce158000 00000000 00000013 =
bfffc178 d0836000 00005d48 c2d4b000=20
Jun 28 03:20:20 tnuctip kernel: Call Trace:    [<d083a7c0>] [<d083bd0c>] [<=
c0117361>] [<d0836060>] [<c01086df>]
Jun 28 03:20:20 tnuctip kernel: Code: 0f 0b 2f 03 40 8a 24 c0 8b 12 8b 02 0=
f 18 00 81 fa 08 ae 28=20


>>EIP; c013267d <kmem_cache_create+2f9/344>   <=3D=3D=3D=3D=3D

>>ebx; c12c7bb0 <_end+fca3d8/1050c888>
>>ecx; c12c7c18 <_end+fca440/1050c888>
>>edx; c12c7ba8 <_end+fca3d0/1050c888>
>>esi; c12c7ba2 <_end+fca3ca/1050c888>
>>edi; d083bd1a <[mousedev].bss.end+7a63/42da9>
>>esp; ce159eec <_end+de5c714/1050c888>

Trace; d083a7c0 <[mousedev].bss.end+6509/42da9>
Trace; d083bd0c <[mousedev].bss.end+7a55/42da9>
Trace; c0117361 <sys_init_module+569/620>
Trace; d0836060 <[mousedev].bss.end+1da9/42da9>
Trace; c01086df <system_call+33/38>

Code;  c013267d <kmem_cache_create+2f9/344>
00000000 <_EIP>:
Code;  c013267d <kmem_cache_create+2f9/344>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c013267f <kmem_cache_create+2fb/344>
   2:   2f                        das=20=20=20=20
Code;  c0132680 <kmem_cache_create+2fc/344>
   3:   03 40 8a                  add    0xffffff8a(%eax),%eax
Code;  c0132683 <kmem_cache_create+2ff/344>
   6:   24 c0                     and    $0xc0,%al
Code;  c0132685 <kmem_cache_create+301/344>
   8:   8b 12                     mov    (%edx),%edx
Code;  c0132687 <kmem_cache_create+303/344>
   a:   8b 02                     mov    (%edx),%eax
Code;  c0132689 <kmem_cache_create+305/344>
   c:   0f 18 00                  prefetchnta (%eax)
Code;  c013268c <kmem_cache_create+308/344>
   f:   81 fa 08 ae 28 00         cmp    $0x28ae08,%edx


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+/ZQjLth4/7/QhDoRAgtCAKDKShkBg1hUd3A1+564MjsOFtgH7ACeMHbs
cTbR85ZSXWrsio6qtAL2YCo=
=tM51
-----END PGP SIGNATURE-----
--=-=-=--

