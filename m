Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUAEREj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265177AbUAEREj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:04:39 -0500
Received: from h80ad2582.async.vt.edu ([128.173.37.130]:24192 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264484AbUAEREh (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:04:37 -0500
Message-Id: <200401051704.i05H4SgL011915@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andreas Schwab <schwab@suse.de>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: #ifdef usage (was Re: PPC32: Fix the floppy driver, on CONFIG_NOT_COHERENT_CACHE. 
In-Reply-To: Your message of "Mon, 05 Jan 2004 17:07:23 +0100."
             <jeisjqnzus.fsf@sykes.suse.de> 
From: Valdis.Kletnieks@vt.edu
References: <200401032002.i03K25Y9024335@hera.kernel.org> <Pine.GSO.4.58.0401051504050.3740@waterleaf.sonytel.be>
            <jeisjqnzus.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-192432672P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jan 2004 12:04:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-192432672P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 05 Jan 2004 17:07:23 +0100, Andreas Schwab said:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> =

> > On Fri, 2 Jan 2004, Linux Kernel Mailing List wrote:
> >> +#if CONFIG_NOT_COHERENT_CACHE
> >    ^^^
> > Shouldn't this be #ifdef?
> =

> Doesn't matter. Config variables are always either defined to 1 or not
> defined at all (which is equivalent to 0 in #if).

It makes life a lot simpler for those who compile with -Wundef, which is =
why
I did a bunch of cleanup back around 2.5.6mumble or so.  It also found a =
real
bug where '#if A | B | C'  and there was a typo in B.  There's also a few=

places where code used '#if LINUX_VERSION_CODE > NNNN' without
doing a #include of version.h - fortunately for us, all the cases of *tha=
t* happened
to do the right thing when using the implied zero.  =


--==_Exmh_-192432672P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/+ZkccC3lWbTT17ARAijQAKCkyrnPDsA6+3CK/RrEaVkAKVhFAQCdGSMo
NjzqH3wno23Zlj8Fxx8dr9g=
=gdPo
-----END PGP SIGNATURE-----

--==_Exmh_-192432672P--
