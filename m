Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312358AbSDXQDA>; Wed, 24 Apr 2002 12:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312364AbSDXQC7>; Wed, 24 Apr 2002 12:02:59 -0400
Received: from mail.gmx.de ([213.165.64.20]:1955 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S312358AbSDXQC6>;
	Wed, 24 Apr 2002 12:02:58 -0400
Date: Wed, 24 Apr 2002 18:01:21 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: dalecki@evision-ventures.com, vojtech@suse.cz
Subject: [2.5.9/2.5.10] ide-scsi oops
Message-Id: <20020424180121.59bddc43.sebastian.droege@gmx.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.vHG1I(hYCCr6rd"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.vHG1I(hYCCr6rd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
I get this nice oops every time I mount a cdrom... the cdrom drive is accessed via ide-scsi (NOT ide-cd)
If you need more informations just ask...

Bye

Unable to handle kernel NULL pointer dereference at virtual address 00000044
c0202d42
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0202d42>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000028   ebx: c03addcc   ecx: 00000000   edx: c03adc00
esi: cee346e0   edi: 0000f008   ebp: 00000000   esp: cdd19d18
ds: 0018   es: 0018   ss: 0018
Stack: c03addcc c03addcc 00000000 0000fc00 c03addcc 00000000 00000001 00000008
       00000297 c03adcd8 c0204201 00000000 c03addcc c03addcc cee346e0 00000000
       c020e553 00000000 c03addcc c03addcc c03addcc 00000000 00000000 c1341200
Call Trace: [<c0204201>] [<c020e553>] [<c020f0ad>] [<c01fc20b>] [<c01e5756>]
   [<c01fc5bf>] [<c01fcdd7>] [<c020efa2>] [<c0206e9b>] [<c0207220>] [<c020cf3c>]
   [<c01e6323>] [<c011a2c2>] [<c0133f32>] [<c0134067>] [<c01282b2>] [<c012a11a>]
   [<c012a018>] [<c013605b>] [<c0106fcf>]
Code: 8b 50 1c 83 e2 01 b8 08 00 00 00 85 d2 0f 45 44 24 14 8b 54


>>EIP; c0202d42 <ide_dmaproc+17a/418>   <=====

>>ebx; c03addcc <ide_hwifs+6cc/3a70>
>>edx; c03adc00 <ide_hwifs+500/3a70>
>>esi; cee346e0 <_end+ea7fa04/1054e324>
>>edi; 0000f008 Before first symbol
>>esp; cdd19d18 <_end+d96503c/1054e324>

Trace; c0204201 <piix_dmaproc+b9/c0>
Trace; c020e553 <idescsi_issue_pc+67/208>
Trace; c020f0ad <idescsi_do_request+19/38>
Trace; c01fc20b <start_request+387/474>
Trace; c01e5756 <__elv_next_request+a/10>
Trace; c01fc5bf <ide_queue_commands+157/1b0>
Trace; c01fcdd7 <ide_do_drive_cmd+137/1ac>
Trace; c020efa2 <idescsi_queue+596/5e4>
Trace; c0206e9b <scsi_dispatch_cmd+103/1b8>
Trace; c0207220 <scsi_done+0/b0>
Trace; c020cf3c <scsi_request_fn+54c/568>
Trace; c01e6323 <generic_unplug_device+2b/4c>
Trace; c011a2c2 <__run_task_queue+6a/78>
Trace; c0133f32 <do_page_cache_readahead+152/170>
Trace; c0134067 <page_cache_readahead+117/120>
Trace; c01282b2 <do_generic_file_read+92/480>
Trace; c012a11a <generic_file_read+7e/12c>
Trace; c012a018 <file_read_actor+0/84>
Trace; c013605b <sys_read+8f/118>
Trace; c0106fcf <syscall_call+7/b>

Code;  c0202d42 <ide_dmaproc+17a/418>
00000000 <_EIP>:
Code;  c0202d42 <ide_dmaproc+17a/418>   <=====
   0:   8b 50 1c                  mov    0x1c(%eax),%edx   <=====
Code;  c0202d45 <ide_dmaproc+17d/418>
   3:   83 e2 01                  and    $0x1,%edx
Code;  c0202d48 <ide_dmaproc+180/418>
   6:   b8 08 00 00 00            mov    $0x8,%eax
Code;  c0202d4d <ide_dmaproc+185/418>
   b:   85 d2                     test   %edx,%edx
Code;  c0202d4f <ide_dmaproc+187/418>
   d:   0f 45 44 24 14            cmovne 0x14(%esp,1),%eax
Code;  c0202d54 <ide_dmaproc+18c/418>
  12:   8b 54 00 00               mov    0x0(%eax,%eax,1),%edx

--=.vHG1I(hYCCr6rd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8xtbUe9FFpVVDScsRAnvTAJ9vkPTggJVTy9ABHzJtHxJ8X8xc0gCg60mY
tYQT+TNYeQZHM8ztURV5O8c=
=cuju
-----END PGP SIGNATURE-----

--=.vHG1I(hYCCr6rd--

