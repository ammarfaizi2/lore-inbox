Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278341AbRJMSRG>; Sat, 13 Oct 2001 14:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278343AbRJMSRA>; Sat, 13 Oct 2001 14:17:00 -0400
Received: from grip.panax.com ([63.163.40.2]:26640 "EHLO panax.com")
	by vger.kernel.org with ESMTP id <S278341AbRJMSQo>;
	Sat, 13 Oct 2001 14:16:44 -0400
Date: Sat, 13 Oct 2001 14:17:09 -0400
From: Patrick McFarland <unknown@panax.com>
To: "M. Edward Borasky" <znmeb@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which is better at vm, and why? 2.2 or 2.4
Message-ID: <20011013141709.L249@localhost>
In-Reply-To: <E15sSOG-0003Fb-00@the-village.bc.nu> <HBEHIIBBKKNOBLMPKCBBKEOIDOAA.znmeb@aracnet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pe+tqlI1iYzVj1X/"
Content-Disposition: inline
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBKEOIDOAA.znmeb@aracnet.com>
User-Agent: Mutt/1.3.22i
X-Operating-System: Linux 2.4.12 i586
X-Distributed: Join the Effort!  http://www.distributed.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pe+tqlI1iYzVj1X/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hmm, I see that as very bad. There should be a bunch of sysctls to do that =
easily. Also, I heard that 2.4 (and I'm assuming 2.2 as well) swaps pages o=
n a last-used-age basis, instead of either a number-of-times-used or a hybr=
id of the two. That kinda seems stupid, especially if you get a bunch of ap=
ps running that just cycle thru pages, instead of the most used pages stayi=
ng in memory, and the least used being swapped back and forth with about 2 =
or 3 megs of memory used to store the least used pages in memory

On 13-Oct-2001, M. Edward Borasky wrote:
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Alan Cox
> > Sent: Saturday, October 13, 2001 10:16 AM
> > To: Patrick McFarland
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: Which is better at vm, and why? 2.2 or 2.4
> > > Now, the great kernel hacker, ac, said that 2.2 is better at vm
> > in low memo=3D
> > > ry situations than 2.4 is. Why is this? Why hasnt someone fixed
> > the 2.4 cod=3D
> > > e?
> > Actually they have on thw whole. However VM tuning is a hard problem
>=20
> Ah! Finally the t-word!! Yes, VM "tuning" is a hard problem. Because any
> full-strength operating system, whether Windows NT, Linux, some other fla=
vor
> of UNIX or even MVS, can be used to support a variety of computational
> endeavors, it is almost impossible to come up with a fixed "algorithm" th=
at
> will effectively support all legitimate usage patterns while protecting
> users as much as possible from pathological usage patterns. Therefore ...
>=20
> Most operating systems allow one to *measure* performance variables and g=
ive
> system managers *control knobs* they can use to tune policy to a given
> usage. For example, I once worked on a system where there were three mode=
s.
> During the day, the system was tuned for interactive users, on the swing
> shift it was tuned to a mix of batch jobs and system administration
> functions like backups, and on the graveyard shift it ran nothing but huge
> batch jobs.
>=20
> Linux certainly has the measurement capabilities; I've been able to find
> everything I need in /proc for the monitoring and analysis I need to do. =
On
> the control knobs, I think Linux falls short relative to, say, Solaris,
> Tru64, VMS and Windows 2000. Nearly all decisions seem to be "hard-wired"=
 in
> Linux, for example, the goodness boosts given to processes to promote soft
> affinity, the time slice, and the fractions of memory allocated to the
> various functions: buffers, cached, etc. They are set as #defines in head=
er
> files. Even having them as variables would be an improvement; then they
> could be examined and modified with a debugger.
>=20
> I would like to be able to set up a test system in my laboratory, fire up=
 a
> benchmark that emulates a real-world workload and tweak these parameters
> somewhere in /proc in real time, while watching the response times of my
> benchmark transactions. I can do this in Tru64, I can do this in a number=
 of
> other operating systems. Right now, for all practical purposes, when I wa=
nt
> to perform an experiment like this, I need to recompile, quite often, the
> *entire* kernel, reboot and re-run my benchmark. In other words, if the
> parameters were tunable, what now takes *days* to do could be accomplished
> in hours, even minutes, with just a little up-front work.
> --
> M. Edward (Ed) Borasky, Chief Scientist, Borasky Research
> http://www.borasky-research.net
> mailto:znmeb@borasky-research.net
> http://groups.yahoo.com/group/BoraskyResearchJournal
>=20
> Q: How do you tell when a pineapple is ready to eat?
> A: It picks up its knife and fork.
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--=20
Patrick "Diablo-D3" McFarland || unknown@panax.com

--pe+tqlI1iYzVj1X/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE7yIUk8Gvouk7G1cURAqbZAJ9BRhZqZl4mOns7Zk14WuFb3BcKVwCgl8AC
WjOtdGenon3EzL3PPxx4xRU=
=mbbN
-----END PGP SIGNATURE-----

--pe+tqlI1iYzVj1X/--
