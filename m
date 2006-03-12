Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751869AbWCLXJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbWCLXJe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 18:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbWCLXJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 18:09:34 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:8676 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751869AbWCLXJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 18:09:33 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Jim Crilly <jim@why.dont.jablowme.net>
Subject: Re: Faster resuming of suspend technology.
Date: Mon, 13 Mar 2006 09:06:57 +1000
User-Agent: KMail/1.9.1
Cc: Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
References: <200603112246.47596.ncunningham@cyclades.com> <200603120926.AA00811@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060312175421.GE24084@mail>
In-Reply-To: <20060312175421.GE24084@mail>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4348058.VO6Cft1gxy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603130907.03944.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4348058.VO6Cft1gxy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 13 March 2006 03:54, Jim Crilly wrote:
> On 03/12/06 06:26:17PM +0900, Jun OKAJIMA wrote:
> > >> Yes, right. In your way, there is no thrashing. but it slows booting.
> > >> I mean, there is a trade-off between booting and after booted.
> > >> But, what people would want is always both, not either.
> > >
> > >I don't understand what you're saying. In particular, I'm not sure
> > > why/how you think suspend functionality slows booting or what the
> > > tradeoff is "between booting and after booted".
> >
> > Sorry, I used words in not usual way.
> > I refer "booting" as just resuming. And "after booted" means "after
> > resumed". In other words, I treat swsusp2 as not note PC's hibernation
> > equivalent, but just for faster booting technology.
> > So, What I wanted to say was,
> >
> >   --- Reading all image in advance ( your way) slows resuming itself.
> >   --- Reading pages on demand ( e.g. VMware) slows apps after resumed.
> >
> > Hope my English is understandable one...
>
> But you have to read all of the pages at some point so the hard disk is
> going to be the bottleneck no matter what you do. And since Suspend2
> currently saves the cache as a contiguous stream, possibly compressed, it
> should be a good bit faster than seeking around the disk loading the files
> from the filesystem.

Agreed.

> > >> Especially, your way has problem if you boot( resume ) not from HDD
> > >> but for example, from NFS server or CD-R or even from Internet.
> > >
> > >Resuming from the internet? Scary. Anyway, I hope I'll understand bett=
er
> > > what you're getting at after your next reply.
> >
> > In Japan, it is not so scary.
> > We have 100Mbps symmetric FTTH ( optical Fiber To The Home), and
> > more than 1M homes have it, and price is about 30USD/month.
> > With this, theoretically you can download 600MB ISO image in one min,
> > and actually you can download 100MBytes suspend image within 30sec.
> > So, not click to run (e.g. Java applet) but "click to resume" is not
> > dreaming but rather feasible. You still think it is scary on this
> > situation?
>
> I don't think the scary part is speed, but security. I for one wouldn't
> want to resume from an image hosted on a remote machine unless I had some
> way to be sure it wasn't tampered with, like gpg signing or something.

Another issues is that at the moment, hotplugging is work in progress. In=20
order to resume, you currently need the same kernel build you're booting=20
with, and the same hardware configuration in the resumed system. As hotplug=
=20
matures, this restriction might relax, and we could probably come up with a=
=20
way around the former restriction, but at the moment, it really only makes=
=20
sense to try to resume an image you created using the same machine.

> > >> >That said, work has already been done along the lines that you're
> > >> > describing. You might, for example, look at the OLS papers from la=
st
> > >> > year. There was a paper there describing work on almost exactly wh=
at
> > >> > you're describing.
> > >>
> > >> Could I have URL or title of the paper?
> > >
> > >http://www.linuxsymposium.org/2005/. I don't recall the title now,
> > > sorry, and can't tell you whether it's in volume 1 or 2 of the
> > > proceedings, but I'm sure it will stick out like a sore thumb.
> >
> > I checked the URL but could not find the paper,
> > with keywords of "Cunningham" or "swsusp" or "suspend".
> > Could you tell me any keyword to find it?
>
> I took a quick look at the PDFs and I believe the section Nigel is talking
> about is called "On faster application startup times: Cache stuffing, seek
> profiling, adaptive preloading" in volume 1.

Yes, that's the one. Sorry - I didn't mean to give the impression that I wr=
ote=20
it. I know about it because I attended the talk.

Regards,

Nigel

--nextPart4348058.VO6Cft1gxy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEFKmXN0y+n1M3mo0RAuqOAJ48+NvZVHRDLHd0Yyd3al537kogOACglYe0
zLEwbdJF7yz/77KzZxAROsM=
=tYwA
-----END PGP SIGNATURE-----

--nextPart4348058.VO6Cft1gxy--
