Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWGKXAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWGKXAz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWGKXAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:00:55 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:19414 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751095AbWGKXAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:00:54 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Date: Wed, 12 Jul 2006 09:00:45 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
       Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org
References: <20060627133321.GB3019@elf.ucw.cz> <200607120801.24239.ncunningham@linuxmail.org> <200607120034.01339.rjw@sisk.pl>
In-Reply-To: <200607120034.01339.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1533929.uSSeH2680B";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607120900.49828.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1533929.uSSeH2680B
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 12 July 2006 08:34, Rafael J. Wysocki wrote:
> On Wednesday 12 July 2006 00:01, Nigel Cunningham wrote:
> > On Wednesday 12 July 2006 07:54, Rafael J. Wysocki wrote:
> > > On Tuesday 11 July 2006 14:45, Nigel Cunningham wrote:
> > > > Was that 10% speedup on suspend or resume, or both? With LZF, I see
> > > > approximately double the speed with both reading and writing:
> > >
> > > I was not referring to the speedup of writing and/or reading.
> > >
> > > The exercise was to measure the time needed to suspend the system and
> > > get it back in a responsive state.  I measured the time elapsed betwe=
en
> > > triggering the suspend and the moment at which I could switch between
> > > some applications in X without any noticeable lag due to faulting in
> > > some pages (that is a bit subjective, I must admit, but I was willing
> > > to show that bigger images make substantial difference).
> > >
> > > I tested uswsusp with compression (LZF) and two image sizes: 120 MB a=
nd
> > > (IIRC) about 220 MB on a 256 MB box.  The result of the measurement f=
or
> > > the 120 MB image has always been greater than for the 220 MB image, b=
ut
> > > the difference has never been greater than 10%.
> >
> > Ah ok. Are you sure you're getting that sort of throughput with LZF
> > though - if you're not, you might be underestimating the advantage.
>
> Certainly I don't get that kind of speedup for writing.  For reading I do.

Hmm. I would have expected it to be the other way round, since I guess you=
=20
need to do the reading synchronously - or do you read the image, then=20
decompress it? (I'm reading and decompressing at the same time, using=20
readahead to avoid waiting for pages all the time).

I haven't had the chance to revisit uswsusp yet - I did sysfs support on=20
Monday (took ages to figure it out!). Ah... so many things to do, and so=20
little time to do them all!

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1533929.uSSeH2680B
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEtC2hN0y+n1M3mo0RAs3cAJ0f0wIcyaBDsJfAavwqZ75mFTbeWQCcCEN3
L/mT+F4/D5G2ipwwpVKFLFk=
=nmeo
-----END PGP SIGNATURE-----

--nextPart1533929.uSSeH2680B--
