Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268420AbUIWM0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268420AbUIWM0S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 08:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268421AbUIWM0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 08:26:18 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:55009 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268420AbUIWM0P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 08:26:15 -0400
Date: Thu, 23 Sep 2004 14:24:28 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Thomas Habets <thomas@habets.pp.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Message-ID: <20040923122428.GA8816@thundrix.ch>
References: <200409230123.30858.thomas@habets.pp.se> <20040923044549.GE6889@thundrix.ch> <200409230857.57145.thomas@habets.pp.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <200409230857.57145.thomas@habets.pp.se>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Thu, Sep 23, 2004 at 08:57:50AM +0200, Thomas Habets wrote:
> Yup. What would be a good interface for setting that flag per-process?=20
> prctl()?
> Personally, I'd prefer it without userspace having to write code for it.

Well, either  via a  new syscall/ioctl, or  via some exported  file in
/proc or /sys. I guess the second approach (file) will be prefered.

> Also, it should be able to protect against a DoS where a user launches N=
=20
> un-OOM-killable processes.

You can still  do that. Maybe kill those processes  first who got less
criterias matching the OOM gracefulness, so you can protect httpd more
strongly than xlock.

Also remember to set per-user limits of processes. :)

> > What about programs with spaces in its names?
>=20
> I thought "screw 'em". :-)

Now that's what I call policy!

			    Tonnerre

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBUsB7/4bL7ovhw40RAicGAJ0cEpGMltVpghrCH/HtwkzlwuYmxgCeLQQZ
Y5mPaRI/s3mPLJqPpjdkRMk=
=hWca
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
