Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTKBVTX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 16:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbTKBVTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 16:19:23 -0500
Received: from h80ad263a.async.vt.edu ([128.173.38.58]:43754 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261837AbTKBVTW (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 16:19:22 -0500
Message-Id: <200311022119.hA2LJFr5000511@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Martin Wierich <wmartinw30@tiscali.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: turning off harddisk and listen music from ramdisk under Linux 
In-Reply-To: Your message of "Sun, 02 Nov 2003 23:04:54 +0100."
             <3FA57F86.7CEAC8A8@tiscali.de> 
From: Valdis.Kletnieks@vt.edu
References: <3FA57F86.7CEAC8A8@tiscali.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1568146184P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 02 Nov 2003 16:19:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1568146184P
Content-Type: text/plain; charset=us-ascii

On Sun, 02 Nov 2003 23:04:54 +0100, Martin Wierich <wmartinw30@tiscali.de>  said:

>  - for religious reasons I only use _old_ hardware (64MB, 100Mhz)

Note that you'll only be able to fit an hour or so of music in there, and
figuring out how to switch playlists is left as an exercise for the masochists. :)

Other than that, it's pretty straightforward conceptually - just create a very
minimal kernel that supports only your sound card and whatever else you need,
boot it with 'init=/boot/music.sh' or similar, and have music.sh be a tiny
script that mounts your music stuff, copies the files to a ramdisk, then
unmounts the disk and does an hdparm command to spin it down.

If you're clever, you'll think of a way to have an initrd that has all the filesystem
you need on it, except maybe for the actual audio that you'll load from another disk.

--==_Exmh_1568146184P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/pXTScC3lWbTT17ARAmDlAJ49L3KXy93U9YVoufPfetzv9QHm0QCfSL1Y
65ngqzFYqCWPSiZaGDMq74Q=
=lp7u
-----END PGP SIGNATURE-----

--==_Exmh_1568146184P--
