Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbULOKd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbULOKd5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 05:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbULOKd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 05:33:57 -0500
Received: from nuit.ca ([66.11.160.83]:42112 "EHLO smtp.nuit.ca")
	by vger.kernel.org with ESMTP id S261793AbULOKdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 05:33:52 -0500
Date: Wed, 15 Dec 2004 10:33:50 +0000
From: simon@nuit.ca
To: linux-kernel@vger.kernel.org
Subject: ppp* really buggy
Message-ID: <20041215103349.GA9617@nuit.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux
X-GPG-Key-Server: x-hkp://subkeys.pgp.net
User-Agent: Mutt/1.5.6+20040907i
X-Scan-Signature: smtp.nuit.ca 1CeWTe-0003Lv-Vz d4411d4cebd7ed517c37969313d4c27b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hi,

tulip driver is not the only driver i'm having problems with (see "oops
in tulip driver..." from a few weeks ago). our net connection is via
pppoe, and either the kernel pppoe driver is randomly crashing to the
point that i *have* to reboot. yes, it's modular, go figure. or it's the
other ppp drivers.  seems to be ppp, since the error messages i get from
the kernel are pointing that way. i don't have the error output
unfortunately, but it is on the list, from my first mention of the tulip
driver being busted, i posted the oops output i got. i'll go try to find
the relevant message.

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D110077095802656&w=3D4
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D110082052528028&w=3D4

the first one refers what i'm speaking of a bit. it happens when i'm
bringing pppd down with poff, or when the other end of my ppp tunnel
drops the connection. here's some more f what i managed to get:

sig11
call trace:
snmp6_unregistered_dev
in6_dev_finish_destroy
ip6_dst_destroy
dst_destroy
dst_ran_gc
run_timer_softirq
__do_softirq
irq_exit
timer_interrupt
ret_from_interrupt

then a message about PANIC: not syncing: Aiee, killing interrupt handler!

sorry i don't have the various numbers that go with those above
functions.

is there a patch out there that can at least mitigate the problems i'm
seeing? it's making for a very unstable environment to work in.=20

(yes, i'm getting desperate. i'm even thinking of going back to 2.4).

eric

--=20
"I believe that part of what propels science is the thirst for wonder.  It'=
s a
very powerful emotion.  All children feel it.  In a first grade classroom
everybody feels it; in a twelfth grade classroom almost nobody feels it, or
at least acknowledges it.  Something happens between first and twelfth grad=
e,
and it's not just puberty.  Not only do the schools and the media not teach
much skepticism, there is also little encouragement of this stirring sense
of wonder.  Science and pseudoscience both arouse that feeling.  Poor
popularizations of science establish an ecological niche for pseudoscience."
- Carl Sagan, The Burden Of Skepticism, The Skeptical Inquirer, Vol. 12, Fa=
ll 87

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQGVAwUBQcATC2qIeuJxHfCXAQLtOAwAnYXJfEkbtFg3t2oqgX48VPcsnko8iidA
airOfkk+6T3sI8wYY8rAOAjtWTKllwKc9N0W7QO5vJnzGQEWh3CAXXfdKRm1A8PX
bvGYfnIuPRHE3i21D2XjX5Z1fb/Flnkuj2nd+Td5DTXJVdlzUG/L/e17qiEHF1Uh
nTgLSlcHQ8RjnVYMpUm9lIa4BRRh2nrmkVIXyq7siMSy81X2AOGWbPC5aZxyTjnw
AXapsfpWQ0GA4L7FxYctq49VjfVho7NKto9DZph1WKrYWKVsAIMwXGgAJDFzZL5N
cNpwkcCwUeOYc+LbtP8mmaB5ssG68aq8Ecjvx5f2vnetAOJLtcqajTxjnI9puIsU
+hR2n3aiSd8oJq7ZyRMlUQ43/1dHAmi9IoKx2lq4+7y84c3Gr92Tib7Q6fSq5dnK
dEZIl8UHQDW5x8h1cfKmfxiJZ/sEic/xrd++My58M57HlrqwqMAg4w/LX4ZJq0A9
1EGMXLTJrlof0wdBgBC0D795XWYWyxZf
=2f3B
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
