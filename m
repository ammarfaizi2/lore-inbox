Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266649AbTAFN4y>; Mon, 6 Jan 2003 08:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266717AbTAFN4x>; Mon, 6 Jan 2003 08:56:53 -0500
Received: from 64-238-252-21.arpa.kmcmail.net ([64.238.252.21]:13984 "EHLO
	kermit.unets.com") by vger.kernel.org with ESMTP id <S266649AbTAFN4w>;
	Mon, 6 Jan 2003 08:56:52 -0500
Subject: High FS Activity Crash
From: Adam Voigt <adam@cryptocomm.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1041861823.13159.21.camel@beowulf.cryptocomm.com>
References: <1041860708.13245.7.camel@beowulf.cryptocomm.com> 
	<1041861020.13159.11.camel@beowulf.cryptocomm.com> 
	<1041861227.13245.14.camel@beowulf.cryptocomm.com> 
	<1041861823.13159.21.camel@beowulf.cryptocomm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Fb9GM2yM/sr5rMWmgB9r"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Jan 2003 09:05:40 -0500
Message-Id: <1041861941.13245.26.camel@beowulf.cryptocomm.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 06 Jan 2003 14:05:29.0494 (UTC) FILETIME=[AB5E7B60:01C2B58C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Fb9GM2yM/sr5rMWmgB9r
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Ok, on my fileserver I'm running Redhat 7.2 with Redhat kernel 2.4.7-10=20
and when I have a large number of people downloading from me at one
time, Samba, ProFTPD, Apache, and SSH all stop responding, and I get the
following in my log, the only thing special I could think about my setup
is I have 3 NIC's bonded together to be load balanced on the same IP,
any ideas?=20

Jan  6 00:42:39 anubis kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000024=20
Jan  6 00:42:39 anubis kernel:  printing eip:=20
Jan  6 00:42:39 anubis kernel: c0135cb0=20
Jan  6 00:42:39 anubis kernel: *pde =3D 00000000=20
Jan  6 00:42:39 anubis kernel: Oops: 0002=20
Jan  6 00:42:39 anubis kernel: CPU:    0=20
Jan  6 00:42:39 anubis kernel: EIP:  =20
0010:[__remove_from_lru_list+32/112]=20
Jan  6 00:42:39 anubis kernel: EIP:    0010:[<c0135cb0>]=20
Jan  6 00:42:39 anubis kernel: EFLAGS: 00010286=20
Jan  6 00:42:39 anubis kernel: eax: 00000000   ebx: ce310cc0   ecx:
ce310cc0   edx: c9b708c0=20
Jan  6 00:42:39 anubis kernel: esi: ce310cc0   edi: ce310cc0   ebp:
00000000   esp: c1427f28=20
Jan  6 00:42:39 anubis kernel: ds: 0018   es: 0018   ss: 0018=20
Jan  6 00:42:39 anubis kernel: Process kswapd (pid: 5,
stackpage=3Dc1427000)=20
Jan  6 00:42:39 anubis kernel: Stack: c0135d8d ce310cc0 00000000
c0138890 ce310cc0 00000003 c1690800 c13f4a64=20
Jan  6 00:42:39 anubis kernel:        00000080 c012cc6a 00000000
c13f4a64 00000000 00000007 c012cfe3 c13f4a64=20
Jan  6 00:42:39 anubis kernel:        00000080 00000000 00000000
0000000d 000093b6 00000000 c0243600 00000000=20
Jan  6 00:42:39 anubis kernel: Call Trace: [__remove_from_queues+45/48]
[try_to_free_buffers+112/272] [try_to_release_page+58/96]
[do_page_launder+851/2112] [page_launder+40/96]=20
Jan  6 00:42:39 anubis kernel: Call Trace: [<c0135d8d>] [<c0138890>]
[<c012cc6a>] [<c012cfe3>] [<c012d4f8>]=20
Jan  6 00:42:39 anubis kernel:    [do_try_to_free_pages+18/96]
[kswapd+94/272] [_stext+0/48] [_stext+0/48] [kernel_thread+38/48]
[kswapd+0/272]=20
Jan  6 00:42:39 anubis kernel:    [<c012d922>] [<c012d9ce>] [<c0105000>]
[<c0105000>] [<c0105716>] [<c012d970>]=20
Jan  6 00:42:39 anubis kernel:=20
Jan  6 00:42:39 anubis kernel: Code: 89 50 24 8b 44 24 08 8d 14 85 00 00
00 00 39 8a 6c 21 2b c0=20

--=20
Adam Voigt (adam@cryptocomm.com)
The Cryptocomm Group
My GPG Key: http://64.238.252.49:8080/adam_at_cryptocomm.asc

--=-Fb9GM2yM/sr5rMWmgB9r
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+GY00F9k9BmZXCWYRAudLAKC4Tvu+BLR+FosY5kiGR07bb5ttIQCfW592
V+DeekM4dwVmUdW4iYS3+uQ=
=uueD
-----END PGP SIGNATURE-----

--=-Fb9GM2yM/sr5rMWmgB9r--

