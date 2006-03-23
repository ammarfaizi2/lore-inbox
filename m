Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWCWMRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWCWMRr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 07:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWCWMRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 07:17:47 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:53741 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751469AbWCWMRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 07:17:46 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Make libata not powerdown drivers on PM_EVENT_FREEZE.
Date: Thu, 23 Mar 2006 22:16:03 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
References: <200603232151.47346.ncunningham@cyclades.com> <20060323040649.3a6c96f1.akpm@osdl.org>
In-Reply-To: <20060323040649.3a6c96f1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1972526.6o8jZz0912";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603232216.08538.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1972526.6o8jZz0912
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 23 March 2006 22:06, Andrew Morton wrote:
> Nigel Cunningham <ncunningham@cyclades.com> wrote:
> > At the moment libata doesn't pass pm_message_t down ata_device_suspend.
> >  This causes drives to be powered down when we just want a freeze,
> >  causing unnecessary wear and tear. This patch gets pm_message_t passed
> >  down so that it can be used to determine whether to power down the
> >  drive.
>
> Does this explain http://bugzilla.kernel.org/show_bug.cgi?id=3D6264 ?

Yes, it does.

> This might be 2.6.16.1 material - how irritating is it?

Very. It extends the time to write the image, but as mentioned above, I'm m=
ore=20
concerned by the fact that (assuming I understand correctly), it's using up=
=20
the limited number of power cycles a drive can handle.

Regards,

Nigel

--nextPart1972526.6o8jZz0912
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEIpGIN0y+n1M3mo0RAhjCAKDRyFLiqEii+giNkr3upw7dirQo6wCeOcWD
nd7lJcecTtpyEd2t4PkXwuI=
=3kjp
-----END PGP SIGNATURE-----

--nextPart1972526.6o8jZz0912--
