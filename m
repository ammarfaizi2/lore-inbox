Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVGDNyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVGDNyT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 09:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVGDNyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 09:54:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:4013 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261722AbVGDNcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 09:32:08 -0400
Date: Mon, 4 Jul 2005 15:31:51 +0200
From: Kurt Garloff <garloff@suse.de>
To: serge@hallyn.com
Cc: Tony Jones <tonyj@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Steve Beattie <smb@wirex.com>,
       Linux LSM list <linux-security-module@wirex.com>
Subject: Re: [PATCH 3/3] Use conditional
Message-ID: <20050704133151.GW11137@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>, serge@hallyn.com,
	Tony Jones <tonyj@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
	James Morris <jmorris@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, Steve Beattie <smb@wirex.com>,
	Linux LSM list <linux-security-module@wirex.com>
References: <20050703154405.GE11093@tpkurt.garloff.de> <20050703190007.GA30292@immunix.com> <20050704065902.GO11093@tpkurt.garloff.de> <20050704074449.GA12963@immunix.com> <20050704120105.GB27617@vino.hallyn.com> <20050704120809.GR11137@tpkurt.garloff.de> <20050704123721.GA28322@vino.hallyn.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0p3EEgCnBt7M6rub"
Content-Disposition: inline
In-Reply-To: <20050704123721.GA28322@vino.hallyn.com>
X-Operating-System: Linux 2.6.11.4-21.7-default i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0p3EEgCnBt7M6rub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Serge,

On Mon, Jul 04, 2005 at 07:37:21AM -0500, serge@hallyn.com wrote:
> Quoting Kurt Garloff (garloff@suse.de):
> > Getting rid of dummy entirely would be better, I agree, but someone
> > needs to review that this won't break anything.
>=20
> Unfortunately I think it's way too soon for that.  Even if stacker is
> accepted, it is still a module (for now at least) which can be compiled
> out.  So we'll need dummy hooks for modules (like seclvl) to use.  I
> just don't think it's possible to get rid of that yet.

Hmmmm, getting rid of dummy would mean replacing it with capability.
- The differences between cap and dummy affect a relatively small
  subset of hooks
- If all of these hooks are implemented by all LSMs, we're done and
  can just remove dummy and replace it by capability.
- If not, we'd need to review for all of these LSMs, whether defaulting
  to capability rather than dummy could create a problem and whether=20
  that can be addressed easily.

seclvl would probably need some changes, indeed.

root_plug could become shorter :-)

> > So how should we proceed?
> > You want to do the dummy removal first, then have stacker merged
> > and then what remains of my patches? Or should I start ... ?
>=20
> I think your patches to make capability the default are the best
> place to start.  Doing the same under stacker will be trivial, and
> I'll do that in the next set I send out.

Sounds good!
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--0p3EEgCnBt7M6rub
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCyTpHxmLh6hyYd04RAgpRAJ418VoVgKnTUr8Im++9EBg6GMuIPwCgnhKX
yBjzJLz8bpIjycHwwBAlWS4=
=WJir
-----END PGP SIGNATURE-----

--0p3EEgCnBt7M6rub--
