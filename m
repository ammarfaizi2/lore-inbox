Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbUFBPC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUFBPC3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUFBPC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:02:28 -0400
Received: from lists.us.dell.com ([143.166.224.162]:38531 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S263107AbUFBPBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:01:43 -0400
Date: Wed, 2 Jun 2004 10:00:51 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Sean Estabrooks <seanlkml@sympatico.ca>, szepe@pinerecords.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.x partition breakage and dual booting
Message-ID: <20040602150051.GA3165@lists.us.dell.com>
References: <20040530183609.GB5927@pclin040.win.tue.nl> <40BA2E5E.6090603@pobox.com> <20040530200300.GA4681@apps.cwi.nl> <s5g8yf9ljb3.fsf@patl=users.sf.net> <20040531180821.GC5257@louise.pinerecords.com> <s5gaczonzej.fsf@patl=users.sf.net> <20040531170347.425c2584.seanlkml@sympatico.ca> <s5gfz9f2vok.fsf@patl=users.sf.net> <20040601235505.GA23408@apps.cwi.nl> <s5gpt8ijf1g.fsf@patl=users.sf.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <s5gpt8ijf1g.fsf@patl=users.sf.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 02, 2004 at 09:02:23AM -0400, Patrick J. LoPresti wrote:
> Andries Brouwer <Andries.Brouwer@cwi.nl> writes:
> > Please, now that this is still unused, fix your names and/or
> > your code. Names could be legacy_max_head (etc.) if you want
> > to keep the values, or otherwise add 1 to the values.
>=20
> Well, the EDD module belongs to Matt Domsch.  I only contributed the
> "legacy_*" code and names.
>=20
> If it is OK with Matt, I agree we should rename legacy_heads to
> legacy_max_head and legacy_sectors to legacy_sectors_per_track.  I
> doubt anybody other than myself is using these yet anyway.

Yes, please submit a patch now to Andrew, cc: me and linux-kernel at
least.   I've confirmed that our internal tools are not using these
fields yet.
=20
> > Also - people will try to match the 0x7280b80 for int13_dev83 with
> > the 120064896 sectors that dmesg or hdparm -g reports for /dev/hdf.
> > Life would be easier with values given in decimal, as they are
> > everywhere else.
>=20
> I used hex for legacy_* because that is what all the other fields
> already used.  It was not my decision, and I have no opinion either
> way.  Convince Matt.

Whatever, scanf works with either representation.  Patrick, if you're
changing the above, feel free to submit a second patch to switch these
all to %u instead.

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAveujIavu95Lw/AkRAuHdAKCIDgMYqImdyvXwLXEQcMCLxAIiswCghHRh
x1FED7yoUEfUHjLlYwxzKyg=
=WXas
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
