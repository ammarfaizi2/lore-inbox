Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWAVMZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWAVMZd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 07:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWAVMZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 07:25:33 -0500
Received: from mout1.freenet.de ([194.97.50.132]:20371 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S964781AbWAVMZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 07:25:32 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: [Bcm43xx-dev] Re: [PATCH] ieee80211_rx_any: filter out packets, call ieee80211_rx or ieee80211_rx_mgt
Date: Sun, 22 Jan 2006 13:25:13 +0100
User-Agent: KMail/1.8.3
References: <20060118200616.GC6583@tuxdriver.com> <200601221359.31482.vda@ilport.com.ua> <200601221408.45486.vda@ilport.com.ua>
In-Reply-To: <200601221408.45486.vda@ilport.com.ua>
Cc: bcm43xx-dev@lists.berlios.de, "John W. Linville" <linville@tuxdriver.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jbenc@suse.cz,
       softmac-dev@sipsolutions.net, bcm43xx-dev@lists.berlios.de
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1560844.cr1rRdo5s5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601221325.13553.mbuesch@freenet.de>
X-Warning: 85.212.27.254 is listed at list.dsbl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1560844.cr1rRdo5s5
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 22 January 2006 13:08, Denis Vlasenko wrote:
> On Sunday 22 January 2006 13:59, Denis Vlasenko wrote:
> > bcm43xx_rx() contains code to filter out packets from
> > foreign BSSes and decide whether to call ieee80211_rx
> > or ieee80211_rx_mgt. This is not bcm specific.
> >=20
> > Patch adapts that code and adds it to softmac
> > as ieee80211_rx_any() function.
> >=20
> > Diffed against wireless-2.6.git
> >=20
> > Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
> > --
> > vda
>=20
> Please ignore this one. This is not good:
>=20
> +=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Areturn ieee80211_rx_mgt(iee=
e, hdr, stats);
>=20
> Use corrected patch in my another email with
> "Date: Sun, 22 Jan 2006 14:04:52 +0200"
> --
> vda

I would say, please also move the
static inline int is_mcast_or_bcast_ether_addr(const u8 *addr)
function into linux/etherdevice.h

=2D-=20
Greetings Michael.

--nextPart1560844.cr1rRdo5s5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD03mplb09HEdWDKgRAkMNAKCBQgtkK77KENr0QYlHWELdLe5jGQCfVl0e
dQlNBXCXUrVpdbt33BGU8gI=
=PmRV
-----END PGP SIGNATURE-----

--nextPart1560844.cr1rRdo5s5--
