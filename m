Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWGXXXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWGXXXW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 19:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWGXXXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 19:23:22 -0400
Received: from nigel.suspend2.net ([203.171.70.205]:10949 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S932325AbWGXXXV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 19:23:21 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] [resend] Fix swsusp with PNP BIOS
Date: Tue, 25 Jul 2006 09:23:14 +1000
User-Agent: KMail/1.9.3
Cc: Ondrej Zary <linux@rainbow-software.org>,
       Linux List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Adam Belay <abelay@novell.com>
References: <200607242028.01666.linux@rainbow-software.org> <200607242325.50229.rjw@sisk.pl>
In-Reply-To: <200607242325.50229.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13113545.3YzVSxLWeb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607250923.18678.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart13113545.3YzVSxLWeb
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi.

On Tuesday 25 July 2006 07:25, Rafael J. Wysocki wrote:
> Hi,
>
> On Monday 24 July 2006 20:28, Ondrej Zary wrote:
> > Hello,
> > swsusp is unable to suspend my machine (DTK FortisPro TOP-5A notebook)
> > with kernel 2.6.17.5 because it's unable to suspend PNP device 00:16
> > (mouse).
> >
> > The problem is in PNP BIOS. pnp_bus_suspend() calls pnp_stop_dev() for
> > the device if the device can be disabled according to pnp_can_disable().
> > The problem is that pnpbios_disable_resources() returns -EPERM if the
> > device is not dynamic (!pnpbios_is_dynamic()) but insert_device() happily
> > sets PNP_DISABLE capability/flag even if the device is not dynamic. So we
> > try to disable non-dynamic devices which will fail.
> > This patch prevents insert_device() from setting PNP_DISABLE if the
> > device is not dynamic and fixes suspend on my system.
>
> Thanks for the patch.
>
> Pavel, what do you think?

Adam is probably a better person to ask. (Added to cc).

Regards,

Nigel

--nextPart13113545.3YzVSxLWeb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBExVZmN0y+n1M3mo0RAhQWAKCshAnaRtcbDlKZP8lgaMjI/P6w/QCdHNWq
V94MhsfOlUDQaKPSKfvhlPU=
=xQEZ
-----END PGP SIGNATURE-----

--nextPart13113545.3YzVSxLWeb--
