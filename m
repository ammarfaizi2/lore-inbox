Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUHULx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUHULx0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 07:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUHULx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 07:53:26 -0400
Received: from smtprelay02.uni-oldenburg.de ([134.106.40.86]:3968 "EHLO
	smtprelay02.uni-oldenburg.de") by vger.kernel.org with ESMTP
	id S262329AbUHULxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 07:53:22 -0400
Date: Sat, 21 Aug 2004 13:53:16 +0200
From: matthias brill <matthias.brill@akamail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       cpufreq list <cpufreq@www.linux.org.uk>
Subject: Re: banias with different (unusual?) model_name
Message-ID: <20040821115316.GA2582@akamail.com>
Reply-To: matthias.brill@akamail.com
References: <20040820093344.GA2923@akamail.com> <1093008335.30968.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <1093008335.30968.32.camel@localhost.localdomain>
X-Conspiracy: there is no conspiracy
User-Agent: Mutt/1.5.6+20040803i
X-PMX-Version: 4.6.1.107272, Antispam-Core: 4.6.1.106808, Antispam-Data: 2004.8.20.110968
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__TO_MALFORMED_2 0, __HAS_MSGID 0, __SANE_MSGID 0, __REFERENCES 0, __MIME_VERSION 0, __CT 0, __CTYPE_HAS_BOUNDARY 0, __CTYPE_MULTIPART 0, __CD 0, __IN_REP_TO 0, __USER_AGENT 0, EMAIL_ATTRIBUTION 0, QUOTED_EMAIL_TEXT 0, SIGNATURE_SHORT_DENSE 0, REFERENCES 0.000, IN_REP_TO 0, USER_AGENT 0.000'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi alan, jeremy

On Fri, Aug 20, 2004 at 02:25:36PM +0100, Alan Cox wrote:
> > i've found a pentium-m banias which reports "Mobile Genuine Intel(R)
> > processor       1400MHz" in /proc/cpuinfo.  this (strange?) signature
> > prevents speedstep-centrino.c from working properly.
>=20
> Signatures appear to be BIOS set so that would make sense.

that fact wasn't obvious to me -- i've updated the BIOS and the strange
banias signature is now gone.  it reports the expected "Intel(R)
Pentium(R) M processor 1400MHz" string now.

in excess the "ACPI-behaviour" changes from "totally broken" to "not
working" which is kind of a progress... 8-}


On Fri, Aug 20, 2004 at 07:19:31PM -0700, Jeremy Fitzhardinge wrote:
> Yeah, there seem to be a few of these around.  I'm just not certain that
> they're identical to "normal" Banias as far as operating points go.

it seems that the reported value depends on the mental health of the
BIOS-programmer at hand, therefore the suplied string might not be
trustworthy.

if i understand correctly, the type of the cpu can be determined by
looking at the family, model and stepping -- assuming that these values
are reported directly  by the CPUID (0FA2) instruction.=20

the BIOS supplied model_name string in speedstep-centrino.c is parsed to
get the clock cycle time of the cpu.  is this actually supposed to be
the "right" way (or worse: the only way) to get this information?


thias

--=20
Matthias Brill <matthias.brill@akamail.com>

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBJzes15PQg+xdZ4cRAjSeAJ9VmtjiMrdtbNl/3kWXDfWuakjM0QCg32V4
3YG4FoaJu2AQ715gSyNxZ4A=
=7430
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
