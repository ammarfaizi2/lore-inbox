Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbVIHR66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbVIHR66 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 13:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVIHR66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 13:58:58 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:26852 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S964905AbVIHR65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 13:58:57 -0400
Date: Thu, 8 Sep 2005 10:58:52 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Jim Ramsay <jim.ramsay@gmail.com>
Cc: linux-usb-users@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-usb-users] Possible bug in usb storage (2.6.11 kernel)
Message-ID: <20050908175852.GA3196@one-eyed-alien.net>
Mail-Followup-To: Jim Ramsay <jim.ramsay@gmail.com>,
	linux-usb-users@lists.sourceforge.net,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <4789af9e05090810142bd3531d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <4789af9e05090810142bd3531d@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2005 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 08, 2005 at 11:14:36AM -0600, Jim Ramsay wrote:
> I think I have found a possible bug:
> [...]
> I suppose the scsi code could be changed to guarantee that
> srb->request_buffer is page-aligned or cache-aligned, but that seems
> like the wrong solution for this bug.

Fixing the SCSI layer is -exactly- the correct solution.  The SCSI layer is
supposed to guarantee us that those buffers are suitable for DMA'ing, and
apparently it's violating that promise.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

What, are you one of those Microsoft-bashing Linux freaks?
					-- Customer to Greg
User Friendly, 2/10/1999

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDIHvcHL9iwnUZqnkRAtfIAJ4n/UXA19mFtRtH+SKPX++JmM3nZACgsWWd
mfWFqi9Sb5ToTGtvddmJinA=
=S+00
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
