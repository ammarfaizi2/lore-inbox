Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268739AbUJPOSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268739AbUJPOSU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 10:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268737AbUJPOSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 10:18:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:53890 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268739AbUJPOSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 10:18:15 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
Date: Sat, 16 Oct 2004 16:21:30 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
In-Reply-To: <20041015102633.GA20132@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3242073.n9SZ12vVT8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410161621.34657.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3242073.n9SZ12vVT8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 15 October 2004 12:26, Ingo Molnar wrote:
> i have released the -U3 PREEMPT_REALTIME patch:
>
> =20
> http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm=
1-
>U3

i'm not sure if this bug depends on preemption patch, or if it is a general=
=20
one in -mm1 tree.

kernel BUG at fs/fat/cache.c:150!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: ipx p8022 psnap llc nvidia snd_mixer_oss sd_mod tda9887=
=20
tuner saa7134 video_buf v4l2_common v4l1_compat ir_common videodev 8139too=
=20
sis900 crc32 ehci_hcd usb_storage scsi_mod ohci_hcd usbcore snd_intel8x0=20
snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ohci1394=20
ieee1394 i2c_sis96x i2c_core
CPU:    0
EIP:    0060:[<c01a0b53>]    Tainted: P      VLI
EFLAGS: 00210202   (2.6.9-rc4-mm1-vp-u3)
EIP is at fat_cache_add+0x135/0x151
eax: 00000001   ebx: cf5712b8   ecx: c656f780   edx: cf571201
esi: ce414c50   edi: c656f768   ebp: c656f7b8   esp: ce414c1c
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process mplayer (pid: 9843, threadinfo=3Dce414000 task=3Dc8128a20)
Stack: c656f7b8 ce414c88 cf785800 00000001 c656f768 c01a11bb ce414c88 ce414=
c8c
       c6d06300 00000000 c8128a20 0003ffff c656f7b8 00000000 00000000 00000=
001
       000db50e c656f7b8 c656f768 cf785800 cee1d800 c01a12c1 ce414c8c 00200=
246
Call Trace:
 [<c01a11bb>] fat_get_cluster+0x11f/0x1de
 [<c01a12c1>] fat_bmap_cluster+0x47/0x98
 [<c01a13f1>] fat_bmap+0xdf/0x101
 [<c01a36e8>] fat_get_block+0x30/0x198
 [<c0152866>] alloc_buffer_head+0x33/0x52
 [<c01501ea>] create_buffers+0x51/0x86
 [<c015141c>] block_read_full_page+0x1bd/0x2cc
 [<c01a36b8>] fat_get_block+0x0/0x198
 [<c0132f0c>] add_to_page_cache+0x58/0x6e
 [<c013a0e4>] read_pages+0xbe/0x15e
 [<c013a49c>] do_page_cache_readahead+0x120/0x19b
 [<c013a606>] page_cache_readahead+0xef/0x1f8
 [<c01336ab>] do_generic_mapping_read+0x133/0x54b
 [<c013c911>] lru_cache_add+0xd/0x4f
 [<c0133d53>] __generic_file_aio_read+0x1a3/0x218
 [<c0133ac3>] file_read_actor+0x0/0xed
 [<c0133ec5>] generic_file_read+0x9c/0xba
 [<c012b84c>] _mutex_lock+0x20/0x36
 [<c01244c8>] do_sigaction+0x1dc/0x1f7
 [<c012b468>] autoremove_wake_function+0x0/0x43
 [<c012b84c>] _mutex_lock+0x20/0x36
 [<c0167974>] dnotify_parent+0x35/0x95
 [<c014e0a9>] vfs_read+0xcd/0x126
 [<c014e36f>] sys_read+0x41/0x6a
 [<c0103f7b>] syscall_call+0x7/0xb
Code: f2 89 e8 e8 9f fe ff ff 85 c0 89 c3 74 2a 83 6f 20 01 8b 04 24 39 00 =
75=20
24 8b 14 24 a1 74 0b 3c c0 e8 9c b1 f9 ff e9 40 ff ff ff <0f> 0b 96 00 e5 b=
7=20
2d c0 e9 2f ff ff ff 8b 1c 24 eb 88 0f 0b 48
 <5>Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0

best regards,
dominik

--nextPart3242073.n9SZ12vVT8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQCVAwUAQXEubgvcoSHvsHMnAQIgtAP9FqrkBn//VEuMQH5Xfi8bFU2/bwRjsUy6
0/pmBa+CwvIaFTXyQZQGCexMib6GKK8fCC6JSd5zWdWmzp/tgfPHeqO6ibZtc8Tm
ol6xdMAqxgEW8ta1TC1GA3B1IY2KPa7rPFQpazHmkeNZs9/DmJ+1+dMOTOLRUbu2
d82GQrVD6LM=
=S2jR
-----END PGP SIGNATURE-----

--nextPart3242073.n9SZ12vVT8--
