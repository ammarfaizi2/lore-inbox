Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265043AbUD3C4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265043AbUD3C4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 22:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUD3C4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 22:56:17 -0400
Received: from lists.us.dell.com ([143.166.224.162]:1173 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S265043AbUD3C4P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 22:56:15 -0400
Date: Thu, 29 Apr 2004 21:55:58 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Rusty Russell <rusty@rustcorp.com.au>, greg@kroah.com
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: always store MODULE_VERSION("") data?
Message-ID: <20040430025558.GA26551@lists.us.dell.com>
References: <20040427145812.GA20421@lists.us.dell.com> <1083200122.9669.16.camel@bach>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <1083200122.9669.16.camel@bach>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 29, 2004 at 10:55:22AM +1000, Rusty Russell wrote:
> On Wed, 2004-04-28 at 00:58, Matt Domsch wrote:
> > How hard would it be to always include the space for the
> > MODULE_VERSION("") data rather than specifying it in each file that
> > doesn't care, and only modules with their own versioning could put
> > MODULE_VERSION("myversion") to override the default?
>=20
> 	If this is desirable, I would prefer to separate "version" and
> "srcversion" (or some other name).  This is done in the following patch
> (we still mangle RCS-style version strings), for all modules using
> MODULE_VERSION, and adds CONFIG_MODULE_SRCVERSION_ALL if you want it in
> all modules.
>=20
> Works here, but these changes tend to break things...

Works for me too.  All modules regardless if if they have a
MODULE_VERSION() entry get the srcversion field in .modinfo.  If they
also have a MODULE_VERSION(), that data shows up in .modinfo also.
This is exactly what I wanted.

Now to find GregKH's patch to export this stuff via sysfs...

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAkcA+Iavu95Lw/AkRAsr/AKCLdtQ92WosO5NelNkRTYE8EyTNXgCfY407
Aq7JpryU5MZ6uW/4QSlExrI=
=Tp8/
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
