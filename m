Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWFGAas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWFGAas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWFGAar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:30:47 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:64434 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751404AbWFGAar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:30:47 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Date: Wed, 7 Jun 2006 10:31:50 +1000
User-Agent: KMail/1.9.1
Cc: jeremy@goop.org, dzickus@redhat.com, ak@suse.de, shaohua.li@intel.com,
       miles.lane@gmail.com, linux-kernel@vger.kernel.org
References: <4480C102.3060400@goop.org> <200606071013.53490.ncunningham@linuxmail.org> <20060606172410.b901950e.akpm@osdl.org>
In-Reply-To: <20060606172410.b901950e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1182940.MILoeL8yEn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606071031.55292.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1182940.MILoeL8yEn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 07 June 2006 10:24, you wrote:
> On Wed, 7 Jun 2006 10:13:49 +1000
>
> Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> > > the new CPU to get the same state as the old one just because it ends
> > > up with the same logical CPU number?  Perhaps, but what if it doesn't
> > > even have the same capabilities?  (Do we support heterogeneous CPUs
> > > anyway?)
> >
> > Indeed. I'm also not sure that there's necessarily a guarantee that cpus
> > will be hotplugged in the same order. Perhaps those with more knowledge
> > can clarify there.
>
> It all depends on what we mean by "per-cpu state".  If we were to remember
> that "CPU 7 needs 0x1234 in register 44" then that would be wrong.  But
> remembering some high-level functional thing like "CPU 7 needs to run the
> NMI watchdog" is fine.  The CPU bringup code can work out whether that is
> possible, and how to do it.

Does that imply that there's no danger of cpus being hotplugged in a differ=
ent=20
order (so that cpu7 becomes cpu5, for example)?

I guess I'm missing an understanding of why one cpu would need a different=
=20
configuration to the rest. If it's related to the cpu number, then it=20
shouldn't matter if a different cpu gets the number, should it? If it's=20
related to the node that the cpu is on, perhaps the hotplugging code for th=
e=20
driver should be checking for the reason ("Am I on the node with the... ?")=
=20
rather than the cpu number?

Regards,

Nigel

=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1182940.MILoeL8yEn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEhh57N0y+n1M3mo0RAl9gAKDfvDTtvlUNjggRPBsuxdKzrX2v9QCbB2AB
5HYeWrXJL1ZVFizhPGxfIK8=
=f6Fd
-----END PGP SIGNATURE-----

--nextPart1182940.MILoeL8yEn--
