Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWDYPSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWDYPSg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 11:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWDYPSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 11:18:36 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:1944
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932256AbWDYPSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 11:18:36 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: better leve triggered IRQ management needed
Date: Tue, 25 Apr 2006 17:23:01 +0200
User-Agent: KMail/1.9.1
References: <20060424114105.113eecac@localhost.localdomain> <1145911417.3116.69.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0604241354200.3701@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604241354200.3701@g5.osdl.org>
Cc: Alan Cox <alan@redhat.com>, Stephen Hemminger <shemminger@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2036234.226ERfZtuE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604251723.01448.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2036234.226ERfZtuE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 24 April 2006 23:07, you wrote:
> A long time ago, I had a machine with a 3c509 card that would sometimes=20

Heh, I still have this one in my server. :)

> The fake interrupt could even print out a warning if somebody returns=20
> SA_HANDLED (since normally there _shouldn't_ have been any work to handle=
=20
> for it),

Are you sure this can't race against the hardware?
Something like this:
Kernel                               Hardware
=2D generate fake IRQ
=2D enter the low level IRQ handling
                                     - hardware generates an IRQ and
                                       sets it's IRQ reason registers
                                       to "I have smthng to do"
=2D enter the handler and service
  the IRQ
=2D return SA_HANDLED

=2D-=20
Greetings Michael.

--nextPart2036234.226ERfZtuE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBETj7Vlb09HEdWDKgRAmcjAKCZcUJtGE4jZxaaHRf0uGpTyy8Z5ACfVtlT
8vr3YmReBV268qrrEABaQso=
=HkEb
-----END PGP SIGNATURE-----

--nextPart2036234.226ERfZtuE--
