Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVBNX3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVBNX3I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 18:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVBNX3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 18:29:07 -0500
Received: from s-utl01-nypop.stsn.com ([199.106.90.52]:24275 "HELO
	s-utl01-nypop.stsn.com") by vger.kernel.org with SMTP
	id S261333AbVBNX2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 18:28:00 -0500
Date: Tue, 15 Feb 2005 00:27:57 +0100
From: Kurt Garloff <garloff@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] 4/5: LSM hooks rework
Message-ID: <20050214232757.GJ18744@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Rik van Riel <riel@redhat.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
References: <20050213210515.GH27893@tpkurt.garloff.de> <20050213211034.GI27893@tpkurt.garloff.de> <20050213211109.GJ27893@tpkurt.garloff.de> <20050213211139.GK27893@tpkurt.garloff.de> <20050213211210.GL27893@tpkurt.garloff.de> <Pine.LNX.4.61.0502141152560.14001@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bWEb1MG/o7IKOlQF"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502141152560.14001@chimarrao.boston.redhat.com>
X-Operating-System: Linux 2.6.11-rc4-20050214001414-default i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 14 Feb 2005 23:27:59.0536 (UTC) FILETIME=[D209B300:01C512EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bWEb1MG/o7IKOlQF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rik,

On Mon, Feb 14, 2005 at 11:54:07AM -0500, Rik van Riel wrote:
> On Sun, 13 Feb 2005, Kurt Garloff wrote:
>=20
> >The case that security_ops points to the default capability_
> >security_ops is the fast path and arguably the more likely one
> >on most systems.
>=20
> Quite a few distributions ship with other security modules
> enabled by default, so I'm not sure we should add a "likely"
> here - let the CPU's branch prediction sort things out.

Fine with me. I had the fast path in mind, but with some
luck, CPU branch prediction will work for us.

I sent out the full patch set, which moves the code from
vanilla to the code we've been shipping since 7 months.
And I made the changes in the order to make the ones that I
expect the least controversial come first.

If we can't find consensus for patches 4 and 5, I'd still
think applying 1 -- 3 is useful.

Regards,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--bWEb1MG/o7IKOlQF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCETP9xmLh6hyYd04RAkiDAJ0ZT/uRuphRgvNR7YK5SMiqNj63TQCfSRaw
RmpW01dxDywE52DFllZpAyY=
=sZAV
-----END PGP SIGNATURE-----

--bWEb1MG/o7IKOlQF--
