Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752444AbWKFTQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbWKFTQh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 14:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752558AbWKFTQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 14:16:37 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55529 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1752444AbWKFTQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 14:16:36 -0500
X-Sasl-enc: OBUkgyfXqvOrSLSIR7rJaHB4cQHkpZxRThlSTriZiXDI 1162840595
Message-ID: <454F8AAE.2000705@imap.cc>
Date: Mon, 06 Nov 2006 20:19:10 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Srinivasa Ds <srinivasa@in.ibm.com>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, edward@namesys.com,
       reiserfs-dev@namesys.com, apw@shadowen.com
Subject: Re: [PATCH] Re:[2.6.19-rc4] "possible recursive locking detected"
 in reiserfs_xattr_set
References: <454B6A64.1000107@imap.cc> <454EFDD8.4020608@in.ibm.com>
In-Reply-To: <454EFDD8.4020608@in.ibm.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE004FD572CF5F16488943A5A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE004FD572CF5F16488943A5A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 06.11.2006 10:18 schrieb Srinivasa Ds:
> This patch should solve your problem.

'fraid it doesn't. It just changes the message to:

Nov  6 19:47:51 gx110 kernel: [  135.987220]
Nov  6 19:47:51 gx110 kernel: [  135.987226] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Nov  6 19:47:51 gx110 kernel: [  135.987250] [ INFO: possible circular lo=
cking dependency detected ]
Nov  6 19:47:51 gx110 kernel: [  135.987261] 2.6.19-rc4-noinitrd #2
Nov  6 19:47:51 gx110 kernel: [  135.987268] ----------------------------=
---------------------------
Nov  6 19:47:51 gx110 kernel: [  135.987278] kdm/3244 is trying to acquir=
e lock:
Nov  6 19:47:51 gx110 kernel: [  135.987288]  (&inode->i_mutex){--..}, at=
: [<c035aced>] mutex_lock+0x1c/0x1f
Nov  6 19:47:51 gx110 kernel: [  135.987324]
Nov  6 19:47:51 gx110 kernel: [  135.987326] but task is already holding =
lock:
Nov  6 19:47:51 gx110 kernel: [  135.987334]  (&REISERFS_SB(s)->xattr_dir=
_sem){----}, at: [<c01c398e>] reiserfs_acl_chmod+0x116/0x180
Nov  6 19:47:51 gx110 kernel: [  135.987374]
Nov  6 19:47:51 gx110 kernel: [  135.987376] which lock already depends o=
n the new lock.
Nov  6 19:47:51 gx110 kernel: [  135.987380]
Nov  6 19:47:51 gx110 kernel: [  135.987389]
Nov  6 19:47:51 gx110 kernel: [  135.987391] the existing dependency chai=
n (in reverse order) is:
Nov  6 19:47:51 gx110 kernel: [  135.987400]
Nov  6 19:47:51 gx110 kernel: [  135.987402] -> #2 (&REISERFS_SB(s)->xatt=
r_dir_sem){----}:
Nov  6 19:47:51 gx110 kernel: [  135.987417]        [<c012fcb7>] add_lock=
_to_list+0x62/0x7e
Nov  6 19:47:51 gx110 kernel: [  135.987446]        [<c0130577>] __lock_a=
cquire+0x8a4/0x99c
Nov  6 19:47:51 gx110 kernel: [  135.987467]        [<c0130930>] lock_acq=
uire+0x5b/0x7b
Nov  6 19:47:51 gx110 kernel: [  135.987487]        [<c012c8c5>] down_rea=
d+0x3a/0x4b
Nov  6 19:47:51 gx110 kernel: [  135.987526]        [<c01c381c>] reiserfs=
_cache_default_acl+0x43/0x9f
Nov  6 19:47:51 gx110 kernel: [  135.987548]        [<c01a2824>] reiserfs=
_create+0x68/0x1e3
Nov  6 19:47:51 gx110 kernel: [  135.987573]        [<c016a559>] vfs_crea=
te+0xd1/0x149
Nov  6 19:47:51 gx110 kernel: [  135.987669]        [<c016a738>] open_nam=
ei+0x167/0x57f
Nov  6 19:47:51 gx110 kernel: [  135.987696]        [<c0160ba4>] do_filp_=
open+0x26/0x3b
Nov  6 19:47:51 gx110 kernel: [  135.987727]        [<c0160cc3>] do_sys_o=
pen+0x43/0xc2
Nov  6 19:47:51 gx110 kernel: [  135.987754]        [<c0160d79>] sys_open=
+0x1a/0x1c
Nov  6 19:47:51 gx110 kernel: [  135.987780]        [<c0102dfd>] sysenter=
_past_esp+0x56/0x8d
Nov  6 19:47:51 gx110 kernel: [  135.987812]        [<ffffffff>] 0xffffff=
ff
Nov  6 19:47:51 gx110 kernel: [  135.987863]
Nov  6 19:47:51 gx110 kernel: [  135.987865] -> #1 (&REISERFS_I(inode)->x=
attr_sem){----}:
Nov  6 19:47:51 gx110 kernel: [  135.987893]        [<c012fcb7>] add_lock=
_to_list+0x62/0x7e
Nov  6 19:47:51 gx110 kernel: [  135.987921]        [<c0130577>] __lock_a=
cquire+0x8a4/0x99c
Nov  6 19:47:51 gx110 kernel: [  135.987948]        [<c0130930>] lock_acq=
uire+0x5b/0x7b
Nov  6 19:47:51 gx110 kernel: [  135.987975]        [<c012c8c5>] down_rea=
d+0x3a/0x4b
Nov  6 19:47:51 gx110 kernel: [  135.988003]        [<c01c3806>] reiserfs=
_cache_default_acl+0x2d/0x9f
Nov  6 19:47:51 gx110 kernel: [  135.988032]        [<c01a2824>] reiserfs=
_create+0x68/0x1e3
Nov  6 19:47:51 gx110 kernel: [  135.988059]        [<c016a559>] vfs_crea=
te+0xd1/0x149
Nov  6 19:47:51 gx110 kernel: [  135.988086]        [<c016a738>] open_nam=
ei+0x167/0x57f
Nov  6 19:47:51 gx110 kernel: [  135.988113]        [<c0160ba4>] do_filp_=
open+0x26/0x3b
Nov  6 19:47:51 gx110 kernel: [  135.988140]        [<c0160cc3>] do_sys_o=
pen+0x43/0xc2
Nov  6 19:47:51 gx110 kernel: [  135.988167]        [<c0160d79>] sys_open=
+0x1a/0x1c
Nov  6 19:47:51 gx110 kernel: [  135.988193]        [<c0102dfd>] sysenter=
_past_esp+0x56/0x8d
Nov  6 19:47:51 gx110 kernel: [  135.988220]        [<ffffffff>] 0xffffff=
ff
Nov  6 19:47:51 gx110 kernel: [  135.988307]
Nov  6 19:47:51 gx110 kernel: [  135.988309] -> #0 (&inode->i_mutex){--..=
}:
Nov  6 19:47:51 gx110 kernel: [  135.988336]        [<c012fc1f>] print_ci=
rcular_bug_tail+0x30/0x66
Nov  6 19:47:51 gx110 kernel: [  135.988364]        [<c0130476>] __lock_a=
cquire+0x7a3/0x99c
Nov  6 19:47:51 gx110 kernel: [  135.988392]        [<c0130930>] lock_acq=
uire+0x5b/0x7b
Nov  6 19:47:51 gx110 kernel: [  135.988419]        [<c035ab5d>] __mutex_=
lock_slowpath+0xc6/0x23a
Nov  6 19:47:51 gx110 kernel: [  135.988448]        [<c035aced>] mutex_lo=
ck+0x1c/0x1f
Nov  6 19:47:52 gx110 kernel: [  135.988474]        [<c01c29cd>] reiserfs=
_xattr_set+0xe4/0x2bf
Nov  6 19:47:52 gx110 kernel: [  135.988503]        [<c01c33f7>] reiserfs=
_set_acl+0x18d/0x204
Nov  6 19:47:52 gx110 kernel: [  135.988532]        [<c01c399c>] reiserfs=
_acl_chmod+0x124/0x180
Nov  6 19:47:52 gx110 kernel: [  135.988561]        [<c01a3c49>] reiserfs=
_setattr+0x20b/0x243
Nov  6 19:47:52 gx110 kernel: [  135.988590]        [<c0173963>] notify_c=
hange+0x135/0x2c2
Nov  6 19:47:52 gx110 kernel: [  135.988631]        [<c015fbbf>] sys_fchm=
odat+0xa5/0xcf
Nov  6 19:47:52 gx110 kernel: [  135.988658]        [<c015fc0a>] sys_chmo=
d+0x21/0x23
Nov  6 19:47:52 gx110 kernel: [  135.988684]        [<c0102dfd>] sysenter=
_past_esp+0x56/0x8d
Nov  6 19:47:52 gx110 kernel: [  135.988712]        [<ffffffff>] 0xffffff=
ff
Nov  6 19:47:52 gx110 kernel: [  135.988739]
Nov  6 19:47:52 gx110 kernel: [  135.988741] other info that might help u=
s debug this:
Nov  6 19:47:52 gx110 kernel: [  135.988745]
Nov  6 19:47:52 gx110 kernel: [  135.988776] 3 locks held by kdm/3244:
Nov  6 19:47:52 gx110 kernel: [  135.988790]  #0:  (&inode->i_mutex/1){--=
=2E.}, at: [<c015fb8b>] sys_fchmodat+0x71/0xcf
Nov  6 19:47:52 gx110 kernel: [  135.988819]  #1:  (&REISERFS_I(inode)->x=
attr_sem){----}, at: [<c01c3959>] reiserfs_acl_chmod+0xe1/0x180
Nov  6 19:47:52 gx110 kernel: [  135.988849]  #2:  (&REISERFS_SB(s)->xatt=
r_dir_sem){----}, at: [<c01c398e>] reiserfs_acl_chmod+0x116/0x180
Nov  6 19:47:52 gx110 kernel: [  135.988879]
Nov  6 19:47:52 gx110 kernel: [  135.988881] stack backtrace:
Nov  6 19:47:52 gx110 kernel: [  135.988908]  [<c0103dc4>] dump_trace+0x6=
4/0x1cc
Nov  6 19:47:52 gx110 kernel: [  135.988936]  [<c0103f45>] show_trace_log=
_lvl+0x19/0x2e
Nov  6 19:47:52 gx110 kernel: [  135.988960]  [<c01042a2>] show_trace+0x1=
2/0x14
Nov  6 19:47:52 gx110 kernel: [  135.988983]  [<c01042bb>] dump_stack+0x1=
7/0x19
Nov  6 19:47:52 gx110 kernel: [  135.989006]  [<c012fc4c>] print_circular=
_bug_tail+0x5d/0x66
Nov  6 19:47:52 gx110 kernel: [  135.989029]  [<c0130476>] __lock_acquire=
+0x7a3/0x99c
Nov  6 19:47:52 gx110 kernel: [  135.989052]  [<c0130930>] lock_acquire+0=
x5b/0x7b
Nov  6 19:47:52 gx110 kernel: [  135.989074]  [<c035ab5d>] __mutex_lock_s=
lowpath+0xc6/0x23a
Nov  6 19:47:52 gx110 kernel: [  135.989097]  [<c035aced>] mutex_lock+0x1=
c/0x1f
Nov  6 19:47:52 gx110 kernel: [  135.989119]  [<c01c29cd>] reiserfs_xattr=
_set+0xe4/0x2bf
Nov  6 19:47:52 gx110 kernel: [  135.989143]  [<c01c33f7>] reiserfs_set_a=
cl+0x18d/0x204
Nov  6 19:47:52 gx110 kernel: [  135.989167]  [<c01c399c>] reiserfs_acl_c=
hmod+0x124/0x180
Nov  6 19:47:52 gx110 kernel: [  135.989190]  [<c01a3c49>] reiserfs_setat=
tr+0x20b/0x243
Nov  6 19:47:52 gx110 kernel: [  135.989214]  [<c0173963>] notify_change+=
0x135/0x2c2
Nov  6 19:47:52 gx110 kernel: [  135.989237]  [<c015fbbf>] sys_fchmodat+0=
xa5/0xcf
Nov  6 19:47:52 gx110 kernel: [  135.989259]  [<c015fc0a>] sys_chmod+0x21=
/0x23
Nov  6 19:47:52 gx110 kernel: [  135.989280]  [<c0102dfd>] sysenter_past_=
esp+0x56/0x8d
Nov  6 19:47:52 gx110 kernel: [  135.989306] DWARF2 unwinder stuck at sys=
enter_past_esp+0x56/0x8d
Nov  6 19:47:52 gx110 kernel: [  135.989322]
Nov  6 19:47:52 gx110 kernel: [  135.989334] Leftover inexact backtrace:
Nov  6 19:47:52 gx110 kernel: [  135.989338]
Nov  6 19:47:52 gx110 kernel: [  135.989359]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thanks
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enigE004FD572CF5F16488943A5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFT4q3MdB4Whm86/kRAlfwAJ95jYUj+om3emCOsLO10pnoZLG5uQCfcIYG
xDa6Zllhn8gmg83pGYt6q/Q=
=gnZl
-----END PGP SIGNATURE-----

--------------enigE004FD572CF5F16488943A5A--
