Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWEVO3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWEVO3w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 10:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWEVO3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 10:29:52 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:17867 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750841AbWEVO3v (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 10:29:51 -0400
Message-Id: <200605221429.k4METL5D011740@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, "Theodore Ts'o" <tytso@mit.edu>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add user taint flag
In-Reply-To: Your message of "Mon, 22 May 2006 15:35:48 BST."
             <1148308548.17376.44.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <E1FhwyO-0001YQ-O1@candygram.thunk.org> <1148307276.3902.71.camel@laptopd505.fenrus.org>
            <1148308548.17376.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1148308161_6073P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 22 May 2006 10:29:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1148308161_6073P
Content-Type: text/plain; charset=us-ascii

On Mon, 22 May 2006 15:35:48 BST, Alan Cox said:
> On Llu, 2006-05-22 at 16:14 +0200, Arjan van de Ven wrote:
> > we should then patch the /dev/mem driver or something to set this :)
> > (well and possibly give it an exception for now for PCI space until the
> > X people fix their stuff to use the proper sysfs stuff)
> 
> /dev/mem is used for all sorts of sane things including DMIdecode.
> Tainting on it isn't terribly useful. Mind you this whole user taint
> patch seems bogus as it can only be set by root owned processes so
> doesn't appear to do the job it is intended for - perhaps Ted can
> explain ?

Taint on write to /dev/mem, perhaps?  I don't think DMIdecode needs to
scribble on /dev/mem, does it?  (Figure if a userspace program runs OK
on a recent Fedora or RedHat kernel, it doesn't need to scribble on /dev/mem
too much, because the vast majority of it is lopped out via a patch....)

--==_Exmh_1148308161_6073P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEccrBcC3lWbTT17ARAizGAJ9Bzhg6QJVc3kFOtouWI6qZAdpGXACg3Sts
l9n0wo7F2rGRlFBVTNkAT2I=
=nnqg
-----END PGP SIGNATURE-----

--==_Exmh_1148308161_6073P--
