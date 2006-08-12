Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWHLNVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWHLNVE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 09:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWHLNVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 09:21:04 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:44960 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932508AbWHLNVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 09:21:02 -0400
X-Sasl-enc: 0Et1zm884yCep/jPFJa/kIkUrYmEycP2U8cB4YPvIF3j 1155388860
Message-ID: <44DDD5E5.7010607@imap.cc>
Date: Sat, 12 Aug 2006 15:21:41 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc1/reiserfs INFO: possible recursive locking detected
References: <6vtF8-99-7@gated-at.bofh.it> <44AD9F82.7050006@imap.cc>
In-Reply-To: <44AD9F82.7050006@imap.cc>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6207C281A391789EC8E85D71"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6207C281A391789EC8E85D71
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

FYI, the issue is still present in 2.6.18-rc4 and 2.6.18-rc3-mm2.

Here's one output from 2.6.18-rc4:

> Aug 12 13:10:43 gx110 kernel: [   90.648896] ACPI: Getting cpuindex for=
 acpiid 0x2
> Aug 12 13:10:45 gx110 kernel: [   91.809779]
> Aug 12 13:10:45 gx110 kernel: [   91.809784] =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Aug 12 13:10:45 gx110 kernel: [   91.809807] [ INFO: possible recursive=
 locking detected ]
> Aug 12 13:10:45 gx110 kernel: [   91.809816] --------------------------=
-------------------
> Aug 12 13:10:45 gx110 kernel: [   91.809825] udevd/3770 is trying to ac=
quire lock:
> Aug 12 13:10:45 gx110 kernel: [   91.809834]  (&inode->i_mutex){--..}, =
at: [<c0338e4a>] mutex_lock+0x1c/0x1f
> Aug 12 13:10:45 gx110 kernel: [   91.809884]
> Aug 12 13:10:45 gx110 kernel: [   91.809887] but task is already holdin=
g lock:
> Aug 12 13:10:45 gx110 kernel: [   91.809894]  (&inode->i_mutex){--..}, =
at: [<c0338e4a>] mutex_lock+0x1c/0x1f
> Aug 12 13:10:45 gx110 kernel: [   91.809912]
> Aug 12 13:10:45 gx110 kernel: [   91.809915] other info that might help=
 us debug this:
> Aug 12 13:10:45 gx110 kernel: [   91.809924] 1 lock held by udevd/3770:=

> Aug 12 13:10:45 gx110 kernel: [   91.809931]  #0:  (&inode->i_mutex){--=
=2E.}, at: [<c0338e4a>] mutex_lock+0x1c/0x1f
> Aug 12 13:10:45 gx110 kernel: [   91.809951]
> Aug 12 13:10:45 gx110 kernel: [   91.809953] stack backtrace:
> Aug 12 13:10:45 gx110 kernel: [   91.810671]  [<c0103fa1>] show_trace_l=
og_lvl+0x58/0x15b
> Aug 12 13:10:45 gx110 kernel: [   91.810729]  [<c01050ea>] show_trace+0=
xd/0x10
> Aug 12 13:10:45 gx110 kernel: [   91.810775]  [<c0105104>] dump_stack+0=
x17/0x1b
> Aug 12 13:10:45 gx110 kernel: [   91.810821]  [<c012d979>] __lock_acqui=
re+0x74a/0x9a7
> Aug 12 13:10:45 gx110 kernel: [   91.811065]  [<c012de58>] lock_acquire=
+0x4a/0x6a
> Aug 12 13:10:45 gx110 kernel: [   91.811301]  [<c0338cc7>] __mutex_lock=
_slowpath+0xa7/0x20e
> Aug 12 13:10:45 gx110 kernel: [   91.811526]  [<c0338e4a>] mutex_lock+0=
x1c/0x1f
> Aug 12 13:10:45 gx110 kernel: [   91.811747]  [<c01b88f3>] xattr_readdi=
r+0x50/0x44e
> Aug 12 13:10:45 gx110 kernel: [   91.812999]  [<c01b94aa>] reiserfs_cho=
wn_xattrs+0xda/0x10f
> Aug 12 13:10:45 gx110 kernel: [   91.813608]  [<c019c1ae>] reiserfs_set=
attr+0x106/0x243
> Aug 12 13:10:45 gx110 kernel: [   91.814185]  [<c0172f41>] notify_chang=
e+0x135/0x2bc
> Aug 12 13:10:45 gx110 kernel: [   91.814720]  [<c015a293>] chown_common=
+0x93/0xab
> Aug 12 13:10:45 gx110 kernel: [   91.815123]  [<c015a2de>] sys_chown+0x=
33/0x45
> Aug 12 13:10:45 gx110 kernel: [   91.815507]  [<c0102d0d>] sysenter_pas=
t_esp+0x56/0x8d
> Aug 12 13:10:45 gx110 kernel: [   91.815547] DWARF2 unwinder stuck at s=
ysenter_past_esp+0x56/0x8d
> Aug 12 13:10:45 gx110 kernel: [   91.815564] Leftover inexact backtrace=
:
> Aug 12 13:10:45 gx110 kernel: [   91.815578]  [<c01050ea>] show_trace+0=
xd/0x10
> Aug 12 13:10:45 gx110 kernel: [   91.815597]  [<c0105104>] dump_stack+0=
x17/0x1b
> Aug 12 13:10:45 gx110 kernel: [   91.815615]  [<c012d979>] __lock_acqui=
re+0x74a/0x9a7
> Aug 12 13:10:45 gx110 kernel: [   91.815634]  [<c012de58>] lock_acquire=
+0x4a/0x6a
> Aug 12 13:10:45 gx110 kernel: [   91.815651]  [<c0338cc7>] __mutex_lock=
_slowpath+0xa7/0x20e
> Aug 12 13:10:45 gx110 kernel: [   91.815676]  [<c0338e4a>] mutex_lock+0=
x1c/0x1f
> Aug 12 13:10:45 gx110 kernel: [   91.815694]  [<c01b88f3>] xattr_readdi=
r+0x50/0x44e
> Aug 12 13:10:45 gx110 kernel: [   91.815712]  [<c01b94aa>] reiserfs_cho=
wn_xattrs+0xda/0x10f
> Aug 12 13:10:45 gx110 kernel: [   91.815731]  [<c019c1ae>] reiserfs_set=
attr+0x106/0x243
> Aug 12 13:10:45 gx110 kernel: [   91.815750]  [<c0172f41>] notify_chang=
e+0x135/0x2bc
> Aug 12 13:10:45 gx110 kernel: [   91.815768]  [<c015a293>] chown_common=
+0x93/0xab
> Aug 12 13:10:45 gx110 kernel: [   91.815789]  [<c015a2de>] sys_chown+0x=
33/0x45
> Aug 12 13:10:45 gx110 kernel: [   91.815807]  [<c0102d0d>] sysenter_pas=
t_esp+0x56/0x8d
> Aug 12 13:10:47 gx110 kernel: [   94.483483] IA-32 Microcode Update Dri=
ver: v1.14a <tigran@veritas.com>

Thanks
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enig6207C281A391789EC8E85D71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE3dXlMdB4Whm86/kRAs3/AJ9sIKqBTag3kCzEVSwTyOnLaGyUEQCdG5Eb
n2cH17JFcnXHzGD7qJsz/pQ=
=3anC
-----END PGP SIGNATURE-----

--------------enig6207C281A391789EC8E85D71--
