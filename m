Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbUKFC0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUKFC0A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 21:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbUKFC0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 21:26:00 -0500
Received: from pop.gmx.net ([213.165.64.20]:51080 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261285AbUKFCZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 21:25:47 -0500
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: Re: 2.6.10-rc1-mm3: modprobe oopses [x86]
Date: Sat, 6 Nov 2004 03:27:05 +0100
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200411060223.26516.bero@arklinux.org>
In-Reply-To: <200411060223.26516.bero@arklinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1141534.nq5e9uisAQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411060327.08766.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1141534.nq5e9uisAQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 06 November 2004 02:23, Bernhard Rosenkraenzer wrote:
> modprobe ohci1394 leads to:
>
> Unable to handle kernel paging request at virtual address e0c00000
> printing eip:
> *pde=3D00000000
> Oops: 0002 [ #1]
> PREEMPT
> Modules linked in: ehci_hcd uhci_hcd usbcore rtc
> CPU: 0
> EIP: 0060:[<c0137d8d>] Not tainted VLI
> EFLAGS: 00010216 (2.6.10-rc1-mm1)
> EIP is at load_module+0x51d/0xb60
>...

my kernel also oopses when trying to load the nvidia driver with insmod:

Unable to handle kernel paging request at virtual address d1400000
 printing eip:
c02dc73f
*pde =3D 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: sd_mod tda9887 tuner saa7134 video_buf v4l2_common=20
v4l1_compat ir_common videodev 8139too sis900 crc32 ehci_hcd usb_storage=20
scsi_mod ohci_hcd usbcore snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd=
=20
soundcore snd_page_alloc ohci1394 ieee1394 i2c_sis96x i2c_core
CPU:    0
EIP:    0060:[__lock_text_end+3019/4642]    Not tainted VLI
EFLAGS: 00010246   (2.6.10-rc1-mm3)
EIP is at __lock_text_end+0xbcb/0x1222
eax: 00000000   ebx: 004f0b9a   ecx: 004c3b9a   edx: b6ecd008
esi: b6efa008   edi: d1400000   ebp: d13d3000   esp: cc296f08
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 3889, threadinfo=3Dcc296000 task=3Dcf821510)
Stack: 00000002 004c3b9a d13d3000 b6ecd008 c01cecce 004f0b9a fffffff2 b7f07=
1bb
       c012f62f 004f0b9a 00000000 cfca8a6c b76ce000 cf824800 00000801 c0146=
278
       cf821510 00000000 cc296f50 cc296f50 00100077 cf84cc7c 00401000 b6ecd=
000
Call Trace:
 [copy_from_user+52/98] copy_from_user+0x34/0x62
 [load_module+130/2324] load_module+0x82/0x914
 [move_vma+232/460] move_vma+0xe8/0x1cc
 [__fput+213/365] __fput+0xd5/0x16d
 [sys_init_module+70/509] sys_init_module+0x46/0x1fd
 [filp_close+72/138] filp_close+0x48/0x8a
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: 88 00 51 50 31 c0 f3 aa 58 59 e9 64 24 ef ff 01 c1 e9 a8 24 ef ff 8d =
4c=20
88 00 e9 9f 24 efff 01 c1 eb 04 8d 4c 88 00 51 50 31 c0 <f3> aa 58 59 e9 ea=
=20
24 ef ff b8 f2 ff ff ff e9 e7 d6 ef ff ba f2

best regards,
dominik

--nextPart1141534.nq5e9uisAQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQCVAwUAQYw2fAvcoSHvsHMnAQKEsQP/cbswQl405r6/OmZvFLgaqetBlAPxHIKC
76GEp9fWgL3iG6gIfPqGpGeqA7PGoZ1VxLdXkECKGlaiRMfm6f1r+fpMhRd5avWC
OFAdlTeljWBhQ4LQ2d72bNEjogwoeYtKUBJxefMF0mtRZ/U5gib3QMWz+3JTmuP2
TnJwE71Bn1o=
=X7RU
-----END PGP SIGNATURE-----

--nextPart1141534.nq5e9uisAQ--
