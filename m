Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266125AbSLISQQ>; Mon, 9 Dec 2002 13:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266128AbSLISQQ>; Mon, 9 Dec 2002 13:16:16 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:42672 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S266125AbSLISQO>; Mon, 9 Dec 2002 13:16:14 -0500
Date: Mon, 9 Dec 2002 19:23:51 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: rui.p.m.sousa@clix.pt
Subject: [OOPS] 2.5.50 Emu10K1 OSS
Message-Id: <20021209192351.070368ef.us15@os.inf.tu-dresden.de>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.6claws66 (GTK+ 1.2.10; Linux 2.5.50)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.sDZIzjkdPdYjsQ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.sDZIzjkdPdYjsQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi,

I just got the following oops under 2.5.50. I have a SB Live with Emu10K1
chip, and I'm using the old OSS drivers in the kernel. This is the first
time it actually oopsed. I've booted the same kernel several times before
without any oddities.

Regards,
-Udo.

ksymoops 2.4.5 on i686 2.5.50.  Options used
     -V (default)                           
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.5.50/ (default)
     -m /boot/System.map-2.5.50 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 000002fc
c029e9a6
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c029e9a6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000002   ebx: ede02000   ecx: edd98444   edx: 00000003
esi: 00000202   edi: efb6d900   ebp: 00000000   esp: ede03f24
ds: 0068   es: 0068   ss: 0068
Stack: edac9bfc edd080c0 effe2500 edf5e640 eddcc6c0 effe2500 edd98444 edac7f40
       c01450e7 edd98444 eddcc6c0 eddcc6c0 00000000 efc5dc80 00000001 c0143494
       eddcc6c0 efc5dc80 00000001 00000004 efc5dc80 c011c0b7 eddcc6c0 efc5dc80
 [<c01450e7>] __fput+0xd7/0xe0
 [<c0143494>] filp_close+0x74/0xa0
 [<c011c0b7>] put_files_struct+0x57/0xc0
 [<c011c76f>] do_exit+0x12f/0x2d0
 [<c011c943>] sys_exit+0x13/0x20
 [<c010926f>] syscall_call+0x7/0xb
Code: 80 bd fc 02 00 00 00 74 11 8b 44 24 0c 80 b8 01 74 00 00 00


>>EIP; c029e9a6 <emu10k1_audio_release+36/1d0>   <=====

>>ebx; ede02000 <END_OF_CODE+2d95e348/????>
>>ecx; edd98444 <END_OF_CODE+2d8f478c/????>
>>edi; efb6d900 <END_OF_CODE+2f6c9c48/????>
>>esp; ede03f24 <END_OF_CODE+2d96026c/????>

Code;  c029e9a6 <emu10k1_audio_release+36/1d0>
00000000 <_EIP>:
Code;  c029e9a6 <emu10k1_audio_release+36/1d0>   <=====
   0:   80 bd fc 02 00 00 00      cmpb   $0x0,0x2fc(%ebp)   <=====
Code;  c029e9ad <emu10k1_audio_release+3d/1d0>
   7:   74 11                     je     1a <_EIP+0x1a>
Code;  c029e9af <emu10k1_audio_release+3f/1d0>
   9:   8b 44 24 0c               mov    0xc(%esp,1),%eax
Code;  c029e9b3 <emu10k1_audio_release+43/1d0>
   d:   80 b8 01 74 00 00 00      cmpb   $0x0,0x7401(%eax)

--=.sDZIzjkdPdYjsQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE99N+7nhRzXSM7nSkRAoAtAJ4oA8jsViE7a2XGSNBfarFueoQI/gCfRRFd
V7jVib7Wcn8FdLkiWi3ZBYA=
=t3x7
-----END PGP SIGNATURE-----

--=.sDZIzjkdPdYjsQ--
