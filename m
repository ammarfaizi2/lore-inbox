Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWGKWB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWGKWB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWGKWB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:01:28 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:45001 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932161AbWGKWB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:01:27 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Date: Wed, 12 Jul 2006 08:01:19 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
       Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org
References: <20060627133321.GB3019@elf.ucw.cz> <200607112245.11462.ncunningham@linuxmail.org> <200607112354.56078.rjw@sisk.pl>
In-Reply-To: <200607112354.56078.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1921069.iL5TM7Y7Ua";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607120801.24239.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1921069.iL5TM7Y7Ua
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 12 July 2006 07:54, Rafael J. Wysocki wrote:
> Hi,
>
> On Tuesday 11 July 2006 14:45, Nigel Cunningham wrote:
> > On Sunday 09 July 2006 04:52, Rafael J. Wysocki wrote:
> > > Well, I tried really hard to justify the patch that allowed swsusp to
> > > create bigger images and 10% was the greatest speedup I could get out
> > > of it and, let me repeat, _with_ compression and async I/O.  I tried =
to
> > > simulate different workloads etc., but I couldn't get more than 10%
> > > speedup (the biggest image I got was as big as 80% of RAM) - counting
> > > the time from issuing the suspend command to getting back _responsive_
> > > system after resume.
> >
> > Was that 10% speedup on suspend or resume, or both? With LZF, I see
> > approximately double the speed with both reading and writing:
>
> I was not referring to the speedup of writing and/or reading.
>
> The exercise was to measure the time needed to suspend the system and get
> it back in a responsive state.  I measured the time elapsed between
> triggering the suspend and the moment at which I could switch between some
> applications in X without any noticeable lag due to faulting in some pages
> (that is a bit subjective, I must admit, but I was willing to show that
> bigger images make substantial difference).
>
> I tested uswsusp with compression (LZF) and two image sizes: 120 MB and
> (IIRC) about 220 MB on a 256 MB box.  The result of the measurement for t=
he
> 120 MB image has always been greater than for the 220 MB image, but the
> difference has never been greater than 10%.

Ah ok. Are you sure you're getting that sort of throughput with LZF though =
=2D=20
if you're not, you might be underestimating the advantage.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1921069.iL5TM7Y7Ua
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEtB+0N0y+n1M3mo0RAkcwAKC+FFH5/TcNF4VERv0d65iB3EdzNwCdFHaS
aEMUdZUfWrxIyl6ulHIOwvQ=
=JZkT
-----END PGP SIGNATURE-----

--nextPart1921069.iL5TM7Y7Ua--
