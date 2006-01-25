Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWAYPq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWAYPq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 10:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWAYPq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 10:46:29 -0500
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]:33246 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S1750709AbWAYPq2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 10:46:28 -0500
Date: Wed, 25 Jan 2006 10:44:02 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Denis Vlasenko <vda@ilport.com.ua>,
       "John W. Linville" <linville@tuxdriver.com>, jbenc@suse.cz,
       netdev@vger.kernel.org, softmac-dev@sipsolutions.net,
       linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de
Subject: Re: [softmac-dev] [PATCH] ieee80211_rx_any: filter out packets, call ieee80211_rx or ieee80211_rx_mgt
Message-ID: <20060125154402.GB9224@shaftnet.org>
Mail-Followup-To: Johannes Berg <johannes@sipsolutions.net>,
	Denis Vlasenko <vda@ilport.com.ua>,
	"John W. Linville" <linville@tuxdriver.com>, jbenc@suse.cz,
	netdev@vger.kernel.org, softmac-dev@sipsolutions.net,
	linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de
References: <20060118200616.GC6583@tuxdriver.com> <200601221404.52757.vda@ilport.com.ua> <1138026752.3957.98.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <1138026752.3957.98.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.2 (shaft.shaftnet.org [127.0.0.1]); Wed, 25 Jan 2006 10:44:04 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 23, 2006 at 03:32:32PM +0100, Johannes Berg wrote:
> Shouldn't you BSS-filter management packets too?

Filtering on BSSID is necessary for management frames, especially when=20
multicast management frames are thrown into the mix. =20

For example, STAs are supposed to respect broadcast disassoc/deauth
messages, but of course should ignore them if they're not destined for
the local BSSID.=20

The only extra-BSS management frames that should not be dropped are are
beacons and probe responses.  That said, probe responses are directed so
our A1 (RA) filter will probably drop the frame if it is not destined
for us.

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL 					=20
Quidquid latine dictum sit, altum viditur.

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFD15zCPuLgii2759ARAsloAJ9hugn9Q0jiHJkrQBwepiaquYAdfACdEAE1
ysLRFcd+xhTmpumLy34ua6o=
=LvVx
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
