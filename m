Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbUBVQcK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 11:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbUBVQcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 11:32:10 -0500
Received: from smtp.golden.net ([199.166.210.31]:64010 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S261694AbUBVQcC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 11:32:02 -0500
Date: Sun, 22 Feb 2004 10:52:09 -0500
From: Paul Mundt <lethal@linux-sh.org>
To: linux-kernel@vger.kernel.org, Jim Wilson <wilson@specifixinc.com>,
       Judith Lebzelter <judith@osdl.org>, Dan Kegel <dank@kegel.com>,
       cliff white <cliffw@osdl.org>, "Timothy D. Witham" <wookie@osdl.org>
Subject: Re: Kernel Cross Compiling [update]
Message-ID: <20040222155209.GA11162@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	linux-kernel@vger.kernel.org, Jim Wilson <wilson@specifixinc.com>,
	Judith Lebzelter <judith@osdl.org>, Dan Kegel <dank@kegel.com>,
	cliff white <cliffw@osdl.org>, "Timothy D. Witham" <wookie@osdl.org>
References: <20040222035350.GB31813@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20040222035350.GB31813@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2004 at 04:53:50AM +0100, Herbert Poetzl wrote:
>    			   linux-2.6.3-rc3     linux-2.6.3
>    			   config  build       config  build
>=20
>    sh/sh:		   OK	   FAILED      OK      FAILED
>    sh64/sh:		   OK	   FAILED      OK      FAILED

sh64 doesn't exist in 2.6 yet, attempting to build a kernel for it is futil=
e.


>    others seem to require different? binutils (sh and sh64)
>   =20
sh and sh64 require completely different toolchains. They're very different
platforms, and have very little in common.

>    				   linux-2.4.25
>    			   config  dep     kernel  modules
>=20
>    sh/sh:		   OK	   OK	   FAILED  FAILED

These are due to erroring on .rept usage for filling in the sys_call_table =
in
arch/sh/kernel/entry.S, in 2.6 we've already cleaned this up in the LinuxSH
tree by just dropping it and padding out for NR_syscalls, I suppose somethi=
ng
similar will have to be done in the 2.4 case..

>    sh64/sh64:		   OK	   OK	   FAILED  FAILED
>=20
The sh64 build errors according to logs[7] are issues with your toolchain,
binutils in particular.


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAONAp1K+teJFxZ9wRAuYDAJ0cRSD0xKOCOaIRnd8omeeTebuj0QCdH2fr
6EqYXWVxIslVFtF1+6EHL04=
=6j+0
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
