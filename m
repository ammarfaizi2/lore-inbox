Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUJRIZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUJRIZu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 04:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUJRIZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 04:25:50 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:31157 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S264503AbUJRIZp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 04:25:45 -0400
Date: Mon, 18 Oct 2004 09:25:08 +0100
From: Alexander Clouter <alex-kernel@digriz.org.uk>
To: venkatesh.pallipadi@intel.com, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq_ondemand
Message-ID: <20041018082508.GB3311@inskipp.digriz.org.uk>
References: <20041017222916.GA30841@inskipp.digriz.org.uk> <20041018072045.GA17164@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20041018072045.GA17164@dominikbrodowski.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Morning all,

On Oct 18, Dominik Brodowski wrote:
>=20
> Or possibly a "fork" -- different dynamic cpufreq governors aren't a bad
> thing to have. Else the whole modular approach would be wrong... So, even
> if it doesn't get merged into cpufreq_ondemand, you can maintain it as a
> differently named cpufreq governor.
>=20
but but...that ruins my plans for world domination....

>=20
> > 2. controllable through=20
> > 	/sys/.../ondemand/ignore_nice, you can tell it to consider 'nice'=20
> > 	time as also idle cpu cycles.  Set it to '1' to treat 'nice' as cpu=20
> > 	in an active state.
>=20
> Interesting bit, IIRC some userspace tool also does that.
>=20
if I recall they have to munch through the whole of /proc to get this=20
information; then again there is probably a clean and fast way of pulling=
=20
those time values from /proc that I do not know of.

> > 4. (minor) I changed DEF_SAMPLING_RATE_LATENCY_MULTIPLIER to 50000 and
> > 	DEF_SAMPLING_DOWN_FACTOR to 5 as I found the defaults a bit annoying=
=20
> > 	on my system and resulted in the cpufreq constantly jumping.
> >=20
> > 	For my patch it works far better if the sampling rate is much lower=20
> > 	anyway, which can only be good for cpu efficiency in the long run
>=20
> However, this means it takes much longer for the system to react to chang=
es
> in load... it's a tricky issue.
>=20
its all a case of trade-offs and of course everyones millage will vary.  For
me I want the CPU to slowly get faster and faster as a task might complete
fast enough without vamping it up to 100%.  Then again Con will probably
point out "pah, then the difference in battery saving is negligable" :)

On a laptop (regardless of whether it gives an overall order of magnitude
power saving or not) I would prefer the cpu speed to be as low as possible.=
 =20
Again everyone (well here in the UK) I chat to seems to prefer the slow=20
increasing method which many of the userspace tools try to do anyway; then =
of=20
course the argument "userland userland userland....".

> > 6. debugging (with 'watch -n1 cat /sys/.../ondemand/requested_freq') an=
d=20
> > 	backwards 'compatibility' to act like the 'userspace' governor is=20
> > 	avaliable with /sys/.../ondemand/requested_freq if=20
> > 	'freq_step_percent' is set to zero
>=20
> Please don't do that. Userspace is the governor for userspace frequency
> setting; if you want it, switch to userspace, if you want dynamic frequen=
cy
> selection, use the original ondemand or your governor.
>=20
I thought a few people would grumble about that.  I needed a way to store t=
he=20
variable speed knob and that struct was the best place for it; looks like m=
e=20
tarting it up as a 'debugging' feature was not good enough :)

Cheers

Alex

--=20
 ________________________________________=20
/ All articles that coruscate with       \
\ resplendence are not truly auriferous. /
 ----------------------------------------=20
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBc33kNv5Ugh/sRBYRAs7rAJoC37Qlc6qrBkuhlfO6NLhKmzug9QCfQTc0
zrZmdlryoLmwcRwitrD+LC8=
=ONdJ
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
