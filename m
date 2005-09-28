Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVI1V7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVI1V7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVI1V7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:59:02 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:43207 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751102AbVI1V67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:58:59 -0400
Date: Wed, 28 Sep 2005 22:56:48 +0100
From: Alexander Clouter <alex@digriz.org.uk>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.14] Cpufreq_ondemand sysfs names change (was: Re: CPUFreq_ondemand: misnamed ignore_nice attribute)
Message-ID: <20050928215648.GA4720@inskipp.digriz.org.uk>
References: <200508232108.26248.blaisorblade@yahoo.it> <200509101536.10307.blaisorblade@yahoo.it> <20050910140148.GC7072@inskipp.digriz.org.uk> <200509271851.36706.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <200509271851.36706.blaisorblade@yahoo.it>
Organization: diGriz
X-URL: http://www.digriz.org.uk/
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi All,

Blaisorblade <blaisorblade@yahoo.it> [20050927 18:51:36 +0200]:
>
> On Saturday 10 September 2005 16:01, Alexander Clouter wrote:
> > Hi,
> Summary for Andrew Morton:
>=20
> ondemand's ignore_nice attribute has a reversed meaning, and fixing this=
=20
> requires changing the API for the user playing with sysfs. Thus, it shoul=
d be=20
> fixed ASAP, i.e. 2.6.14.
>=20
> echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/ignore_nice
> Then ondemand ignores nice tasks when calculating CPU load.
> echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/ignore_nice
> Then ondemand considers nice tasks when calculating CPU load.
>=20
> It's the reverse of the expected behaviour, even Alexander Clouter got=20
> confused on it when I first reported this bug.
>=20
> So I suggest:
> *) to flip the flag's behaviour, as discussed with Alexander
>=20
> *) to rename the flag to ignore_nice_load or ignore_nice_tasks, to avoid=
=20
> burning the user too much. Very few people use it now, but let's help the=
m.
>=20
> *) Alexander had a piece of doc he wrote about all this and sent me, it'd=
 be=20
> nice to have this merged too.
>=20
> Alexander (quoted near the end) said to have rolled the patches, but they=
're=20
> lost somewhere, don't know if he forgot or they're in some staging tree=
=20
> in-the-middle. I guess I could roll up the patches if needed, but this we=
ek=20
> I'm really busy, so probably not. I've also forwarded the original docco=
=20
> patch to Andrew Morton and LKML (which didn't receive them in first place=
).
>=20
completely my fault, I rolled them at the weekend whilst on a train, lived =
in=20
effectively a Farraday cage for the weekend (a rural part of England for=20
those who are curious :) and forgot....DOH!

The patches are attached.  If everyone likes the look of them, either one o=
f=20
you guys can 'signed off by' or I can to the mailing list.

Cheers

Alex

> > Blaisorblade <blaisorblade@yahoo.it> [20050910 15:36:10 +0200]:
> > > On Saturday 10 September 2005 14:59, Alexander Clouter wrote:
> > > > Hi,
> [About the flag behaviour]
> > > > I'm all for this to be changed, its a feature that is ment to be for
> > > > Joe Public to be used, it would be silly of us to not make it easie=
r;
> > > > it is confusing as it stands.
>=20
> > > Ok - hope there's no so much people workarounding for the new behavio=
ur,
> > > but they're smart enough to fix their scripts up. Just shout a bit on
> > > LKML to say this and we should be ok.
>=20
> > My thinking too, its a relatively new feature and when I have looked ar=
ound
> > very few userland tools even tinker with ondemand so either we do it no=
w or
> > not at all...or rather we do it later and listen to everyone complain :)
>=20
> > > > Flipping the behaviour of the flag gets my vote.  Do you want to ro=
ll
> > > > the patch and I fix up the documentation or do you want to do both,=
 or
> > > > should do both?
>=20
> > > I think it's better that you do that - I'd already so many patches sp=
read
> > > in my trees that I'd lose this patch somewhere.
>=20
> > Not a problem.  I'll roll them off right now.
>=20
> > Cheers
>=20
> --=20
> Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
> Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 2156218=
94)
> http://www.user-mode-linux.org/~blaisorblade
>=20
>=20
> =09
>=20
> =09
> 	=09
> ___________________________________=20
> Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB=20
> http://mail.yahoo.it

--=20
 ______________________________________=20
/ We have seen the light at the end of \
\ the tunnel, and it's out.            /
 --------------------------------------=20
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="01_inverse_ignore_nice_flag.diff"
Content-Transfer-Encoding: quoted-printable

diff -u linux-2.6.13.orig/drivers/cpufreq/cpufreq_conservative.c linux-2.6.=
13/drivers/cpufreq/cpufreq_conservative.c
--- linux-2.6.13.orig/drivers/cpufreq/cpufreq_conservative.c	2005-09-23 15:=
24:46.605223250 +0100
+++ linux-2.6.13/drivers/cpufreq/cpufreq_conservative.c	2005-09-23 15:24:30=
=2E740231750 +0100
@@ -93,7 +93,7 @@
 {
 	return	kstat_cpu(cpu).cpustat.idle +
 		kstat_cpu(cpu).cpustat.iowait +
-		( !dbs_tuners_ins.ignore_nice ?=20
+		( dbs_tuners_ins.ignore_nice ?=20
 		  kstat_cpu(cpu).cpustat.nice :
 		  0);
 }
@@ -515,7 +515,7 @@
 			def_sampling_rate =3D (latency / 1000) *
 					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
 			dbs_tuners_ins.sampling_rate =3D def_sampling_rate;
-			dbs_tuners_ins.ignore_nice =3D 0;
+			dbs_tuners_ins.ignore_nice =3D 1;
 			dbs_tuners_ins.freq_step =3D 5;
=20
 			dbs_timer_init();
diff -u linux-2.6.13.orig/drivers/cpufreq/cpufreq_ondemand.c linux-2.6.13/d=
rivers/cpufreq/cpufreq_ondemand.c
--- linux-2.6.13.orig/drivers/cpufreq/cpufreq_ondemand.c	2005-09-23 15:24:4=
6.609223500 +0100
+++ linux-2.6.13/drivers/cpufreq/cpufreq_ondemand.c	2005-09-23 15:24:08.846=
863500 +0100
@@ -86,7 +86,7 @@
 {
 	return	kstat_cpu(cpu).cpustat.idle +
 		kstat_cpu(cpu).cpustat.iowait +
-		( !dbs_tuners_ins.ignore_nice ?=20
+		( dbs_tuners_ins.ignore_nice ?=20
 		  kstat_cpu(cpu).cpustat.nice :
 		  0);
 }
@@ -424,7 +424,7 @@
 			def_sampling_rate =3D (latency / 1000) *
 					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
 			dbs_tuners_ins.sampling_rate =3D def_sampling_rate;
-			dbs_tuners_ins.ignore_nice =3D 0;
+			dbs_tuners_ins.ignore_nice =3D 1;
=20
 			dbs_timer_init();
 		}

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="02_ondemand-and-conservative-documentation.diff"
Content-Transfer-Encoding: quoted-printable

diff -r -u linux-2.6.13.orig/Documentation/cpu-freq/governors.txt linux-2.6=
=2E13/Documentation/cpu-freq/governors.txt
--- linux-2.6.13.orig/Documentation/cpu-freq/governors.txt	2005-09-23 15:25=
:14.302954250 +0100
+++ linux-2.6.13/Documentation/cpu-freq/governors.txt	2005-09-23 15:36:09.8=
75925000 +0100
@@ -27,6 +27,7 @@
 2.2  Powersave
 2.3  Userspace
 2.4  Ondemand
+2.5  Conservative
=20
 3.   The Governor Interface in the CPUfreq Core
=20
@@ -110,9 +111,64 @@
=20
 The CPUfreq govenor "ondemand" sets the CPU depending on the
 current usage. To do this the CPU must have the capability to
-switch the frequency very fast.
-
+switch the frequency very quickly.  There are a number of sysfs file
+accessible parameters:
=20
+sampling_rate: measured in uS (10^-6 seconds), this is how often you
+want the kernel to look at the CPU usage and to make decisions on
+what to do about the frequency.  Typically this is set to values of
+around '10000' or more.
+
+show_sampling_rate_(min|max): the minimum and maximum sampling rates
+available that you may set 'sampling_rate' to.
+
+up_threshold: defines what the average CPU usaged between the samplings
+of 'sampling_rate' needs to be for the kernel to make a decision on
+whether it should increase the frequency.  For example when it is set
+to its default value of '80' it means that between the checking
+intervals the CPU needs to be on average more than 80% in use to then
+decide that the CPU frequency needs to be increased. =20
+
+sampling_down_factor: this parameter controls the rate that the CPU
+makes a decision on when to decrease the frequency.  When set to its
+default value of '5' it means that at 1/5 the sampling_rate the kernel
+makes a decision to lower the frequency.  Five "lower rate" decisions
+have to be made in a row before the CPU frequency is actually lower.
+If set to '1' then the frequency decreases as quickly as it increases,
+if set to '2' it decreases at half the rate of the increase.
+
+ignore_nice: this parameter takes a value of '0' or '1', when set to
+'0' then all processes are counted towards towards the 'cpu
+utilisation' value.   When set to '1' (its default) then processes that
+are run with a 'nice' value will not count (and thus be ignored) in
+the overal usage calculation.  This is useful if you are running a CPU
+intensive calculation on your laptop that you do not care how long it
+takes to complete as you can 'nice' it and prevent it from taking part
+in the deciding process of whether to increase your CPU frequency.
+
+
+2.5 Conservative
+----------------
+
+The CPUfreq governor "conservative", much like the "ondemand"
+governor, sets the CPU depending on the current usage.  It differs in
+behaviour in that it gracefully increases and decreases the CPU speed
+rather than jumping to max speed the moment there is any load on the
+CPU.  This behaviour more suitable in a battery powered environment.
+The governor is tweaked in the same manner as the "ondemand" governor
+through sysfs with the addition of:
+
+freq_step: this describes what percentage steps the cpu freq should be
+increased and decreased smoothly by.  By default the cpu frequency will
+increase in 5% chunks of your maximum cpu frequency.  You can change this
+value to anywhere between 0 and 100 where '0' will effectively lock your
+CPU at a speed regardless of its load whilst '100' will, in theory, make
+it behave identically to the "ondemand" governor.
+
+down_threshold: same as the 'up_threshold' found for the "ondemand"
+governor but for the opposite direction.  For example when set to its
+default value of '20' it means that if the CPU usage needs to be below
+20% between samples to have the frequency decreased.
=20
 3. The Governor Interface in the CPUfreq Core
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--UugvWAfsgieZRqgk--

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDOxGgNv5Ugh/sRBYRAvazAJ45JMlNrs0lwQXWJoCU/OgaWckV8wCfX1n2
u+mYPiO7t6tY+wZaD9mM6qQ=
=YusN
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
