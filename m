Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWDSI71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWDSI71 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 04:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWDSI71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 04:59:27 -0400
Received: from altrade.nijmegen.internl.net ([217.149.192.18]:55524 "EHLO
	altrade.nijmegen.internl.net") by vger.kernel.org with ESMTP
	id S1750809AbWDSI71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 04:59:27 -0400
From: jos poortvliet <jos@mijnkamer.nl>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: [patch][rfc] quell interactive feeding frenzy
Date: Wed, 19 Apr 2006 10:59:30 +0200
User-Agent: KMail/1.9.1
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Con Kolivas <kernel@kolivas.org>, Al Boldi <a1426z@gawab.com>,
       linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>
References: <200604112100.28725.kernel@kolivas.org> <200604171008.10067.kernel@kolivas.org> <20060419083724.GA7329@rhlx01.fht-esslingen.de>
In-Reply-To: <20060419083724.GA7329@rhlx01.fht-esslingen.de>
X-Face: $0>4o"Xx2u2q(Tx!D+6~yPc{ZhEfnQnu:/nthh%Kr%f$aiATk$xjx^X4admsd*)=?utf-8?q?IZz=3A=5FkT=0A=09=7CurITP!=2E?=)L`*)Vw@4\@6>#r;3xSPW`,~C9vb`W/s]}Gq]b!o_/+(lJ:b)=?utf-8?q?T0=26KCLMGvG=7CS=5E=0A=09z=7B=5C=2E7EtehxhFQE=27eYSsir/=7CtQ?=
 =?utf-8?q?j=23rWQe4o?=>WC>_R<vO,d]czmqWYkq[v~iB.e_GuxB'")
 =?utf-8?q?p3=0A=09jGdrhlY4=5E!vd=3F=3AegW?=)xn&fP4!FV<.
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12482558.ih9FDiffPn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604191059.33490.jos@mijnkamer.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12482558.ih9FDiffPn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op woensdag 19 april 2006 10:37, schreef Andreas Mohr:
> Hi,
>
> On Mon, Apr 17, 2006 at 10:08:08AM +1000, Con Kolivas wrote:
> > On Monday 17 April 2006 04:44, Andreas Mohr wrote:
> > > Hi,
> > >
> > > On Sun, Apr 16, 2006 at 09:22:59AM +1000, Con Kolivas wrote:
> > > > The current value, 6ms at 1000HZ, is chosen because it's the largest
> > > > value that can schedule a task in less than normal human perceptible
> > > > range when two competing heavily cpu bound tasks are the same
> > > > priority. At 250HZ it works out to 7.5ms and 10ms at 100HZ.
> > > > Ironically in my experimenting I found the cpu cache improvements
> > > > become much less significant above 7ms so I'm very happy with this
> > > > compromise.
> > >
> > > Heh, this part is *EXACTLY* a fully sufficient explanation of what I
> > > was wondering about myself just these days ;)
> > > (I'm experimenting with different timeslice values on my P3/450 to
> > > verify what performance impact exactly it has)
> > > However with a measly 256kB cache it probably doesn't matter too much,
> > > I think.
> > >
> > > But I think it's still important to mention that your perception might
> > > be twisted by your P4 limitation (no testing with slower and really
> > > slow machines).
> >
> > You underestimate me. Those cpu cache effects were performance effects
> > measured down to a PII 233, but all were i386 architecture. As for
> > "perception" this isn't my testing I'm talking about; these are
> > neuropsychiatric tests that have nothing to do with pcs or what process=
or
> > you use ;)
>
> OK, but I was not worrying about the interactivity aspects, rather the
> performance aspects (GUI updates of KDE 3.5.2 on P3/450/256MB on Ubuntu a=
re
> about as slow as medium-hot lava). While of course it's mostly KDE (and
> probably also the S3 Savage driver/card) which is to blame here,
> I'm trying to first do as much as possible at kernel level before
> eventually going higher up the chain...

if it's slow redrawing, i'd blame the video driver or X, not KDE/Qt - tough=
=20
you might want to try another style and windowdecoration. plastik is=20
generally speaking quite fast, or try the 'light' style. Xorg xcomposite=20
might help too, but i guess your video card won't like that :D

slow app startup will be better in Kubuntu Dapper+1, as they will finally=20
incorporate the new fontconfig (*g* i hope so) and use GCC's C++ symbol=20
invisibillity in KDE/Qt. those both can give speedups in the area of 10-20%=
,=20
so that should be noticable. KDE 3.5.3 also will also have a few other=20
patches to speed up the KDE startup process, so - faster login, too.

now with al this, its hard to imagine KDE 4 will again sport some 20/30%=20
speedup due to reduced memory usage/binary size ;-)

> Andreas

--nextPart12482558.ih9FDiffPn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBERfv1+wgQ1AD35iwRAh2uAJ9o9Iibe7pIN9VF6at05cdB2zwQfgCfbm6R
LKRpot8j6Droaz8JGvhwn0c=
=tKZW
-----END PGP SIGNATURE-----

--nextPart12482558.ih9FDiffPn--
