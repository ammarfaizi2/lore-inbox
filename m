Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWFGAjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWFGAjZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWFGAjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:39:25 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:5812 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751408AbWFGAjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:39:25 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Andi Kleen <ak@suse.de>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Date: Wed, 7 Jun 2006 10:40:28 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, jeremy@goop.org, dzickus@redhat.com,
       shaohua.li@intel.com, miles.lane@gmail.com,
       linux-kernel@vger.kernel.org
References: <4480C102.3060400@goop.org> <20060606172410.b901950e.akpm@osdl.org> <200606070233.07259.ak@suse.de>
In-Reply-To: <200606070233.07259.ak@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8394150.ZBYSVcAdxD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606071040.32914.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8394150.ZBYSVcAdxD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 07 June 2006 10:33, Andi Kleen wrote:
> On Wednesday 07 June 2006 02:24, Andrew Morton wrote:
> > On Wed, 7 Jun 2006 10:13:49 +1000
> >
> > Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> > > > the new CPU to get the same state as the old one just because it en=
ds
> > > > up with the same logical CPU number?  Perhaps, but what if it doesn=
't
> > > > even have the same capabilities?  (Do we support heterogeneous CPUs
> > > > anyway?)
> > >
> > > Indeed. I'm also not sure that there's necessarily a guarantee that
> > > cpus will be hotplugged in the same order. Perhaps those with more
> > > knowledge can clarify there.
> >
> > It all depends on what we mean by "per-cpu state".  If we were to
> > remember that "CPU 7 needs 0x1234 in register 44" then that would be
> > wrong.  But remembering some high-level functional thing like "CPU 7
> > needs to run the NMI watchdog" is fine.  The CPU bringup code can work
> > out whether that is possible, and how to do it.
>
> Actually the nmi watchdog state should be global, not per CPU.  We
> want it to either work for the whole system or be completely disabled.

Ok. Now I get and fully agree with what you said earlier ("Make it work=20
properly for CPU hotplug for individual CPU and then in suspend
you take care of "global" state and the last CPU.").

> What is per CPU are the performance counter allocations, but these
> can be forgotten over CPU unplug/replug.
>
> (ok this means oprofile  might need to be restarted after suspend/resume,
> but I guess that's reasonable)

Don't know enough in that area to say anything :>

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart8394150.ZBYSVcAdxD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEhiCAN0y+n1M3mo0RAohTAJ0SKajC430V4XaOGxf0tYPIYU9yLwCeMbws
b+PFWx/m86h7sFFJvVounjI=
=bWni
-----END PGP SIGNATURE-----

--nextPart8394150.ZBYSVcAdxD--
