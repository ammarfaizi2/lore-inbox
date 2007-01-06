Return-Path: <linux-kernel-owner+w=401wt.eu-S1751185AbXAFMz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbXAFMz7 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 07:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbXAFMz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 07:55:59 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:45454 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbXAFMz6 (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 07:55:58 -0500
Message-Id: <200701061255.l06CtXJq011249@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.20-rc3-mm1 - git-block.patch causes hard lockups
In-Reply-To: Your message of "Thu, 04 Jan 2007 22:02:00 PST."
             <20070104220200.ae4e9a46.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20070104220200.ae4e9a46.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1168088133_8107P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 06 Jan 2007 07:55:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1168088133_8107P
Content-Type: text/plain; charset=us-ascii

On Thu, 04 Jan 2007 22:02:00 PST, Andrew Morton said:

> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/

With git-block.patch applied, my system locks up *hard* at system shutdown
time - even alt-sysrq doesn't do anything.  Need to do the "power button for 5"
stunt to get the system back.

The system is Fedora Core 6/Rawhide, and the last command issued (from
/etc/rc6.d/S01reboot) is "/sbin/cryptsetup remove swap".  It hits that,
and *wham* we're dead.  Works fine if I revert git-block.patch.

The line from /etc/crypttab for the encrypted swap:

swap /dev/mapper/VolGroup00-swap /dev/urandom swap,cipher=aes-cbc-essiv:sha256

This ring any bells?  I haven't gotten ambitious enough yet to look for
individual commits inside the git-block.patch (this is just one of 3 issues
I've having to bisect in -mm this time around...)

--==_Exmh_1168088133_8107P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFn5xFcC3lWbTT17ARAn0pAJ4xB1ArhCV3znzMMUr02GGlnjc3RQCfRH5n
7/dNGgMy+2SkjeGvytfjQaM=
=Hhr0
-----END PGP SIGNATURE-----

--==_Exmh_1168088133_8107P--
