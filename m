Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTLXVsx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 16:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbTLXVsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 16:48:53 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:40141 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S263893AbTLXVsu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 16:48:50 -0500
Subject: Re: PPP ooopses on 2.6.0-mm1
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: kde@myrealbox.com
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200312241121.56934.kde@myrealbox.com>
References: <200312241121.56934.kde@myrealbox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zZIeCOmRTmDF6XYHV4q4"
Message-Id: <1072302658.6600.10.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Dec 2003 23:50:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zZIeCOmRTmDF6XYHV4q4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-12-24 at 11:21, ismail 'cartman' d=F6nmez wrote:
> Hi all,
>=20
> Here is what I get from syslog :
>=20
>=20
> Dec 24 11:09:51 southpark kernel: Unable to handle kernel NULL pointer de=
reference at virtual address 00000065
> Dec 24 11:09:51 southpark kernel: Unable to handle kernel NULL pointer de=
reference at virtual address 00000065
> Dec 24 11:09:51 southpark kernel:  printing eip:
> Dec 24 11:09:51 southpark kernel: e500dfcb
> Dec 24 11:09:51 southpark kernel: *pde =3D 00000000
> Dec 24 11:09:51 southpark kernel: *pde =3D 00000000
> Dec 24 11:09:51 southpark kernel: Oops: 0000 [#1]
> Dec 24 11:09:51 southpark kernel: PREEMPT
> Dec 24 11:09:51 southpark kernel: CPU:    0
> Dec 24 11:09:51 southpark kernel: EIP:    0060:[_end+617343539/1070258792=
]    Not tainted VLI
> Dec 24 11:09:51 southpark kernel: EFLAGS: 00010002
> Dec 24 11:09:51 southpark kernel: EIP is at process_input_packet+0x6b/0x2=
30 [ppp_async]
> Dec 24 11:09:51 southpark kernel: eax: d5156c00   ebx: 0000007e   ecx: da=
e99310   edx: 00000000
> Dec 24 11:09:51 southpark kernel: esi: 00000001   edi: dae99710   ebp: d5=
156c00   esp: e3f8dee8
> Dec 24 11:09:51 southpark kernel: ds: 007b   es: 007b   ss: 0068
> Dec 24 11:09:51 southpark kernel: Process events/0 (pid: 3, threadinfo=3D=
e3f8c000 task=3Dc15cecc0)
> Dec 24 11:09:51 southpark kernel: Stack: c02a151c c15cecc0 e3fedc28 dae99=
0bc e3f8df70 0000007e 00000001 dae99710
> Dec 24 11:09:51 southpark kernel:        00000002 e500e34c d5156c00 0000f=
18b c029fa60 e3f8c000 00000286 d5156c00
> Dec 24 11:09:51 southpark kernel:        dae99000 e500d522 d5156c00 dae99=
310 dae99710 00000008 dae99000 00000008
> Dec 24 11:09:51 southpark kernel: Call Trace:
> Dec 24 11:09:51 southpark kernel:  [_end+617344436/1070258792] ppp_async_=
input+0x1bc/0x340 [ppp_async]
> Dec 24 11:09:51 southpark kernel:  [_end+617340810/1070258792] ppp_asynct=
ty_receive+0x52/0xd0 [ppp_async]
> Dec 24 11:09:51 southpark kernel:  [flush_to_ldisc+156/272] flush_to_ldis=
c+0x9c/0x110
> Dec 24 11:09:51 southpark kernel:  [worker_thread+477/720] worker_thread+=
0x1dd/0x2d0
> Dec 24 11:09:51 southpark kernel:  [flush_to_ldisc+0/272] flush_to_ldisc+=
0x0/0x110
> Dec 24 11:09:51 southpark kernel:  [default_wake_function+0/32] default_w=
ake_function+0x0/0x20
> Dec 24 11:09:51 southpark kernel:  [ret_from_fork+6/20] ret_from_fork+0x6=
/0x14
> Dec 24 11:09:51 southpark kernel:  [default_wake_function+0/32] default_w=
ake_function+0x0/0x20
> Dec 24 11:09:51 southpark kernel:  [worker_thread+0/720] worker_thread+0x=
0/0x2d0
> Dec 24 11:09:51 southpark kernel:  [kernel_thread_helper+5/16] kernel_thr=
ead_helper+0x5/0x10
> Dec 24 11:09:51 southpark kernel:
> Dec 24 11:09:51 southpark kernel: Code: 89 d0 c1 e8 08 32 13 43 0f b6 d2 =
0f b7 94 12 40 f3 00 e5 31 c2 49 75 e8 81 fa b8 f0 00 00 74 4e c7 45 08 04 =
00 00 00 85 f6 74 25 <8b> 4e 64 85 c9 74 1e 8b 56 68 85 d2 75 1f c7 46 64 0=
0 00 00 00
> Dec 24 11:09:51 southpark kernel:  <6>note: events/0[3] exited with preem=
pt_count 1
>=20
>=20
> This somehow freezes X too. Anyone seen similar problems?

Yep, its a patch I have here as:

  ppp_async-callable-from-hard-interrupt.patch

that is prob in -mm as well (Andrew? - sorry, did not check).  I
cant remember where I got it, but I have had it around until yesterday
when at parents and have to use ppp again (in hope of fixing some other
issue that is prob the binary-only drivers problem :/).  I am not sure
if it may be interaction between Greg's latest tty patches (which I
have in my 'tree' as well), or if it is just broken for some setups (usb
modem with binary only driver over here) - I may try to test this theory
tomorrow if somebody do not beat me to it.


Cheers,

--=20
Martin Schlemmer

--=-zZIeCOmRTmDF6XYHV4q4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/6gpCqburzKaJYLYRAi+dAJwICh10Yjxg1HU+EnmwAKLEQJgAQQCdG2/s
enQx/iYp5ROa9nYDyty1SO8=
=WyMA
-----END PGP SIGNATURE-----

--=-zZIeCOmRTmDF6XYHV4q4--

