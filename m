Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264397AbVBFFeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbVBFFeK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 00:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264465AbVBFFeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 00:34:09 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:5534 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262908AbVBFFdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 00:33:47 -0500
Message-ID: <4205AC37.3030301@comcast.net>
Date: Sun, 06 Feb 2005 00:33:43 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: msdos/vfat defaults are annoying
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

So I've noticed, again, much annoyed, that if I rely on -t auto,
horrible horrible things happen.

I have had floppies and compact flash cards that I've done mkfs.vfat to
make fat32 filesystems on (not fat16), and mounting them brings the
thing on as msdos by default (autodetect).  Furthermore, I build msdos
out, and mount says the msdos FS isn't supported.  In either case I need
to use -t vfat.

Vfat is much more common and should be backwards compatible with msdos.
  When there's a ton of foo~1 files around after mounting, something's
wrong.

Shouldn't vfat be the automatic default?  Or at least, if only vfat and
not msdos is available, use vfat.  For that matter, can msdos and vfat
be collapsed?  As I recall, the difference is that vfat makes more
inodes to store long file names, one for each 13 characters (in reverse?)

I dunno.  I can never understand the innards of the kernel devs' minds.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCBaw3hDd4aOud5P8RAtBGAJsE8I1510nLSNqM6MRwPFGnl9l2UQCfSaGy
HPGDuNVPvMZq8nkI34DlfPI=
=uNx9
-----END PGP SIGNATURE-----
