Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269497AbUICB2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269497AbUICB2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269474AbUICBY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:24:26 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:9648 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269497AbUICBXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 21:23:41 -0400
Message-Id: <200409030118.i831IUc6006797@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: David Masover <ninja@slaphack.com>
Cc: Oliver Neukum <oliver@neukum.org>, Spam <spam@tnonline.net>,
       Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives 
In-Reply-To: Your message of "Thu, 02 Sep 2004 19:43:34 CDT."
             <4137BE36.5020504@slaphack.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040826150202.GE5733@mail.shareable.org> <4136E0B6.4000705@namesys.com> <1117111836.20040902115249@tnonline.net> <200409021309.04780.oliver@neukum.org>
            <4137BE36.5020504@slaphack.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-23110438P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Sep 2004 21:18:30 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-23110438P
Content-Type: text/plain; charset=us-ascii

On Thu, 02 Sep 2004 19:43:34 CDT, David Masover said:

> And on apps.  Should I teach OpenOffice.org to do version control?
> Seems a lot easier to just do it in the kernel, and teach everything to
> do version control in one fell swoop.

Including files you didn't really want to keep version control of?

How many temp files does gcc create and unlink in the course of a kernel build?
(And remember, you can't say "don't enable that on /tmp" - gcc respects the
setting of $TMPDIR - so an 'export TMPDIR=~/tmp' confuses things quite
nicely...)

And it's hard for the kernel to know that an unlink() done by gcc should be
treated differently than the "recover the last version" you *want* it do be able
to do after you work on a source file for a long while, save it, and then
fumble-finger a 'rm * .o' - you can't even use a heuristic like "don't version
control it unless it's N seconds or more old"

(Note that the "obvious" solution of creating a chattr flag has its own
complexity issues - should versioning be turned on by default for some types
and not others, etc...)

There be dragons here - it's not as simple as "drop in a plugin and be happy".


--==_Exmh_-23110438P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBN8ZlcC3lWbTT17ARAtJ+AKDCmCTMTbYG2bfgiJjAM+aRIEuB8QCgkvRs
JDyIqCoKQrdEz/06hyUnucs=
=R3QE
-----END PGP SIGNATURE-----

--==_Exmh_-23110438P--
