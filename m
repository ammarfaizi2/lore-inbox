Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423054AbWAMWfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423054AbWAMWfT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423053AbWAMWfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:35:19 -0500
Received: from sipsolutions.net ([66.160.135.76]:44817 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1423051AbWAMWfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:35:17 -0500
Subject: Re: wireless: recap of current issues (other issues)
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060113222408.GM16166@tuxdriver.com>
References: <20060113195723.GB16166@tuxdriver.com>
	 <20060113212605.GD16166@tuxdriver.com>
	 <20060113213237.GH16166@tuxdriver.com>
	 <20060113222408.GM16166@tuxdriver.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ykjEvNySpsB7NBD/naZC"
Date: Fri, 13 Jan 2006 23:35:11 +0100
Message-Id: <1137191711.2520.69.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ykjEvNySpsB7NBD/naZC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-01-13 at 17:24 -0500, John W. Linville wrote:

> Radiotap headers make sense for an rfmon virtual device.  I don't
> think it makes sense for "normal" usage.  Should there be an option
> for radiotap headers on non-rfmon links?

Yes. For hardware debugging.

> Rfmon interferes w/ other interfaces, but may be handy to enter/leave
> w/ little effort.  Perhaps a config option for physical device to
> suspend/resume all (non-rfmon) virtual devices before/after enabling
> rfmon virtual device?  (Would multiple rfmon devices even make sense?
> If not, is it worth restricting that?)

Multiple rfmon devices make sense in hypothetical or future hardware if
different channels are supported on one WiPHY at once, but the rfmon
device shall be restricted to a single one. Since we probably need a way
to deactivate virtual devices anyway, having a config option to
suspend/resume all others doesn't make sense -- userspace programs can
just as well cycle over them and do it themselves.

johannes

--=-ykjEvNySpsB7NBD/naZC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ8grHaVg1VMiehFYAQKR3xAAmJDpSsqv5KKOH4vuzA7FpqEswRPfKzgu
XtZq0DbsjRbi2P8cRG1wyBuswHxu3kQaoU46HAuICJmbpxj/VMuzIuZOlwQXqUE8
V+XneiwH4Aj09OxLOjlzvg6hmzy10+8XOvA9PrlnLQWmFLkpMHsoahdtG46ho6Da
t7AU/Atzb7KuefkQgeMFejqiEmDnw5IZQTMSUwjkThwKqTowd7dxdmpv1M1EOkhA
bK/Ion4x+4Tkkd4gX7vVuvCfK3dEGsr//PSq0pRo1pBZZlap6w+IZZ6Sxc2qOmgh
JrUo5i314GcQIdAT4GVkbU1Ryr6vLjqCnAY9Cd/PQu8EhP0QX2weO3fB9SQZ4ktb
ZXbgQwshV40F1RF+S7Azmyg94wK+7tixcYZFMo95GPGsKUmcMz9NP6Hv7cpfk9P1
y/MxyVEz5zVyOEvy1Uz3vfJ09vj5P6nc0aumk2rCve3P+v/ptZp1Dxm4rHTd3sFw
TqYODhBj7kM6hbS3RWetVZZDPbNeYxwXoZSJtmOTeLf6CnIAuVtXOUI5ma5QnGCb
2XK+ovPm/+SeAUuW1i7nESimFjZavlOR865JGbVyXm9lP0BcoM2ZYeWaRU927atn
U8wuC/zs3K8EA7Z6lic2kuISaXxzn0naemkISbr5UFF440LKqTjF4i3D0hlVjCmn
DitDzVXjIMY=
=FWgz
-----END PGP SIGNATURE-----

--=-ykjEvNySpsB7NBD/naZC--

