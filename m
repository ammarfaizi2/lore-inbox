Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265598AbUBPPTG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 10:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265602AbUBPPTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 10:19:06 -0500
Received: from h80ad2711.async.vt.edu ([128.173.39.17]:7471 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265598AbUBPPTC (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 10:19:02 -0500
Message-Id: <200402161518.i1GFIpn2008826@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Eduard Bloch <edi@gmx.de>
Cc: Jamie Lokier <jamie@shareable.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.) 
In-Reply-To: Your message of "Mon, 16 Feb 2004 15:03:38 +0100."
             <20040216140338.GA2927@zombie.inka.de> 
From: Valdis.Kletnieks@vt.edu
References: <20040209115852.GB877@schottelius.org> <200402121655.39709.robin.rosenberg.lists@dewire.com> <20040213003839.GB24981@mail.shareable.org> <200402130216.53434.robin.rosenberg.lists@dewire.com> <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk> <20040213032305.GH25499@mail.shareable.org> <20040214150934.GA5023@zombie.inka.de> <20040215010150.GA3611@mail.shareable.org>
            <20040216140338.GA2927@zombie.inka.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2009302832P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Feb 2004 10:18:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2009302832P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Feb 2004 15:03:38 +0100, Eduard Bloch said:

>  - convert all files from the previous charset to UTF-8 overnight
>    if the previous charset was unknown, first make sure that you can
>    guess it for all users and contact users that have files with
>    suspicous filenames (eg. not convertable from Latin1). Or look troug=
h
>    their shell/X config files (*)

Hazardous.

>  - in libc, implement a recoding function to convert file names from
>    LC_CTYPE to the underlying UTF-8 encoding

Hmm.. could be fun if somebody is calling 'open', and the UTF-8 encoding
requires the insertion of extra characters to encode it - what do you do =
then?
That looks like a security hole just waiting to happen.  Probably has lot=
s of
lurking corner cases too - what if you creat() a file, then do a readdir(=
) and
strcmp() each entry looking for your file (while comparing a filename sma=
shed
to UTF-8 to the original unsmashed string)?


--==_Exmh_2009302832P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAMN9acC3lWbTT17ARAnpIAJ9C1HADPSYJ/1vDivJM7L3MlA0azwCdE131
ZAp4aL3gjKDGa5o+VhHEq74=
=PklS
-----END PGP SIGNATURE-----

--==_Exmh_2009302832P--
