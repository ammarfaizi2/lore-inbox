Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVGDMLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVGDMLj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 08:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVGDMKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 08:10:25 -0400
Received: from ns1.suse.de ([195.135.220.2]:14723 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261648AbVGDMIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 08:08:11 -0400
Date: Mon, 4 Jul 2005 14:08:09 +0200
From: Kurt Garloff <garloff@suse.de>
To: serge@hallyn.com
Cc: Tony Jones <tonyj@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Steve Beattie <smb@wirex.com>,
       Linux LSM list <linux-security-module@wirex.com>
Subject: Re: [PATCH 3/3] Use conditional
Message-ID: <20050704120809.GR11137@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>, serge@hallyn.com,
	Tony Jones <tonyj@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
	James Morris <jmorris@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, Steve Beattie <smb@wirex.com>,
	Linux LSM list <linux-security-module@wirex.com>
References: <20050703154405.GE11093@tpkurt.garloff.de> <20050703190007.GA30292@immunix.com> <20050704065902.GO11093@tpkurt.garloff.de> <20050704074449.GA12963@immunix.com> <20050704120105.GB27617@vino.hallyn.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hnpg0BSo5EvPlUVi"
Content-Disposition: inline
In-Reply-To: <20050704120105.GB27617@vino.hallyn.com>
X-Operating-System: Linux 2.6.11.4-21.7-default i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Hnpg0BSo5EvPlUVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Serge,

On Mon, Jul 04, 2005 at 07:01:05AM -0500, serge@hallyn.com wrote:
> Quoting Tony Jones (tonyj@suse.de):
> > On Mon, Jul 04, 2005 at 08:59:02AM +0200, Kurt Garloff wrote:
> >=20
> > > > The topic of replacing dummy (with capability) was discussed there
> > > > last week, in the context of stacker, but a common solution for both
> > > > cases would be needed.
> > >=20
> > > Both cases?
> >=20
> > CONFIG_SECURITY_STACKER and !CONFIG_SECURITY_STACKER ;-)
> >=20
> > http://mail.wirex.com/pipermail/linux-security-module/2005-June/6200.ht=
ml
> >=20
> > I was assuming (bad of me I know) that Serge's patch would nail both ca=
ses
> > with one stone.
>=20
> Yes, sorry, I never got around to the replace-dummy-with-capability
> patch.  There wasn't a single cry when Chris asked for anyone who'd
> care about dummy being removed, so I do plan on switching that.

I was a bit careful: My patch did switch the default, but LSMs that
don't fill in all security_ops would still fall back to dummy, just
to make sure there is no possibly unintended change in behaviour.

Getting rid of dummy entirely would be better, I agree, but someone
needs to review that this won't break anything.

So how should we proceed?
You want to do the dummy removal first, then have stacker merged
and then what remains of my patches? Or should I start ... ?

Regards,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--Hnpg0BSo5EvPlUVi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCySapxmLh6hyYd04RAgpyAJ9DdbsugAo+vMPQ1FXkXBw0W/OBvACdEErn
KNjs6L8Ow2a5Q2354fmVVIE=
=lOrs
-----END PGP SIGNATURE-----

--Hnpg0BSo5EvPlUVi--
