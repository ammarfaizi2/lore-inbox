Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWAPRd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWAPRd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 12:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWAPRd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 12:33:56 -0500
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]:24022 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S1750762AbWAPRdz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 12:33:55 -0500
Date: Mon, 16 Jan 2006 12:33:25 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jiri Benc <jbenc@suse.cz>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "John W. Linville" <linville@tuxdriver.com>
Subject: Re: wireless: recap of current issues (configuration)
Message-ID: <20060116173325.GC8596@shaftnet.org>
Mail-Followup-To: Johannes Berg <johannes@sipsolutions.net>,
	Jiri Benc <jbenc@suse.cz>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"John W. Linville" <linville@tuxdriver.com>
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com> <20060113213011.GE16166@tuxdriver.com> <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost> <20060116152312.6b9ddfd0@griffin.suse.cz> <1137423355.2520.112.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
In-Reply-To: <1137423355.2520.112.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.2 (shaft.shaftnet.org [127.0.0.1]); Mon, 16 Jan 2006 12:33:26 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2006 at 03:55:55PM +0100, Johannes Berg wrote:
> I really don't see why a plain STA mode card should be required to carry
> around all the code required for AP operation -- handling associations
> of clients, powersave management wrt. buffering, ... Sure, fragmentation

=46rom the perspective of the hardware driver, there is little AP or=20
STA-specific code, especially when IBSS is thrown in.  Thick MACs=20
excepted, there's little more than "frame tx/rx, and hardware control=20
twiddling". =20

The AP/STA smarts happen in the 802.11 stack.  And, speaking from=20
experience, it is very hard to separate them cleanly, at least not=20
without incurring even more overall complexity and bloat.

It's far simpler to build them intertwined, then add a bunch of #ifdefs=20
if you want to disable AP or STA mode individually to save space.

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL 					=20
Quidquid latine dictum sit, altum viditur.

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDy9jlPuLgii2759ARAlDbAKCHLtNrnkXqRW8pfK7KKfGBF/6WTQCgpmTa
SKVAsTgvOGomLuBFSqxLzlc=
=xRqN
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
