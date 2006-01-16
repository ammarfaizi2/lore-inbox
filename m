Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWAPU7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWAPU7b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 15:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWAPU7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 15:59:31 -0500
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]:5808 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S1751194AbWAPU7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 15:59:30 -0500
Date: Mon, 16 Jan 2006 15:58:59 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: Sam Leffler <sam@errno.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Johannes Berg <johannes@sipsolutions.net>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
Message-ID: <20060116205859.GD12748@shaftnet.org>
Mail-Followup-To: Sam Leffler <sam@errno.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost> <20060114011726.GA19950@shaftnet.org> <43C97605.9030907@pobox.com> <20060115152034.GA1722@shaftnet.org> <43CAA853.8020409@errno.com> <20060116172817.GB8596@shaftnet.org> <43CBDDC7.9060504@errno.com> <20060116194013.GA12748@shaftnet.org> <43CBFE90.8070208@errno.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
In-Reply-To: <43CBFE90.8070208@errno.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.2 (shaft.shaftnet.org [127.0.0.1]); Mon, 16 Jan 2006 15:59:00 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2006 at 12:14:08PM -0800, Sam Leffler wrote:
> Please read what I wrote again.  Station mode power save work involves=20
> communicating with the ap and managing the hardware.  The first=20
> interacts with bg scanning.  We haven't even talked about how to handle=
=20
> sta mode power save.

I think we're arguing over semantics; what's important here is that the
STA tells the AP to buffer frames while we're performing a scan,
correct?
=20
> If you wait until the end of the scan to return to the bss channel then=
=20
> you potentially miss buffered mcast frames.  You can up the station's=20
> listen interval but that only gets you so far.  As I said there are=20
> tradeoffs in doing this.

An excellent point.  This is particularly relevant for APs that have a
DTIM interval of 1 -- if you're doing a passive scan, the dwell time on
that other channel (you need at least one beacon interval) could cause
you to miss bufferend MCAST frames.

In all fairness I don't think I've seen any implementations that handle
this cleanly.

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL 					=20
Quidquid latine dictum sit, altum viditur.

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDzAkTPuLgii2759ARAm3JAJ9TPFf5WKVjYZ7jrn65IiFzJEAuiACgu2qZ
l7BzmAzAGElff9QpgNACfBY=
=dOnv
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--
