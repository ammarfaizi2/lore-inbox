Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVAERcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVAERcK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVAERaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:30:16 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:32180 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S262287AbVAER2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:28:53 -0500
Date: Wed, 5 Jan 2005 19:28:50 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Jim Nelson <james4765@cwazy.co.uk>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, linuxsh-shmedia-dev@lists.sourceforge.net
Subject: Re: [PATCH /3] sh64: remove cli()/sti() from arch/sh64/*
Message-ID: <20050105172850.GA21683@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Jim Nelson <james4765@cwazy.co.uk>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	linux-kernel@vger.kernel.org,
	linuxsh-shmedia-dev@lists.sourceforge.net
References: <20050105022304.22296.7672.51691@localhost.localdomain> <20050105023405.GE26051@parcelfarce.linux.theplanet.co.uk> <41DB5ADB.9060102@cwazy.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <41DB5ADB.9060102@cwazy.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 04, 2005 at 10:11:23PM -0500, Jim Nelson wrote:
> Everything I've looked at so far has been for single-processor systems=20
> AFAICT - embedded processors, evaluation boards, etc.  I do not pretend=
=20
> to have intimate familiarity with the hardware in question, and I will=20
> be much more careful when I reach anything that can be plugged into an=20
> SMP box, but I was grabbing the low-hanging fruit first.  The nasty=20
> stuff (drivers/char, for example) will come later.
>=20
> That's why I cc'd the arch maintainers - figured they'd whack me with a=
=20
> cluebat if I'd overlooked something.

Yes, these are all UP cases, so at least for the sh and sh64 cases these
specific changes are fine.

sh ripped out the save_and_cli() mess a long time ago (during early 2.5
before Linus added the UP compat stuff), so these at least shouldn't
have been there in the first place (mpc1211 wasn't added until after the
fact however and seems to have gotten overlooked).

Anyways, I'll apply these patches to their respective trees, thanks.

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFB3CPS1K+teJFxZ9wRAvrUAJ9Y5kNx35AxhDY/MttJOAxeyDDeOQCeO1e5
olgGUIO1YwbggNdSnxGhS/I=
=ewJm
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
