Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262527AbSJBSRX>; Wed, 2 Oct 2002 14:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262529AbSJBSRX>; Wed, 2 Oct 2002 14:17:23 -0400
Received: from turing.fb12.de ([80.76.224.45]:62358 "HELO turing.fb12.de")
	by vger.kernel.org with SMTP id <S262527AbSJBSRU>;
	Wed, 2 Oct 2002 14:17:20 -0400
Date: Wed, 2 Oct 2002 20:22:49 +0200
From: Sebastian Benoit <benoit-lists@fb12.de>
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Subject: error "sleeping function called from illegal context" (in 2.5.40)
Message-ID: <20021002202249.A16934@turing.fb12.de>
Mail-Followup-To: Sebastian Benoit <benoit-lists@fb12.de>,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-MSMail-Priority: High
x-gpg-fingerprint: 2999 9839 6C9E E4BF B540  C44B 4EC4 E1BE 5BA2 2F00
x-gpg-key: http://wwwkeys.de.pgp.net:11371
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I get the following errors when playing audio.

loaded ALSA modules are=20

 snd-ens1371            15172   1
 snd-ac97-codec         30960   0 [snd-ens1371]
 snd-rawmidi            18208   0 [snd-ens1371]

kernel 2.5.40 with PREEMPT
=2Econfig is attached.

Oct  2 15:03:02 ronja kernel: Debug: sleeping function called from illegal =
context at slab.c:1374
Oct  2 15:03:02 ronja kernel: d5b0bf4c c01148b6 c02d9940 c02db8a2 0000055e =
000001d0 c012f7e1 c02db8a2=20
Oct  2 15:03:02 ronja kernel:        0000055e d7ffa228 d5b08f24 d5b0a000 d6=
d67064 c012974e d6d67064 d5b08f24=20
Oct  2 15:03:02 ronja kernel:        d5b6ece4 00000000 00000400 00000001 d6=
dbf660 c010b833 00000080 000001d0=20
Oct  2 15:03:02 ronja kernel: Call Trace:
Oct  2 15:03:02 ronja kernel:  [<c01148b6>]__might_sleep+0x56/0x60
Oct  2 15:03:02 ronja kernel:  [<c012f7e1>]kmalloc+0x61/0x220
Oct  2 15:03:02 ronja kernel:  [<c012974e>]do_munmap+0x10e/0x120
Oct  2 15:03:02 ronja kernel:  [<c010b833>]sys_ioperm+0x83/0x120
Oct  2 15:03:02 ronja kernel:  [<c01071df>]syscall_call+0x7/0xb
Oct  2 15:03:02 ronja kernel:=20
Oct  2 15:03:04 ronja kernel: MTRR: setting reg 3
Oct  2 15:03:06 ronja last message repeated 6 times
Oct  2 15:09:06 ronja kernel: Debug: sleeping function called from illegal =
context at /opt/home/benoit/src/kernel/linux-2.5.40/include/asm/semaphore.h=
:119
Oct  2 15:09:06 ronja kernel: d1659c3c c01148b6 c02d9940 c02d3a80 00000077 =
d76ca7ac c0267ed8 c02d3a80=20
Oct  2 15:09:06 ronja kernel:        00000077 00000000 d6f0be00 d1658000 00=
000000 d76ca7ac d75186fc c0269d11=20
Oct  2 15:09:06 ronja kernel:        d76ca7ac d1658000 00000000 c026a124 d7=
6ca7ac 00004140 00000000 00000000=20
Oct  2 15:09:06 ronja kernel: Call Trace:
Oct  2 15:09:06 ronja kernel:  [<c01148b6>]__might_sleep+0x56/0x60
Oct  2 15:09:06 ronja kernel:  [<c0267ed8>]snd_pcm_prepare+0x28/0x200
Oct  2 15:09:06 ronja kernel:  [<c0269d11>]snd_pcm_common_ioctl1+0x1d1/0x2a0
Oct  2 15:09:06 ronja kernel:  [<c026a124>]snd_pcm_playback_ioctl1+0x344/0x=
360
Oct  2 15:09:06 ronja kernel:  [<c025e59c>]snd_pcm_oss_get_formats+0x1c/0xd0
Oct  2 15:09:06 ronja kernel:  [<c0112cf4>]try_to_wake_up+0x144/0x150
Oct  2 15:09:06 ronja kernel:  [<c01135b1>]default_wake_function+0x21/0x40
Oct  2 15:09:06 ronja kernel:  [<c012f7e1>]kmalloc+0x61/0x220
Oct  2 15:09:06 ronja kernel:  [<c0112cf4>]try_to_wake_up+0x144/0x150
Oct  2 15:09:06 ronja kernel:  [<c01135b1>]default_wake_function+0x21/0x40
Oct  2 15:09:06 ronja kernel:  [<c012ad2e>]find_get_page+0x1e/0x40
Oct  2 15:09:06 ronja kernel:  [<c012ba02>]filemap_nopage+0xf2/0x250
Oct  2 15:09:06 ronja kernel:  [<c013a347>]page_add_rmap+0xb7/0x130
Oct  2 15:09:06 ronja kernel:  [<c0128338>]do_no_page+0x238/0x2b0
Oct  2 15:09:06 ronja kernel:  [<c012841e>]handle_mm_fault+0x6e/0x110
Oct  2 15:09:06 ronja kernel:  [<c026a4f7>]snd_pcm_kernel_playback_ioctl+0x=
27/0x30
Oct  2 15:09:06 ronja kernel:  [<c025dab5>]snd_pcm_oss_prepare+0x15/0x30
Oct  2 15:09:07 ronja kernel:  [<c025db08>]snd_pcm_oss_make_ready+0x38/0x50
Oct  2 15:09:07 ronja kernel:  [<c025e2ab>]snd_pcm_oss_sync+0x1b/0x1a0
Oct  2 15:09:07 ronja kernel:  [<c025f54b>]snd_pcm_oss_release+0x1b/0x90
Oct  2 15:09:07 ronja kernel:  [<c013dc6b>]__fput+0x2b/0xe0
Oct  2 15:09:07 ronja kernel:  [<c014cb02>]sys_select+0x492/0x4a0
Oct  2 15:09:07 ronja kernel:  [<c013c318>]filp_close+0x98/0xb0
Oct  2 15:09:07 ronja kernel:  [<c013c389>]sys_close+0x59/0x80
Oct  2 15:09:07 ronja kernel:  [<c01071df>]syscall_call+0x7/0xb
Oct  2 15:09:07 ronja kernel:=20
Oct  2 15:09:40 ronja kernel: Debug: sleeping function called from illegal =
context at page_alloc.c:325
Oct  2 15:09:40 ronja kernel: d0ffbe98 c01148b6 c02d9940 c02db955 00000145 =
00000000 c0132633 c02db955=20
Oct  2 15:09:40 ronja kernel:        00000145 00000000 00000000 000001d0 00=
000000 00000000 000001d0 d17f3218=20
Oct  2 15:09:40 ronja kernel:        d6643ca8 c013287a 00000000 d0ffbf54 c0=
14c293 d76ca7ac d6643c00 00000000=20
Oct  2 15:09:40 ronja kernel: Call Trace:
Oct  2 15:09:40 ronja kernel:  [<c01148b6>]__might_sleep+0x56/0x60
Oct  2 15:09:40 ronja kernel:  [<c0132633>]__alloc_pages+0x23/0x240
Oct  2 15:09:40 ronja kernel:  [<c013287a>]__get_free_pages+0x2a/0x70
Oct  2 15:09:40 ronja kernel:  [<c014c293>]__pollwait+0x33/0xa0
Oct  2 15:09:40 ronja kernel:  [<c025fe96>]snd_pcm_oss_poll+0x46/0x100
Oct  2 15:09:40 ronja kernel:  [<c014c519>]do_select+0x139/0x260
Oct  2 15:09:40 ronja kernel:  [<c014c9a9>]sys_select+0x339/0x4a0
Oct  2 15:09:40 ronja kernel:  [<c014b449>]sys_fcntl64+0x89/0x90
Oct  2 15:09:40 ronja kernel:  [<c01071df>]syscall_call+0x7/0xb
Oct  2 15:09:40 ronja kernel:=20
Oct  2 15:09:41 ronja kernel: Debug: sleeping function called from illegal =
context at page_alloc.c:325
Oct  2 15:09:41 ronja kernel: d0fc5e98 c01148b6 c02d9940 c02db955 00000145 =
00000000 c0132633 c02db955=20
Oct  2 15:09:41 ronja kernel:        00000145 4216c008 00000000 000001d0 c0=
000000 00000000 000001d0 d17f3218=20
Oct  2 15:09:41 ronja kernel:        d6643ca8 c013287a 00000000 d0fc5f54 c0=
14c293 d76ca7ac d6643c00 00000000=20
Oct  2 15:09:41 ronja kernel: Call Trace:
Oct  2 15:09:41 ronja kernel:  [<c01148b6>]__might_sleep+0x56/0x60
Oct  2 15:09:41 ronja kernel:  [<c0132633>]__alloc_pages+0x23/0x240
Oct  2 15:09:41 ronja kernel:  [<c013287a>]__get_free_pages+0x2a/0x70
Oct  2 15:09:41 ronja kernel:  [<c014c293>]__pollwait+0x33/0xa0
Oct  2 15:09:41 ronja kernel:  [<c025fe96>]snd_pcm_oss_poll+0x46/0x100
Oct  2 15:09:41 ronja kernel:  [<c014c519>]do_select+0x139/0x260
Oct  2 15:09:41 ronja kernel:  [<c014c9a9>]sys_select+0x339/0x4a0
Oct  2 15:09:41 ronja kernel:  [<c01071df>]syscall_call+0x7/0xb
Oct  2 15:09:41 ronja kernel:=20

and so on until playing stops ...
a little bit annoying because the rhythm of the logfile being written is not
in sync with the music :-)

/B.
--=20
Sebastian Benoit <benoit-lists@fb12.de>
My mail is GnuPG signed -- Unsigned ones are bogus -- http://www.gnupg.org/
GnuPG 0x5BA22F00 2001-07-31 2999 9839 6C9E E4BF B540  C44B 4EC4 E1BE 5BA2 2=
F00

"I have no respect for a man who can only spell a word one way!" -- Mark Tw=
ain

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2bOXkACgkQTsThvluiLwCSIgCcCp0i5f3No5rYf3PjjEZOQmOF
kkYAn3OXB7j/lgcrbeNasOXaRecnnmDV
=vG7D
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
