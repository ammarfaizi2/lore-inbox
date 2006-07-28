Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751821AbWG1Cng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbWG1Cng (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 22:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWG1Cng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 22:43:36 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:54970 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751821AbWG1Cng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 22:43:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=NFHBdIJQRxKWjTcHiN1Felkew727JxEItxi+mpFD4uU4PlkONcoD13E0++Wb4GyeawHaUWSPB/DkST522VkB0BvrxAE3DMVgHQ7d4wfMDTVLMad7abgqxg0LkwaLuJEmxIP8UggSiCuPM/PPIt85FcRG9VwcUdOLhBVFcBy9msA=
Date: Thu, 27 Jul 2006 22:43:34 -0400
From: Thomas Tuttle <thinkinginbinary@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: The ondemand CPUFreq code -- I hope the functionality stays
Message-ID: <20060728024334.GA12142@phoenix>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <a44ae5cd0607270154p50c2c7fcx734bfea026dc69a9@mail.gmail.com> <200607272104.24088.diablod3@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <200607272104.24088.diablod3@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On July 27 at 21:04 EDT, Patrick McFarland hastily scribbled:
> On Thursday 27 July 2006 04:54, Miles Lane wrote:
> > Hello,
> >
> > It sounds, from comments in the discussion of CPU Hotplug locking
> > problems, as though you are considering deleting the ondemand CPUFreq
> > code.  If this happens, I hope that something that provides the same
> > functionality replaces it.  I really appreciate having my power
> > consumption automatically modulated on an as needed basis.  Power
> > management seems to be one of the areas where there is a lot of room
> > for improvement.
>=20
> I think you've gotten confused. Ondemand is a horrible governor that only=
=20
> flips between two cpu frequencies, the lowest and the highest. Use the=20
> Conservative governor instead.

AFAIK, ondemand implements the following.

Many times per second, do the following:
	Calculate CPU usage since last check.
	If CPU usage > high threshold, set frequency to maximum.
	If CPU usage < low threshold, lower frequency by one level.

So it will immediately jump to the highest frequency, in order to
provide low latency, but will slowly decrease it until it finds the
lowest frequency that provides enough CPU power to support the current
load.

Personally, I prefer conservative, because it isn't as "jumpy", but I
can see ondemand being necessary in a server environment where the
several second lag time to peak performance would hurt response time
when load is low.

--Thomas Tuttle

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEyXnW/UG6u69REsYRAi2XAJwP+HPH1q7wpWVTJO5xdCxJvVYQBgCePvYD
TeQZ1vKCFeM+diu1cbvyClA=
=ZvhE
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
