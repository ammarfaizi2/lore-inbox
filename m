Return-Path: <linux-kernel-owner+willy=40w.ods.org-S777735AbUKBF4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S777735AbUKBF4S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 00:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S777731AbUKBF4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 00:56:17 -0500
Received: from smtp816.mail.sc5.yahoo.com ([66.163.170.2]:30377 "HELO
	smtp816.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264138AbUKBFz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 00:55:57 -0500
Date: Mon, 1 Nov 2004 21:55:55 -0800
To: adaplas@pol.net
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: Problem with current fb_get_color_depth function
Message-ID: <20041102055555.GJ6361@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org, adaplas@pol.net,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-fbdev-devel@lists.sourceforge.net
References: <20041010225903.GA2418@darjeeling.triplehelix.org> <200410110832.19978.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iJXiJc/TAIT2rh2r"
Content-Disposition: inline
In-Reply-To: <200410110832.19978.adaplas@hotpop.com>
User-Agent: Mutt/1.5.6+20040722i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--iJXiJc/TAIT2rh2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[ long overdue follow-up ]

On Mon, Oct 11, 2004 at 08:33:10AM +0800, Antonino A. Daplas wrote:
> So, linux_logo_224 cannot be drawn when visual is directcolor at RGB555 or
> RGB565 because the logo clut requirements exceeds the hardware clut
> capability. You need to use a logo image with a lower depth such as the
> 16-color logo, linux_logo_16.

This is weird, because removing that conditional from fb_get_color_depth
allows a 224-color logo to show correctly on my Radeon framebuffer, in
full color.

Otherwise, it is dithered to kingdom come and mostly appears all orange
and black.

You may be right conceptually, but the fact of the matter is that this
is a regression because 224-color logos work perfectly with the old
fb_get_color_depth. So what is the real problem?

> In short, fb_get_color_depth() and radeonfb both do the correct thing, but
> you need a logo with a lower color depth. Or choose RGB888 or higher, or
> set the visual to truecolor.

What does that last sentence mean? -- I have no idea...

> PS: Note that this behavior is the same as 2.4 behavior (224-color logo is
> only chosen if directcolor and bpp >=3D 24).  It might have worked before=
, and
> this is probably due to the directcolor clut being ramped to truecolor
> values. However, the correct solution is to use a 16-color logo.

Oh, I see, I didn't read this before.

Well, 16-color logos being used when 224-color ones work perfectly
enough 99% of the time is pretty bad aesthetically, if you ask me.

--=20
Joshua Kwan

--iJXiJc/TAIT2rh2r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQYchaqOILr94RG8mAQIbzw//Vr7HKPSfizutcsDWLDaSDDfyxBQ2ZaK5
9syczy5lyzdz+As7ltaye5hHeANLnWYGXeS6vcuSODc7ZEZ/yO/R4H2avOh8iTUj
69PFkFIY/jqUKz3S3z+1tCdpAPsUcF8N2UMXPSLbks9XWnzeF01zPNOP4X5MbjzR
x/PFtxuJuZgp04dxvJMiWSrIpLHnccq3oX4jaP5RM4SvnVHQxEOOKCh6KXg+FxDr
1OENYt94PqokcZYDv853IQTmKH072Dz33urtJi+kLQCAIvgGNZF8ukwblGhNmbwX
N0O5SZpWKBTd2aGmfAKvvxTiEzDmGoLjJ5/+iIg/j55sRibJFeHSN9TuIaYqlqrR
RHhg8LoofjjHYEHTpdfWGeCXNX4IT2T2EsjagQw9j40RoojjGj5NnELKtRTDvfpd
mPZgwL0c7H5UkYwvRk56SNUP/2v5Lz+ZRj/CNTOXlgv2COAqxtz1IpyDqFJrGYf5
EdRzJIgWZF6/xLrN9CPMqih1McRK5YbxslHI80+vLbgHioWZNjHhNw91FVczzawd
HElIMfEpkhP/ZNhle9AEjh94nd81gSeAPfVMuqfEy9WmTef1YE8Jd5ICFI01whaI
FSKim8tW77mbSuAfNdW+UfGt4KfBnhNIibXWVuswnTG5gLfe7ODR9+HfVOnvsYxn
ywyzXhqbe3g=
=2pCR
-----END PGP SIGNATURE-----

--iJXiJc/TAIT2rh2r--
