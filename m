Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWI0MYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWI0MYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 08:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWI0MYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 08:24:08 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:57244 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1030215AbWI0MYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 08:24:06 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Oops on boot (probably ACPI related)
Date: Wed, 27 Sep 2006 14:24:47 +0200
User-Agent: KMail/1.9.4
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1555872.S9lg5xpVnW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609271424.47824.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1555872.S9lg5xpVnW
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I get this on my machine. SMP kernel, linus git from this morning. .config =
and=20
test available on request.

Eike

BUG: unable to handle kernel paging request at virtual address f0003504
 printing eip:
c102d804
*pde =3D 00000000
Oops: 0000 [#1]
SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c102d804>]    Not tainted VLI
EFLAGS: 00010086   (2.6.18 #3)
EIP is at mark_lock+0x24/0x34c
eax: f00034ec   ebx: c126a674   ecx: 00000001   edx: 00000001
esi: c126a140   edi: 00000000   ebp: c1380e88   esp: c1380e78
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, ti=3Dc1380000 task=3Dc126a140 task.ti=3Dc1380000)
Stack: 00000001 f00034ec 00000018 0000ffff c1380ec4 c102e5ee c11ee67a 00000=
000
       00000000 00000018 c126a140 c126a674 00000000 c126a674 00000000 00000=
001
       00000046 00000018 0000ffff c1380ee4 c102f03a 00000000 00000002 00000=
001
Call Trace:
 [<c102e5ee>] __lock_acquire+0x45e/0x967
 [<c102f03a>] lock_acquire+0x4b/0x6d
 [<c11f15ef>] _spin_lock_irqsave+0x22/0x32
 [<c11ee67a>] __down_trylock+0x12/0x48
 [<c11f0e76>] __down_failed_trylock+0xa/0x10
DWARF2 unwinder stuck at __down_failed_trylock+0xa/0x10

Leftover inexact backtrace:

 [<c10e9362>] acpi_os_wait_semaphore+0x38/0xd7
 [<c10ff1e6>] acpi_ut_acquire_mutex+0x39/0x77
 [<c10f768e>] acpi_ns_get_node+0x42/0x84
 [<c10f64e1>] acpi_ns_root_initialize+0x276/0x2ad
 [<c10fdd23>] acpi_initialize_subsystem+0x38/0x5d
 [<c1397f64>] acpi_early_init+0x4e/0x108
 [<c1384747>] start_kernel+0x376/0x383
 [<00000000>] 0x0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Code: 8d 65 f8 5b 5e 5d c3 55 89 e5 57 56 53 83 ec 04 89 c6 89 d3 89 cf c7 =
45=20
f0 01 00 00 00 d3 65 f0 8b 42 08 ba 01 00 00 00 8b 4d f0 <85> 48 18 0f 85 1=
5=20
03 00 00 f0 fe 0d 9c f8 26 c1 79 0d f3 90 80
EIP: [<c102d804>] mark_lock+0x24/0x34c SS:ESP 0068:c1380e78
 <0>Kernel panic - not syncing: Attempted to kill the idle task!

--nextPart1555872.S9lg5xpVnW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFGm2PXKSJPmm5/E4RAl3bAJ90nDi1/6z0uVGon1BlnQpnSeSxsACeOc3S
8ZUse6+0z/DQkd1zGjjHm0M=
=7FCK
-----END PGP SIGNATURE-----

--nextPart1555872.S9lg5xpVnW--
