Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVLZUD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVLZUD0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 15:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVLZUD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 15:03:26 -0500
Received: from isilmar.linta.de ([213.239.214.66]:8367 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932129AbVLZUDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 15:03:25 -0500
Date: Mon, 26 Dec 2005 21:03:19 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: "Theodore Ts'o" <tytso@mit.edu>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Pavel Machek <pavel@ucw.cz>, Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] i386 No Idle HZ aka dynticks 051221
Message-ID: <20051226200319.GA3476@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Theodore Ts'o <tytso@mit.edu>, Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Daniel Petrini <d.pensator@gmail.com>,
	Tony Lindgren <tony@atomide.com>, vatsa@in.ibm.com,
	ck list <ck@vds.kolivas.org>, Pavel Machek <pavel@ucw.cz>,
	Adam Belay <abelay@novell.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>
References: <200512210310.51084.kernel@kolivas.org> <20051225171617.GA6929@thunk.org> <20051226025525.GA6697@thunk.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20051226025525.GA6697@thunk.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, Dec 25, 2005 at 09:55:26PM -0500, Theodore Ts'o wrote:
> Looking at acpi/processor_idle.c, there is all sorts of magic special
> cases code for the C2 and C3 states (both for promotion/demotion
> polcies, as well as what to do when idling in those particular
> states), and which doesn't exist for other states, such as C4.

The magic is for C2- and C3-_type_ sleep, and C4 is of type C3... I know,
this numbering is very confusing, but that's the way it is... However, the
sepcially added "magic" for dyntick still needs some tweaking; I'll try to
improve (and hopefully streamline) it a bit. As a first test, could you
remove the "Fast-path demotion" case and re-test?

Thanks,
	Dominik

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDsEyHPB5F+WW+qdIRAv5tAKDdsjF1kBnXIdQ0PCrMfup+07CKnwCg93g+
JtD81jat7F8dnJtVkvaCxI0=
=x8P8
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
