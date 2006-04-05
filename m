Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWDET6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWDET6c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 15:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWDET6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 15:58:32 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:42407 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932076AbWDET6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 15:58:31 -0400
Message-Id: <200604051958.k35JwF0M019652@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Jon Smirl <jonsmirl@gmail.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [patch 03/26] sysfs: zero terminate sysfs write buffers (CVE-2006-1055) 
In-Reply-To: Your message of "Wed, 05 Apr 2006 16:39:57 BST."
             <20060405153957.GI27946@ftp.linux.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <20060404235634.696852000@quad.kroah.org> <20060404235947.GD27049@kroah.com> <20060405190928.17b9ba6a.vsu@altlinux.ru> <20060405152123.GH27946@ftp.linux.org.uk> <9e4733910604050838g339d48cao4e0f8582f6d90187@mail.gmail.com>
            <20060405153957.GI27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1144267095_4315P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Apr 2006 15:58:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1144267095_4315P
Content-Type: text/plain; charset=us-ascii

On Wed, 05 Apr 2006 16:39:57 BST, Al Viro said:

> How about _NOT_ using sysfs and just having ->read()/->write() on a file in fs
> of your own?  ~20 lines for all of it, not counting #include...

Great.  Instead of everybody using the same piece-of-manure sysfs interface,
each driver carries around its 20 lines to implement read() and write() in
subtly buggy and incompatible ways.

% grep nodev /proc/filesystems | wc -l
19

That's fsck'ing insane already.

--==_Exmh_1144267095_4315P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFENCFXcC3lWbTT17ARAof3AKC0GjW7s9sioAKmcZQg2f/6lD5EkwCfVLgF
pzt79T/OOzDOJW0hI/UCfQw=
=4dCs
-----END PGP SIGNATURE-----

--==_Exmh_1144267095_4315P--
