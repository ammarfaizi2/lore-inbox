Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTJUV1C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 17:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263378AbTJUV1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 17:27:01 -0400
Received: from mout0.freenet.de ([194.97.50.131]:16028 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S263355AbTJUV00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 17:26:26 -0400
Date: Tue, 21 Oct 2003 23:27:27 +0200
From: Jens Kubieziel <jens@kubieziel.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [test8] Oops after trying to access USB-device /dev/sda
Message-ID: <20031021212727.GL1133@kubieziel.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031021194143.GI1133@kubieziel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <20031021194143.GI1133@kubieziel.de>
Organisation: Qbi's Welt
X-Message-flag: Formating hard disk. please wait...   10%...   20%...
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2003 at 09:41:43PM +0200, Jens Kubieziel wrote:
> after plugging in an USB stick and a 'mount /dev/sda1 /mnt/stick'
> 2.6.0-test8-kernel oopses.

Here comes the output of ksymoops:

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Oct 21 21:09:35 QBI050102 kernel: Unable to handle kernel NULL pointer dere=
ference at virtual address 00000284
Oct 21 21:09:35 QBI050102 kernel: e08a0ded
Oct 21 21:09:35 QBI050102 kernel: *pde =3D 00000000
Oct 21 21:09:35 QBI050102 kernel: Oops: 0000 [#1]
Oct 21 21:09:35 QBI050102 kernel: CPU:    0
Oct 21 21:09:35 QBI050102 kernel: EIP:    0060:[<e08a0ded>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 21 21:09:35 QBI050102 kernel: EFLAGS: 00010282
Oct 21 21:09:35 QBI050102 kernel: eax: e08b62e0   ebx: 00000000   ecx: e08b=
62e4   edx: e08b62e0
Oct 21 21:09:35 QBI050102 kernel: esi: 00000000   edi: df8fbb00   ebp: dffe=
178c   esp: df8db9f8
Oct 21 21:09:35 QBI050102 kernel: ds: 007b   es: 007b   ss: 0068
Oct 21 21:09:35 QBI050102 kernel: Stack: e08b62e0 df8da000 00000000 e089c40=
2 00000000 ca1f9c00 df8da000 e089c3c0=20
Oct 21 21:09:35 QBI050102 kernel: dffe1740 e089ecc0 c0154a5c dffe178c df8db=
b28 00000001 df8dba5c c0118927=20
Oct 21 21:09:35 QBI050102 kernel: c151cc80 dffe174c df8dba64 00000000 dffe1=
740 00000001 df8dbb28 ca1f9c00=20
Oct 21 21:09:35 QBI050102 kernel: Call Trace: [<e089c402>]  [<e089c3c0>]  [=
<c0154a5c>]  [<c0118927>]  [<c0154b3d>]  [<c017c66f>]  [<c0208e9a>]  [<c020=
8e20>]  [<c0208e30>]  [<e089d7c5>]  [<c017d87a>]  [<c0201eaf>]  [<c0201f2f>=
]  [<c020212b>]  [<c0200e41>]  [<e08a86ed>]  [<e08a715d>]  [<e08a7354>]  [<=
e08a7bb1>]  [<e08a7caa>]  [<e08a7da1>]  [<e08a7e0f>]  [<e08ef20f>]  [<e0884=
0e9>]  [<c0201eaf>]  [<c0201f2f>]  [<c020212b>]  [<c0200e41>]  [<e088ba08>]=
  [<e0885260>]  [<e0887906>]  [<e0887e0d>]  [<e0887efd>]  [<c0109272>]  [<c=
0119780>]  [<e0887ed0>]  [<c0107275>]=20
Oct 21 21:09:35 QBI050102 kernel: Code: 8b 83 84 02 00 00 a8 02 0f 85 97 00=
 00 00 8b 43 10 be 01 00=20


>>EIP; e08a0ded <__crc_sleep_on+2273ae/37314b>   <=3D=3D=3D=3D=3D

>>eax; e08b62e0 <__crc_sleep_on+23c8a1/37314b>
>>ecx; e08b62e4 <__crc_sleep_on+23c8a5/37314b>
>>edx; e08b62e0 <__crc_sleep_on+23c8a1/37314b>
>>edi; df8fbb00 <__crc___ndelay+351a6/62a16>
>>ebp; dffe178c <__crc_iunique+22f2a1/2fd026>
>>esp; df8db9f8 <__crc___ndelay+1509e/62a16>

Trace; e089c402 <__crc_sleep_on+2229c3/37314b>
Trace; e089c3c0 <__crc_sleep_on+222981/37314b>
Trace; c0154a5c <do_open+39c/400>
Trace; c0118927 <try_to_wake_up+a7/160>
Trace; c0154b3d <blkdev_get+7d/a0>
Trace; c017c66f <register_disk+bf/140>
Trace; c0208e9a <add_disk+4a/60>
Trace; c0208e20 <exact_match+0/10>
Trace; c0208e30 <exact_lock+0/20>
Trace; e089d7c5 <__crc_sleep_on+223d86/37314b>
Trace; c017d87a <sysfs_add_file+9a/a0>
Trace; c0201eaf <bus_match+3f/70>
Trace; c0201f2f <device_attach+4f/b0>
Trace; c020212b <bus_add_device+5b/a0>
Trace; c0200e41 <device_add+a1/130>
Trace; e08a86ed <__crc_sleep_on+22ecae/37314b>
Trace; e08a715d <__crc_sleep_on+22d71e/37314b>
Trace; e08a7354 <__crc_sleep_on+22d915/37314b>
Trace; e08a7bb1 <__crc_sleep_on+22e172/37314b>
Trace; e08a7caa <__crc_sleep_on+22e26b/37314b>
Trace; e08a7da1 <__crc_sleep_on+22e362/37314b>
Trace; e08a7e0f <__crc_sleep_on+22e3d0/37314b>
Trace; e08ef20f <__crc_sleep_on+2757d0/37314b>
Trace; e08840e9 <__crc_sleep_on+20a6aa/37314b>
Trace; c0201eaf <bus_match+3f/70>
Trace; c0201f2f <device_attach+4f/b0>
Trace; c020212b <bus_add_device+5b/a0>
Trace; c0200e41 <device_add+a1/130>
Trace; e088ba08 <__crc_sleep_on+211fc9/37314b>
Trace; e0885260 <__crc_sleep_on+20b821/37314b>
Trace; e0887906 <__crc_sleep_on+20dec7/37314b>
Trace; e0887e0d <__crc_sleep_on+20e3ce/37314b>
Trace; e0887efd <__crc_sleep_on+20e4be/37314b>
Trace; c0109272 <ret_from_fork+6/14>
Trace; c0119780 <default_wake_function+0/30>
Trace; e0887ed0 <__crc_sleep_on+20e491/37314b>
Trace; c0107275 <kernel_thread_helper+5/10>

Code;  e08a0ded <__crc_sleep_on+2273ae/37314b>
00000000 <_EIP>:
Code;  e08a0ded <__crc_sleep_on+2273ae/37314b>   <=3D=3D=3D=3D=3D
   0:   8b 83 84 02 00 00         mov    0x284(%ebx),%eax   <=3D=3D=3D=3D=3D
Code;  e08a0df3 <__crc_sleep_on+2273b4/37314b>
   6:   a8 02                     test   $0x2,%al
Code;  e08a0df5 <__crc_sleep_on+2273b6/37314b>
   8:   0f 85 97 00 00 00         jne    a5 <_EIP+0xa5>
Code;  e08a0dfb <__crc_sleep_on+2273bc/37314b>
   e:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  e08a0dfe <__crc_sleep_on+2273bf/37314b>
  11:   be 01 00 00 00            mov    $0x1,%esi


--=20
Jens Kubieziel                                   http://www.kubieziel.de
Cursor, n.:
	One whose program will not run.
		-- Robb Russon

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/laS/Vm02LO4Jd+gRAlRBAKCi3TvVqP/Ey8vV0zcHEtr+VmgiTgCdFufG
h7kBBV19qQ/2iryGxkSUaqk=
=6JPS
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
