Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbWIVOWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbWIVOWG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWIVOWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:22:06 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:10375 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932527AbWIVOWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:22:02 -0400
X-Sasl-enc: vfSlCdtcbWnCyViIUFl/Po/01PHqMaeA9V0oQldyXiOk 1158934921
Message-ID: <4513F1E5.3020700@imap.cc>
Date: Fri, 22 Sep 2006 16:23:33 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.18] INFO: possible recursive locking detected
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig117E79F6A6CF94B37C63D924"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig117E79F6A6CF94B37C63D924
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I am getting this in my syslog during system startup:

Sep 22 16:11:07 gx110 kernel: [  227.330838]
Sep 22 16:11:07 gx110 kernel: [  227.330844] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Sep 22 16:11:07 gx110 kernel: [  227.330867] [ INFO: possible recursive l=
ocking detected ]
Sep 22 16:11:07 gx110 kernel: [  227.330876] ----------------------------=
-----------------
Sep 22 16:11:07 gx110 kernel: [  227.330885] kdm/3153 is trying to acquir=
e lock:
Sep 22 16:11:07 gx110 kernel: [  227.330895]  (&inode->i_mutex){--..}, at=
: [<c03388cc>] mutex_lock+0x1c/0x1f
Sep 22 16:11:07 gx110 kernel: [  227.330943]
Sep 22 16:11:07 gx110 kernel: [  227.330945] but task is already holding =
lock:
Sep 22 16:11:07 gx110 kernel: [  227.330953]  (&inode->i_mutex){--..}, at=
: [<c03388cc>] mutex_lock+0x1c/0x1f
Sep 22 16:11:07 gx110 kernel: [  227.330971]
Sep 22 16:11:07 gx110 kernel: [  227.330973] other info that might help u=
s debug this:
Sep 22 16:11:07 gx110 kernel: [  227.330983] 3 locks held by kdm/3153:
Sep 22 16:11:07 gx110 kernel: [  227.330990]  #0:  (&inode->i_mutex){--..=
}, at: [<c03388cc>] mutex_lock+0x1c/0x1f
Sep 22 16:11:07 gx110 kernel: [  227.331010]  #1:  (&REISERFS_I(inode)->x=
attr_sem){----}, at: [<c01ba985>] reiserfs_acl_chmod+0xe1/0x180
Sep 22 16:11:07 gx110 kernel: [  227.331041]  #2:  (&REISERFS_SB(s)->xatt=
r_dir_sem){----}, at: [<c01ba9ba>] reiserfs_acl_chmod+0x116/0x180
Sep 22 16:11:07 gx110 kernel: [  227.331064]
Sep 22 16:11:07 gx110 kernel: [  227.331066] stack backtrace:
Sep 22 16:11:07 gx110 kernel: [  227.331779]  [<c0103fa9>] show_trace_log=
_lvl+0x58/0x16f
Sep 22 16:11:07 gx110 kernel: [  227.331839]  [<c0105106>] show_trace+0xd=
/0x10
Sep 22 16:11:07 gx110 kernel: [  227.331886]  [<c0105120>] dump_stack+0x1=
7/0x1b
Sep 22 16:11:07 gx110 kernel: [  227.332006]  [<c012d8b1>] __lock_acquire=
+0x74a/0x9a7
Sep 22 16:11:07 gx110 kernel: [  227.332257]  [<c012dd90>] lock_acquire+0=
x4a/0x6a
Sep 22 16:11:07 gx110 kernel: [  227.332498]  [<c0338749>] __mutex_lock_s=
lowpath+0xa7/0x20e
Sep 22 16:11:07 gx110 kernel: [  227.332729]  [<c03388cc>] mutex_lock+0x1=
c/0x1f
Sep 22 16:11:07 gx110 kernel: [  227.332956]  [<c01b9a26>] reiserfs_xattr=
_set+0xda/0x2b0
Sep 22 16:11:07 gx110 kernel: [  227.334209]  [<c01ba425>] reiserfs_set_a=
cl+0x184/0x1fd
Sep 22 16:11:07 gx110 kernel: [  227.334832]  [<c01ba9c8>] reiserfs_acl_c=
hmod+0x124/0x180
Sep 22 16:11:07 gx110 kernel: [  227.335454]  [<c019bfdf>] reiserfs_setat=
tr+0x20b/0x243
Sep 22 16:11:07 gx110 kernel: [  227.336037]  [<c0173011>] notify_change+=
0x135/0x2bc
Sep 22 16:11:07 gx110 kernel: [  227.336506]  [<c015a2e1>] sys_fchmodat+0=
x9f/0xc6
Sep 22 16:11:07 gx110 kernel: [  227.336901]  [<c015a31a>] sys_chmod+0x12=
/0x14
Sep 22 16:11:07 gx110 kernel: [  227.337282]  [<c0102d15>] sysenter_past_=
esp+0x56/0x8d
Sep 22 16:11:07 gx110 kernel: [  227.337323] DWARF2 unwinder stuck at sys=
enter_past_esp+0x56/0x8d
Sep 22 16:11:07 gx110 kernel: [  227.337339] Leftover inexact backtrace:
Sep 22 16:11:07 gx110 kernel: [  227.337354]  [<c0105106>] show_trace+0xd=
/0x10
Sep 22 16:11:07 gx110 kernel: [  227.337373]  [<c0105120>] dump_stack+0x1=
7/0x1b
Sep 22 16:11:07 gx110 kernel: [  227.337393]  [<c012d8b1>] __lock_acquire=
+0x74a/0x9a7
Sep 22 16:11:07 gx110 kernel: [  227.337411]  [<c012dd90>] lock_acquire+0=
x4a/0x6a
Sep 22 16:11:07 gx110 kernel: [  227.337429]  [<c0338749>] __mutex_lock_s=
lowpath+0xa7/0x20e
Sep 22 16:11:07 gx110 kernel: [  227.337455]  [<c03388cc>] mutex_lock+0x1=
c/0x1f
Sep 22 16:11:07 gx110 kernel: [  227.337474]  [<c01b9a26>] reiserfs_xattr=
_set+0xda/0x2b0
Sep 22 16:11:07 gx110 kernel: [  227.337492]  [<c01ba425>] reiserfs_set_a=
cl+0x184/0x1fd
Sep 22 16:11:07 gx110 kernel: [  227.337511]  [<c01ba9c8>] reiserfs_acl_c=
hmod+0x124/0x180
Sep 22 16:11:07 gx110 kernel: [  227.337530]  [<c019bfdf>] reiserfs_setat=
tr+0x20b/0x243
Sep 22 16:11:07 gx110 kernel: [  227.337550]  [<c0173011>] notify_change+=
0x135/0x2bc
Sep 22 16:11:07 gx110 kernel: [  227.337569]  [<c015a2e1>] sys_fchmodat+0=
x9f/0xc6
Sep 22 16:11:07 gx110 kernel: [  227.337588]  [<c015a31a>] sys_chmod+0x12=
/0x14
Sep 22 16:11:07 gx110 kernel: [  227.337606]  [<c0102d15>] sysenter_past_=
esp+0x56/0x8d

ts@gx110:~> uname -a
Linux gx110 2.6.18-noinitrd #2 PREEMPT Thu Sep 21 23:34:08 CEST 2006 i686=
 i686 i386 GNU/Linux

Hardware: Dell OptiPlex GX110, Intel Pentium III, 933 MHz, 512 MB RAM,
i810 chipset, 60 GB ATA DISK drive, single 30 GB ReiserFS partition
for Linux
Software: SuSE Linux 10.0 Professional with current patches plus
self-compiled kernel 2.6.18

HTH
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig117E79F6A6CF94B37C63D924
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFE/HrMdB4Whm86/kRAqLcAJ9F4Ewn5nH38V+ABZ9TMxWKlFoV9wCeMatR
4APGQaH3t/KUWff+OxZzzzc=
=xmht
-----END PGP SIGNATURE-----

--------------enig117E79F6A6CF94B37C63D924--
