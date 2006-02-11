Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWBKKlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWBKKlu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 05:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWBKKlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 05:41:50 -0500
Received: from canadatux.org ([81.169.162.242]:1946 "EHLO
	zoidberg.canadatux.org") by vger.kernel.org with ESMTP
	id S1750788AbWBKKlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 05:41:49 -0500
Date: Sat, 11 Feb 2006 11:41:30 +0100
From: Matthias Hensler <lists-suspend2@wspse.de>
To: Sebastian =?iso-8859-15?Q?K=FCgler?= <sebas@kde.org>
Cc: suspend2-devel@lists.suspend2.net, Nigel Cunningham <nigel@suspend2.net>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060211104130.GA28282@kobayashi-maru.wspse.de>
Reply-To: Matthias Hensler <matthias@wspse.de>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602091926.38666.nigel@suspend2.net> <20060209232453.GC3389@elf.ucw.cz> <200602110116.57639.sebas@kde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <200602110116.57639.sebas@kde.org>
Organization: WSPse (http://www.wspse.de/)
X-Gummibears: Bouncing here and there and everywhere
X-Face: &Tv]9SsNpb/$w8\G-O%>W02aApFW^P>[x+Upv9xQB!2;iD9Y1-Lz'qlc{+lL2Y>J(u76Jk,cJ@$tP2-M%y?^'jn2J]3C'ss_~"u?kA^X&{]h?O?@*VwgSGob73I9r}&S%ktup0k2!neScg3'HO}PU#Ac>jwNL|P@f|f*sz*cP'hi)/<JQC4|Q[$D@aQ"C{$>a=6.rc-P1vXarjVXlzClmNfcSy/$4tQz
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 11, 2006 at 01:16:51AM +0100, Sebastian K=FCgler wrote:
> I, as a contributors to suspend2, have been working on all that stuff
> for about two-and-a-half years, and it makes me really sad to see that
> someone in a position to make a decision towards progress wants to
> start that whole process all over, rather than acknowledging the
> existance of a technical superior solution - including a
> well-functioning supporting community - and working towards getting
> this solution available for a wider audience.

I have to completly agree with Sebastian here. 16 months ago I was in
the need to have a suspend mode running on my new notebook. Back then
Suspend 2 was the only choice, and while it had still problems it was
surprisingly well behaving (in contrast to S3 mode and the mainline
swsusp). The support of the community was, as said above, very good, and
most issues very fixed fast.

Since it worked good for me, I started to contribute by supplying Fedora
patched kernels, helper packages and some documentation. Today on
Fedora, it is as easy as installing 4 RPM-packages and adding the
"resume2=3D" parameter to the kernel commandline, and I know that it works
this well on several other distributions too.

> Judging from experience, uswsusp is probably two years away until it
> can even come close to what suspend2 offers right now, and that would
> be the ideal case of having a lot of people helping in the progress,
> involving being actively involved and dedicated to fixing problems.

I think similar. Much effort was put into getting Suspend 2 to work
reliably and stable.

Some numbers: I have running Suspend 2 myself on three different systems
with total different hardware. For over half a year I have not have had
a single failure in suspending/resuming on any of the machines. With one
machine I had around 70 suspend/resume cycles without a reboot, working
with the machine for several hours a day, until I decided to update to a
newer kernel last week (and it is still running fine).

Some more numbers: judging from my access logs and the feedback I get, I
suspect at least 2000 Fedora users using Suspend 2 on a regular basis
with success. Listening to the IRC channel and reading the forums and
wikis, I see a huge bunch of people using Suspend 2 on nearly every
distribution. The problems are incredible low, mostly minor things that
get fixed nearly instantly.

Some pros of Suspend 2 from my view:
- it is reliable and stable (really!)
- it is fast (10-30 seconds on my notebook with 1280 MB ram, depending
  on how much caches are saved)
- it can save all buffers and caches and the system is instantly
  responsible after resume (even Windows cannot do this and is very slow
  the first minute after resume)
- it works on all major platforms (x86, SMP, x86_64, there were success
  reports for PPC, and I believe even ARM works)
- and the most important thing, as already said, it is available _today_

The only con I see is the complexity of the code, but then again, Nigel
did an incredible job in cleaning up. In the beginning (16 months ago) I
had a lot of trouble in applying the Suspend 2 patches to the Fedora
distribution kernel, but today (and for a long time now) the patches
nearly apply instantly.

=46rom my point of view I see no such great advantage in having suspend in
userspace, but that does not mean it shouldn't be done. It might work
in some time, that is ok, but in the mean time I really would consider
in getting Suspend 2 mainline, because it works today, and I would agree
with Sebastian that it will take its time to get uswsusp running.

Again, you said the code is complex, it might be, but still most part of
the code is completly seperate from the rest of the kernel, and only
touches minor things (and Nigel is still working on that). I believe it
would not hurt.

In my opinion having Suspend 2 in mainline now would be a great thing,
as it would make suspend available for many more people today. In fact
swsusp and Suspend 2 can happily coexist for some time, giving people
the possibility to choose. After having both in mainline, efforts could
be put in developing uswsusp and maybe deprecating the other suspend
implementations one or two years later.

=46rom a user, and contributor, point of view, I really do not understand
why not even trying to push a working implementation into mainline (I
know that you cannot just apply the Suspend 2 patches and shipping it,
but I know that Nigel will help there happily) but concentrate on things
which are just to begin, reinventing most of the wheel, and might take
some more years to get it work reliably.

Regards,
Matthias

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQCVAwUBQ+2/WoagCBsispUdAQKVMAP/UiykJ/fu96UyADO47fYbSDRONmIj9G/E
KFC3rz98xIdrjNw9eG9LHJY+nkA+vOYed5kOHCma3T9W+/VZApEe8ym8a0HrpbkK
Mfr26Q1JYsdo2m4WFJZn5Y1irFSA7yZ+kF4F7e3Yzbr3ay53fv2cHpcGh6Wf3cz3
yj0BkAtekaE=
=lSOE
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
