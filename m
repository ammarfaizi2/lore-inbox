Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271222AbTHLSzM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 14:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271225AbTHLSzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 14:55:12 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:41344 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S271222AbTHLSzI (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 14:55:08 -0400
Message-Id: <200308121855.h7CIt6St002437@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3-mm1 and rootflags
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1439189981P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Aug 2003 14:55:06 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1439189981P
Content-Type: text/plain; charset=us-ascii

OK.. I'm stumped..

While testing something, I tried to boot with 'rootflags=noatime', and
found the system wouldn't boot, as ext3, ext2, and reiserfs all failed to
recognize the option.  Looking at the code in fs/ext3/super.c:parse_options()
and init/do_mounts.c:root_data_setup(), it appears to be impossible
to set any of the filesystem-independent flags via rootflags, which explains
the special-case code for the 'ro' and 'rw' flags.  However, there doesn't
seem to be any way to pass nodev, noatime, nodiratime, or any of the other
flags.  (And yes, all 3 of those make sense in my environment - it's a laptop
and I don't need atime, and I use devfs so nodev on the root makes sense too).

Am I missing something?  Or in fact, is this an non-doable?

--==_Exmh_1439189981P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/OTgJcC3lWbTT17ARApYVAKCyV7VpXLPRcfDgZt5ZQSwR3pEtvQCdHga3
n5f7IQIVcYhvbu1Piu6KpT0=
=S9QY
-----END PGP SIGNATURE-----

--==_Exmh_1439189981P--
