Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272323AbTHNM2R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 08:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272324AbTHNM2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 08:28:17 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:19869 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S272323AbTHNM2M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 08:28:12 -0400
Date: Thu, 14 Aug 2003 15:28:02 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Simon Haynes <simon@baydel.com>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: File access
Message-ID: <20030814122802.GC7387@actcom.co.il>
References: <67597854DA5@baydel.com> <20030814121917.GX6898@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <20030814121917.GX6898@mea-ext.zmailer.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2003 at 03:19:17PM +0300, Matti Aarnio wrote:
> On Thu, Aug 14, 2003 at 12:32:18PM +0100, Simon Haynes wrote:
> > I am currently developing a module which I would like to configure
> > via a simple text file.=20
> >=20
> > I cannot seem to find any information on accessing files via a kernel=
=20
> > module.
> >=20
> > Is this possible and if so how is it done ?
>=20
>   Yes, but it is rather complicated business, and really should not
>   be done in kernel.   It can be done, but like Richard said, defining
>   your own set of IOCTLs for the device is better.  The complicated
>   configuration file parsing can then reside in the user-space utility
>   program.

Indeed, do it in user space. But don't use ioctl unless it fits the
problem better than the other solutions. Use read / write on a device
file, or a special purpose file system, or sysfs, or even /proc. The
exact mechanism you should use depends on the nature of the user space
- kernel space communications.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/O4BRKRs727/VN8sRAlghAJ9o3T80HDl3Pwe050IUMwYfX+h49QCfW6Tx
4yR+npB1pQmdgLw4iMxBrhM=
=zvMb
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
