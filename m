Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUBYSbF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbUBYSbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:31:04 -0500
Received: from smtp.golden.net ([199.166.210.31]:35334 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S261530AbUBYSay
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:30:54 -0500
Date: Wed, 25 Feb 2004 13:30:38 -0500
From: Paul Mundt <lethal@linux-sh.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Subject: Re: make help ARCH=xx fun
Message-ID: <20040225183038.GA24041@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Tom Rini <trini@kernel.crashing.org>,
	"James H. Cloos Jr." <cloos@jhcloos.com>,
	linux-kernel@vger.kernel.org
References: <m3y8qwv78e.fsf@lugabout.jhcloos.org> <20040222095021.GB2266@mars.ravnborg.org> <20040224215548.GF1052@smtp.west.cox.net> <20040225190049.GB2474@mars.ravnborg.org> <20040225180858.GW1052@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20040225180858.GW1052@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2004 at 11:08:59AM -0700, Tom Rini wrote:
> I can understand that.  How about:
> for board in arch/$(ARCH)/configs/*defconfig; \
>  do \
>    if [ -f $board ]; then
>     ...
>    fi
>  done
>=20
Simply just matching on *defconfig should be fine. I already changed this on
matching defconfig-* for sh to get around matching SCCS.

> > Also the "- Build for xxxxx" is not good enough.
>=20
> Erm, it's usually something descriptive enough, if one is firmiliar with
> the platform / what's intended to build.
>=20
> > I will try to come up with a patch the uses a file named
> > arch/$(ARCH)/configs/index.txt
>=20
> The 'issue' with configs/index.txt, I'll wager, is that for every new
> board, that's one more file to modify (and thus possibly conflict on).
>=20
Agreed. The whole reason I did the automated "- Build for foo" thing is that
it's completely automated, and people building should already know what the=
ir
target is (if not, they can look at arch/$(ARCH)/Kconfig and figure it out).
I suppose it's not particularly descriptive, but it seems more sensible to
have an abbreviated help text then none whatsoever.


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAPOnO1K+teJFxZ9wRAuo1AJ9bzcpRlDgc4+/FE8xU0TFWXbbodACcDWN3
uohckYY1qstgj+Ks/x5irt4=
=2YL5
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
