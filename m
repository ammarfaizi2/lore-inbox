Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbUBJTVD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266036AbUBJTVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:21:03 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:49552 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S266124AbUBJTUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:20:09 -0500
Date: Tue, 10 Feb 2004 11:20:07 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Gidon <gidon@warpcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel GPL Violations and How to Research
Message-ID: <20040210192007.GA6987@one-eyed-alien.net>
Mail-Followup-To: Gidon <gidon@warpcore.org>, linux-kernel@vger.kernel.org
References: <1076388828.9259.32.camel@CPE-65-26-89-23.kc.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <1076388828.9259.32.camel@CPE-65-26-89-23.kc.rr.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 09, 2004 at 10:53:50PM -0600, Gidon wrote:
> So what I am writing to ask, is what is the best way to ascertain
> whether or not a binary (in this case a "kernel image" of this project)
> contains GPL'd code or functions. So far I have found nearly a hundred
> identical (down to formatting specifiers, punctuation, etc.) or nearly
> identical error messages that consistently match areas of Linux i386
> arch specific kernel code or drivers as well as matching function names,
> using the "strings" program on their Kernel image.

Usually for me, the next step is to disassemble their object code for
symbol information using objdump.

You should be able to get some function names, variable names, etc.  from
that -- if those match the kernel code in question, that's about as good a
"smoking gun" as you can expect to find.  'strings' isn't as good for
function names.

As a final level of analysis, you can always look at the compiled binary
code -- if you think they are using a _reasonably_ compatible compiler, you
might actually be able to find long sections of identical or near-identical
assembly (modulo loop unrolling, etc. which you should be able to identify
by hand.)

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It's monday.  It must be monday.
					-- Greg
User Friendly, 5/4/1998

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAKS7nIjReC7bSPZARAk00AKCVPwyizYAVeBzzsmJRRmv+sHKU0ACdFRKD
LXpqzlaI3S/CUCetiMo3Ahk=
=voBG
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
