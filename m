Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWGFXjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWGFXjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWGFXjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:39:13 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49379 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751062AbWGFXjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:39:12 -0400
X-Sasl-enc: kZhN656DY8fJgsA/0J7Bh1lrubXmh79j5sGGKvvmai9Z 1152229148
Message-ID: <44AD9F82.7050006@imap.cc>
Date: Fri, 07 Jul 2006 01:40:50 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux v2.6.18-rc1/reiserfs INFO: possible recursive locking detected
References: <6vtF8-99-7@gated-at.bofh.it>
In-Reply-To: <6vtF8-99-7@gated-at.bofh.it>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2E451845FB94489E77D2C2DB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2E451845FB94489E77D2C2DB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Found this in my syslog:

> Jul  7 00:05:53 gx110 kernel: [  131.691049]
> Jul  7 00:05:53 gx110 kernel: [  131.691055] =============================================
> Jul  7 00:05:53 gx110 kernel: [  131.691074] [ INFO: possible recursive locking detected ]
> Jul  7 00:05:53 gx110 kernel: [  131.691083] ---------------------------------------------
> Jul  7 00:05:53 gx110 kernel: [  131.691092] udevd/3729 is trying to acquire lock:
> Jul  7 00:05:53 gx110 kernel: [  131.691101]  (&inode->i_mutex){--..}, at: [<c033c72a>] mutex_lock+0x1c/0x1f
> Jul  7 00:05:53 gx110 kernel: [  131.691148]
> Jul  7 00:05:53 gx110 kernel: [  131.691150] but task is already holding lock:
> Jul  7 00:05:53 gx110 kernel: [  131.691158]  (&inode->i_mutex){--..}, at: [<c033c72a>] mutex_lock+0x1c/0x1f
> Jul  7 00:05:53 gx110 kernel: [  131.691177]
> Jul  7 00:05:53 gx110 kernel: [  131.691179] other info that might help us debug this:
> Jul  7 00:05:53 gx110 kernel: [  131.691189] 1 lock held by udevd/3729:
> Jul  7 00:05:53 gx110 kernel: [  131.691195]  #0:  (&inode->i_mutex){--..}, at: [<c033c72a>] mutex_lock+0x1c/0x1f
> Jul  7 00:05:54 gx110 kernel: [  131.691215]
> Jul  7 00:05:54 gx110 kernel: [  131.691217] stack backtrace:
> Jul  7 00:05:54 gx110 kernel: [  131.691940]  [<c0103f4d>] show_trace_log_lvl+0x54/0xfd
> Jul  7 00:05:54 gx110 kernel: [  131.691997]  [<c010504d>] show_trace+0xd/0x10
> Jul  7 00:05:54 gx110 kernel: [  131.692044]  [<c0105067>] dump_stack+0x17/0x1c
> Jul  7 00:05:54 gx110 kernel: [  131.692090]  [<c012e3fa>] __lock_acquire+0x758/0x9bf
> Jul  7 00:05:54 gx110 kernel: [  131.692336]  [<c012e93e>] lock_acquire+0x5e/0x80
> Jul  7 00:05:54 gx110 kernel: [  131.692572]  [<c033c5a7>] __mutex_lock_slowpath+0xa7/0x20e
> Jul  7 00:05:54 gx110 kernel: [  131.692796]  [<c033c72a>] mutex_lock+0x1c/0x1f
> Jul  7 00:05:54 gx110 kernel: [  131.693017]  [<c01ba730>] xattr_readdir+0x50/0x456
> Jul  7 00:05:54 gx110 kernel: [  131.694269]  [<c01bb304>] reiserfs_chown_xattrs+0xdd/0x112
> Jul  7 00:05:54 gx110 kernel: [  131.694875]  [<c019dca6>] reiserfs_setattr+0x113/0x250
> Jul  7 00:05:54 gx110 kernel: [  131.695516]  [<c0174619>] notify_change+0x135/0x2c0
> Jul  7 00:05:54 gx110 kernel: [  131.695991]  [<c015b328>] chown_common+0x93/0xab
> Jul  7 00:05:54 gx110 kernel: [  131.696388]  [<c015b373>] sys_chown+0x33/0x45
> Jul  7 00:05:54 gx110 kernel: [  131.696770]  [<c0102cbd>] sysenter_past_esp+0x56/0x8d
> Jul  7 00:05:54 gx110 kernel: [  132.094621] IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>

This is originally a SuSE 10.0 installation with a ReiserFS root
filesystem, now running a 2.6.18-rc1 kernel built on the same system
with CONFIG_REISERFS_FS=y and CONFIG_PROVE_LOCKING=y.

ts@gx110:~> uname -a
Linux gx110 2.6.18-rc1-noinitrd #1 PREEMPT Thu Jul 6 18:17:31 CEST 2006
i686 i686 i386 GNU/Linux

Regards
Tilman

-- 
Tilman Schmidt                                    E-Mail: tilman@imap.cc
Bonn, Germany
It is well known that a vital ingredient of success is not knowing that
what you're attempting can't be done. [Terry Pratchett, Equal Rites]

--------------enig2E451845FB94489E77D2C2DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErZ+DMdB4Whm86/kRAtHUAJ9Mbb2iiAe6V586VtHDG9+ovxONxQCfaeM8
WBIfRm/vShW2t7hXjxtHikk=
=gc90
-----END PGP SIGNATURE-----

--------------enig2E451845FB94489E77D2C2DB--
