Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVBQQ3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVBQQ3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 11:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVBQQ3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 11:29:18 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:32503 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262306AbVBQQ2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 11:28:48 -0500
Date: Thu, 17 Feb 2005 11:28:47 -0500
From: John M Flinchbaugh <john@hjsoft.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Swsusp, resume and kernel versions
Message-ID: <20050217162847.GA32488@butterfly.hjsoft.com>
References: <200502162346.26143.dtor_core@ameritech.net> <20050217110731.GE1353@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20050217110731.GE1353@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 17, 2005 at 12:07:31PM +0100, Pavel Machek wrote:
> When all the vendor's kernels have swsusp, it will magically kill the
> signature. Or stick mkswap /dev/XXX in your init scripts.

This is what I've done in some instances.  There should be no harm in
sticking that mkswap into your init scripts right before the swapon -a,
and then you have a nice userspace solution.

It's safe to reinitialize swap on any clean boot.  A resume will not get
into the init scripts.

Just remember you're doing the mkswap if you decide to rearrange your
partitions at all, or code a script smart enough to grep your swap
partitions out of your fstab.

--=20
John M Flinchbaugh
john@hjsoft.com

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCFMY/CGPRljI8080RAsBkAJ9V/qqGmRVf9QQLV3aqx7o4P3UpSQCfUfXT
/4VIDE5lJVEuVcWIY8DE8tI=
=mmTR
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
