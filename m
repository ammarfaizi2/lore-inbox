Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVCYSBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVCYSBm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 13:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVCYSBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 13:01:42 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:14557 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261715AbVCYSBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 13:01:37 -0500
Date: Fri, 25 Mar 2005 20:01:36 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH] driver core: Separate platform device name from platform device number
Message-ID: <20050325180136.GA4192@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	rmk+lkml@arm.linux.org.uk
References: <1110414879646@kroah.com> <11104148792069@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <11104148792069@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2005 at 04:34:39PM -0800, Greg KH wrote:
> [PATCH] driver core: Separate platform device name from platform device n=
umber
>=20
> Separate platform device name from platform device number such that
> names ending with numbers aren't confusing.
>=20
This might make sense for devices that end in numbers, but does it really
make sense for devices that don't? I don't really see how having
something like randomfb.0 is intuitive, this may make sense for things
like serial8250 where another 0 would be misleading without some form of
delimiter, but those are the corner cases and should be treated as such.

It's a bit irritating to have to constantly update userspace code that is
acting under the false pretense that there is some sort of consistent
naming scheme in place that won't change every time some new corner case
crops up.

(And yes, I should have brought this up when the patch was posted, but I
didn't see it until _after_ being bit by this change).

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCRFH/1K+teJFxZ9wRAjUVAJ4+AcBco6W4Uo018L/CnZKUEegeWQCfU1tc
Zrdnk4u4zqoXi+zgoc5lT/Y=
=TrKY
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
