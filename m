Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946324AbWBDHPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946324AbWBDHPw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 02:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946323AbWBDHPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 02:15:52 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:10959 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1946315AbWBDHPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 02:15:51 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: S3 sleep regression / 2.6.16-rc1+acpi-release-20060113
Date: Sat, 4 Feb 2006 17:12:25 +1000
User-Agent: KMail/1.9.1
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <E1F5FZL-0001sP-00@skye.ra.phy.cam.ac.uk>
In-Reply-To: <E1F5FZL-0001sP-00@skye.ra.phy.cam.ac.uk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1306595.HDcAv8J9Me";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602041712.30428.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1306595.HDcAv8J9Me
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Saturday 04 February 2006 15:02, Sanjoy Mahajan wrote:
> The gory details are at
> <http://bugzilla.kernel.org/show_bug.cgi?id=3D5989>, but the short
> summary:
>
> With 2.6.15, S3 sleep and wake were 98% fine (once in a while waking
> would hang, but I haven't managed to reproduce it).  However, with
> 2.6.16-rc1 with the acpi-20060113 patch, the first sleep and wake goes
> fine and the second sleep hangs at the 'Stopping tasks'.

After the first suspend, do you have any processes sucking all available=20
cpu? This sounds like a thread that has been added since 2.6.15, which is=20
being told to enter the freezer, but isn't doing it. They usually end up=20
sucking cpu afterwards.

Regards,

Nigel

> With tons of debugging turned on, the second sleep does not hang, but
> the wakeup hangs.  With 0x1F as the acpi debug_level, the second sleep
> still hangs and produces some output across a serial console.  In the
> second sleep (after the second 'Stopping tasks'), it endlessly repeats
> a short sequence of
>
> exregion-0182 ...
> exregion-0287 ...
> exregion-0182 ...
>
> The machine is a TP 600X with the latest (1.11) BIOS and a fixed DSDT
> so that it can S3 sleep at all.
>
> -Sanjoy
>
> `Never underestimate the evil of which men of power are capable.'
>          --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--nextPart1306595.HDcAv8J9Me
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD5FPeN0y+n1M3mo0RApNBAKDwYmkIveu4JbYAEa3eFByhxty79QCfdt0z
/9K1E6E+sGCB06kWXwGTYFw=
=rmQR
-----END PGP SIGNATURE-----

--nextPart1306595.HDcAv8J9Me--
