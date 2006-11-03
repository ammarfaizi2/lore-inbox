Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753326AbWKCQJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbWKCQJs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 11:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753332AbWKCQJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 11:09:48 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44499 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1753326AbWKCQJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 11:09:47 -0500
X-Sasl-enc: puIdjkuWv2RDYsrgCQp9frC7sIqrrSf1FlfN/Sg2fl3j 1162570187
Message-ID: <454B6A64.1000107@imap.cc>
Date: Fri, 03 Nov 2006 17:12:20 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [2.6.19-rc4] "possible recursive locking detected" in reiserfs_xattr_set
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6D5831CDB72CE176C8131B34"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D5831CDB72CE176C8131B34
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

JFTR, these messages still appear with 2.6.19-rc4:

Nov  3 11:08:05 gx110 kernel: [ 1025.512025]
Nov  3 11:08:05 gx110 kernel: [ 1025.512031] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Nov  3 11:08:05 gx110 kernel: [ 1025.512053] [ INFO: possible recursive l=
ocking detected ]
Nov  3 11:08:05 gx110 kernel: [ 1025.512064] 2.6.19-rc4-noinitrd #1
Nov  3 11:08:05 gx110 kernel: [ 1025.512071] ----------------------------=
-----------------
Nov  3 11:08:05 gx110 kernel: [ 1025.512080] kdm/3234 is trying to acquir=
e lock:
Nov  3 11:08:05 gx110 kernel: [ 1025.512089]  (&inode->i_mutex){--..}, at=
: [<c035aced>] mutex_lock+0x1c/0x1f
Nov  3 11:08:05 gx110 kernel: [ 1025.512124]
Nov  3 11:08:05 gx110 kernel: [ 1025.512126] but task is already holding =
lock:
Nov  3 11:08:05 gx110 kernel: [ 1025.512134]  (&inode->i_mutex){--..}, at=
: [<c035aced>] mutex_lock+0x1c/0x1f
Nov  3 11:08:05 gx110 kernel: [ 1025.512152]
Nov  3 11:08:05 gx110 kernel: [ 1025.512155] other info that might help u=
s debug this:
Nov  3 11:08:05 gx110 kernel: [ 1025.512165] 3 locks held by kdm/3234:
Nov  3 11:08:05 gx110 kernel: [ 1025.512172]  #0:  (&inode->i_mutex){--..=
}, at: [<c035aced>] mutex_lock+0x1c/0x1f
Nov  3 11:08:05 gx110 kernel: [ 1025.512192]  #1:  (&REISERFS_I(inode)->x=
attr_sem){----}, at: [<c01c3951>] reiserfs_acl_chmod+0xe1/0x180
Nov  3 11:08:05 gx110 kernel: [ 1025.512234]  #2:  (&REISERFS_SB(s)->xatt=
r_dir_sem){----}, at: [<c01c3986>] reiserfs_acl_chmod+0x116/0x180
Nov  3 11:08:05 gx110 kernel: [ 1025.512257]
Nov  3 11:08:05 gx110 kernel: [ 1025.512260] stack backtrace:
Nov  3 11:08:05 gx110 kernel: [ 1025.512274]  [<c0103dc4>] dump_trace+0x6=
4/0x1cc
Nov  3 11:08:05 gx110 kernel: [ 1025.512300]  [<c0103f45>] show_trace_log=
_lvl+0x19/0x2e
Nov  3 11:08:05 gx110 kernel: [ 1025.512317]  [<c01042a2>] show_trace+0x1=
2/0x14
Nov  3 11:08:05 gx110 kernel: [ 1025.512334]  [<c01042bb>] dump_stack+0x1=
7/0x19
Nov  3 11:08:05 gx110 kernel: [ 1025.512348]  [<c012fdd9>] __lock_acquire=
+0x106/0x99c
Nov  3 11:08:05 gx110 kernel: [ 1025.512373]  [<c0130930>] lock_acquire+0=
x5b/0x7b
Nov  3 11:08:05 gx110 kernel: [ 1025.512457]  [<c035ab5d>] __mutex_lock_s=
lowpath+0xc6/0x23a
Nov  3 11:08:05 gx110 kernel: [ 1025.512482]  [<c035aced>] mutex_lock+0x1=
c/0x1f
Nov  3 11:08:05 gx110 kernel: [ 1025.512504]  [<c01c29c5>] reiserfs_xattr=
_set+0xe4/0x2bf
Nov  3 11:08:05 gx110 kernel: [ 1025.512529]  [<c01c33ef>] reiserfs_set_a=
cl+0x18d/0x204
Nov  3 11:08:05 gx110 kernel: [ 1025.512553]  [<c01c3994>] reiserfs_acl_c=
hmod+0x124/0x180
Nov  3 11:08:05 gx110 kernel: [ 1025.512577]  [<c01a3c41>] reiserfs_setat=
tr+0x20b/0x243
Nov  3 11:08:05 gx110 kernel: [ 1025.512608]  [<c017395b>] notify_change+=
0x135/0x2c2
Nov  3 11:08:05 gx110 kernel: [ 1025.512645]  [<c015fbba>] sys_fchmodat+0=
xa0/0xca
Nov  3 11:08:05 gx110 kernel: [ 1025.512670]  [<c015fc05>] sys_chmod+0x21=
/0x23
Nov  3 11:08:05 gx110 kernel: [ 1025.512691]  [<c0102dfd>] sysenter_past_=
esp+0x56/0x8d
Nov  3 11:08:05 gx110 kernel: [ 1025.512718] DWARF2 unwinder stuck at sys=
enter_past_esp+0x56/0x8d
Nov  3 11:08:05 gx110 kernel: [ 1025.512733]
Nov  3 11:08:05 gx110 kernel: [ 1025.512746] Leftover inexact backtrace:
Nov  3 11:08:05 gx110 kernel: [ 1025.512750]
Nov  3 11:08:05 gx110 kernel: [ 1025.512771]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The message appears when the first KDE session is started.

Possibly relevant system info:

ts@gx110:~> uname -a
Linux gx110 2.6.19-rc4-noinitrd #1 PREEMPT Fri Nov 3 02:47:33 CET 2006 i6=
86 i686 i386 GNU/Linux
ts@gx110:~> fgrep REISER /boot/config-2.6.19-rc4-noinitrd
CONFIG_REISERFS_FS=3Dy
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=3Dy
CONFIG_REISERFS_FS_XATTR=3Dy
CONFIG_REISERFS_FS_POSIX_ACL=3Dy
CONFIG_REISERFS_FS_SECURITY=3Dy
ts@gx110:~> mount
/dev/hda3 on / type reiserfs (rw,acl,user_xattr)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
tmpfs on /dev/shm type tmpfs (rw)
devpts on /dev/pts type devpts (rw,mode=3D0620,gid=3D5)
/dev/hda1 on /windows/C type ntfs (ro)
/dev/hda4 on /windows/D type vfat (rw)
usbfs on /proc/bus/usb type usbfs (rw)

HTH

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enig6D5831CDB72CE176C8131B34
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFS2psMdB4Whm86/kRAlS5AJ4nxeT0RGeYlp3/udH+DfC5Y2cakgCeP6KO
qjOSmF7pPqi/lVCWuKTE+Xg=
=7kZF
-----END PGP SIGNATURE-----

--------------enig6D5831CDB72CE176C8131B34--
