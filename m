Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946110AbWBDAyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946110AbWBDAyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 19:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946233AbWBDAyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 19:54:46 -0500
Received: from ozlabs.org ([203.10.76.45]:8916 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1946110AbWBDAyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 19:54:45 -0500
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: linuxppc64-dev@ozlabs.org
Subject: Re: how to limit memory with 2.6.10 on ppc64 machine?
Date: Sat, 4 Feb 2006 11:54:02 +1100
User-Agent: KMail/1.8.3
Cc: "Christopher Friesen" <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
References: <43E3E55C.90504@nortel.com>
In-Reply-To: <43E3E55C.90504@nortel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1835264.jkXDD4jY3A";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602041154.12710.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1835264.jkXDD4jY3A
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sat, 4 Feb 2006 10:21, Christopher Friesen wrote:
> I'm running 2.6.10 on a ppc64 machine with 4GB of memory.
>
> We're debugging an issue and would like to try and see if disabling the
> U3 DART makes the problem go away.  Unfortunately, this particular blade
> is unstable if not all the memory banks are populated.
>
> After some frustration I looked at the code and realized that the "mem=3D"
> functionality is not supported for ppc64 on this particular kernel.
>
> Can anyone give me some advice on the simplest way to limit this thing
> to under 2GB of memory so that the DART is not allocated/used?
>
> Does anyone know when support for "mem=3D" was added?  I know it is there
> in the current git version, but the "powerpc" consolidation means
> everything is all different now.

=46rom memory (harhar) the mem=3D support was merged in 2.6.11, so the orig=
inal=20
patch should _probably_ apply on a vanilla 2.6.10 tree, try it:

http://patchwork.ozlabs.org/linuxppc64/patch?id=3D724

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

email: michael:ellerman.id.au
inmsg: mpe:jabber.org
wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart1835264.jkXDD4jY3A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4/s0dSjSd0sB4dIRAlJhAJ9MZ27iHlgxfr5VuoCk78gkXIg4lwCbBnbI
QIW4V8k9EAPXFaCUOTQuc+s=
=mnDS
-----END PGP SIGNATURE-----

--nextPart1835264.jkXDD4jY3A--
