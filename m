Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVGCVRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVGCVRp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 17:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVGCVRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 17:17:45 -0400
Received: from ns2.suse.de ([195.135.220.15]:19913 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261538AbVGCVRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 17:17:42 -0400
Date: Sun, 3 Jul 2005 23:17:32 +0200
From: Kurt Garloff <garloff@suse.de>
To: James Morris <jmorris@redhat.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Greg Kroah-Hartman <gregkh@suse.de>, Steve Beattie <smb@wirex.com>,
       linux-security-module@wirex.com
Subject: Re: [PATCH 3/3] Use conditional
Message-ID: <20050703211732.GG11093@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	James Morris <jmorris@redhat.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
	Greg Kroah-Hartman <gregkh@suse.de>, Steve Beattie <smb@wirex.com>,
	linux-security-module@wirex.com
References: <20050703154405.GE11093@tpkurt.garloff.de> <Xine.LNX.4.44.0507031250290.30007-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aziWXe2aaRGlkyg3"
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0507031250290.30007-100000@thoron.boston.redhat.com>
X-Operating-System: Linux 2.6.11.4-21.7-default i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aziWXe2aaRGlkyg3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi James,

[added linux-security-module@wirex.com to Cc]

On Sun, Jul 03, 2005 at 12:51:20PM -0400, James Morris wrote:
> On Sun, 3 Jul 2005, Kurt Garloff wrote:
>=20
> > capablities is used. These are not called via indirect calls but=20
> > called as hardcoded calls and might thus be inlined; the price for
> > this is a conditional -- benchmarks done by hp showed this to be
> > beneficial (on ia64).
>=20
> What about on i386, x86_64 or ppc64?

We tested on i386 as well at the time, and it looked like a tiny
improvement. But doing the statistics, it was in the noise.=20
I have no numbers for x86_64 or ppc64.

If you have reason to believe that there could be regressions, we=20
should indeed do the benchmarks.

Sidenote: The patches 1 -- 2b alone still make sense, so I would
vote not for delaying their inclusion until we can collect numbers
for all arches we care about to take a decision on patch 3.

Best,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--aziWXe2aaRGlkyg3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCyFXsxmLh6hyYd04RArsBAJ463zK2WxP+dfRvkzb4DmbXIaDfVQCgk2VG
I6Mt75PTIZ8OlydpgFcvvAE=
=vpYh
-----END PGP SIGNATURE-----

--aziWXe2aaRGlkyg3--
