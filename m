Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030178AbWCTT64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030178AbWCTT64 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030180AbWCTT64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:58:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:5306 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030178AbWCTT6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:58:54 -0500
X-Authenticated: #2308221
Date: Mon, 20 Mar 2006 20:58:46 +0100
From: Christian Trefzer <ctrefzer@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: What is this: "release_dev: driver.table[6] not tty for (tty7)" ?
Message-ID: <20060320195846.GA3211@zeus.uziel.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

does anyone have an idea where this could come from? I used the same wicked
patchset as usual when building this 2.6.16-rc6 custom tree a few days ago,=
 but
the thing oopses on me all the time. The funny part is that a -rc5 built ex=
actly
the same way did not indulge in such inappropriate behaviour, so I figured =
the
gurus should have a chance of a look at this.

I have to admit that I played with some more recent compiler flags that came
with gcc-4.1, and am yet trying to narrow it down by cutting down the numbe=
r of
patches added to vanilla, leaving cflag mods out altogether for the time be=
ing.
But, as stated above, same insanity added to -rc5 was perfectly smooth, -rc=
6 and
release 2.6.16 (plus my wicked patches) screw up.


This is the log excerpt from the last time my laptop became unusable becaus=
e of
this, I merely switched from X to console and tried to login:

-snip-
login(pam_unix)[10265]: session opened for user ctrefzer by (uid=3D0)
release_dev: driver.table[6] not tty for (tty7)
Warning: dev (tty7) tty->count(1) !=3D #fd's(0) in do_tty_hangup
Unable to handle kernel paging request at virtual address 0000e22e
printing eip:
c0197f99
*pde =3D 07960067
*pte =3D 00000000
Oops: 0000 [#1]
PREEMPT=20
Modules linked in: parport_pc parport 8250_pnp 8250 serial_core floppy snd_=
nm256 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd soun=
dcore rtl8150 uhci_hcd pcmcia firmware_class yenta_socket rsrc_nonstatic pc=
mcia_core intel_agp agpgart usbcore xfs exportfs ext2 sg sr_mod cdrom evdev=
 psmouse i8k rtc tun reiser4 dm_mod ata_piix libata sd_mod scsi_mod unix
CPU:    0
EIP:    0060:[<c0197f99>]    Not tainted VLI
EFLAGS: 00010202   (2.6.16 #1)=20
EIP is at 0xc0197f99
eax: c6775400   ebx: 0000e17a   ecx: c662aeec   edx: 00000000
esi: c7f0b600   edi: c02b9460   ebp: 00000001   esp: c662aea0
ds: 007b   es: 007b   ss: 0068
Process X (pid: 10350, threadinfo=3Dc662a000 task=3Dc7b9d0b0)
Stack: <0>c6e54ba0 c662aeec 00000000 c71bcd60 c662a000 c662af50 ffffffe9 c6=
62af50=20
c015c524 c6acc000 00000287 c7f0b600 c71bcd60 c02b9460 00000001 c019a908=20
00400000 00000001 00000000 c01569b2 00000000 c71bcd60 c02b9460 00000000=20
Call Trace:
[<c0101135>] syscall_call+0x7/0xb
Code: c0 89 c7 74 14 8b 53 20 85 d2 0f 84 f8 00 00 00 89 d8 ff d2 e9 ef 00 =
00 00 8b 44 24 0c e8 76 f5 ff ff 89 d8 e8 6f f5 ff ff eb 47 <8b> 83 b4 00 0=
0 00 84 c0 78 4a 81 7e 74 04 00 01 00 75 15 83 bb=20
-snap-


Any further info required I'll gladly provide. Thanks a bunch for your time!

Chris

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRB8Jdl2m8MprmeOlAQJrzA/+M4jswPY0AaTZV3d/q97OF+7R1XzeIyRu
2yUWVribwxhJbhjP8l+URfE4azIC1bpMCT8AxazbXxqSIZ+1sDWEJfKMZ4fmfumb
N2/tSE7tfqWIFeFvPn+VRsUZTlbzF0OrEYHNzLH7bX2llSNMEZCr2fcmemAuamTp
yVR31Y8Af50vn1DZks4iF//pkG5f5XhT+Uu+bA13QheQkNO1lDhcQ6Uo5lrHIFXO
ggsm1f1l7ukocvroEKjznK3p45LJ4JE0ustKiFES4Jg/29J5EttwsbxRJynfJBIG
jT68LUuVejUjX0dtvnULWPdnlt6SKwjikGvQ2NRLc1koRD96IcAZSa2Cs/wX620o
4v5nC1NIsLUL0bfwH5Op9YdPjtE9tP6vsUgoriPJaAZvl33IIEHKOVif6NI7U533
KSG8YPfPp7Km1Yr3nUhV+sBwMpExhz9T50oaJFKHIkr2z48vHWiEQXBYMz3nNalS
ArCczGRYikSkOgY+nzALOiqWdGC3wLHk3GOg2yd0z7iR6TB9h8jrOjukuB2msumi
4BK0IJy0kbEp1kCgwYsEnKndLsA0a44q0qHtIGidnG0c7mLwQSfahqI6dGY9ZsQ9
ZalEnQ/Pl7kVy0I9X+mWs4oSSO7LhlICjEv/PhCuc/LeQ9NyeGt6vXxkgCZlza9w
wYs8dxsbObo=
=JXt+
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--

