Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbTIAWv1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 18:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTIAWvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 18:51:24 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:7892
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S263336AbTIAWur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 18:50:47 -0400
Subject: Re: [SHED] Questions.
From: Ian Kumlien <pomac@vapor.com>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
       geert@linux-m68k.org
In-Reply-To: <20030901142128.GB2359@wind.cocodriloo.com>
References: <1062324435.9959.56.camel@big.pomac.com>
	 <1062355996.1313.4.camel@boobies.awol.org>
	 <1062358285.5171.101.camel@big.pomac.com>
	 <1062359478.1313.9.camel@boobies.awol.org>
	 <1062369684.9959.166.camel@big.pomac.com>
	 <1062373274.1313.28.camel@boobies.awol.org>
	 <1062374409.5171.194.camel@big.pomac.com>
	 <20030901142128.GB2359@wind.cocodriloo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ke9BbR40daE1F82yk19m"
Message-Id: <1062456571.5171.231.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 02 Sep 2003 00:49:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ke9BbR40daE1F82yk19m
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-09-01 at 16:21, Antonio Vargas wrote:
> On Mon, Sep 01, 2003 at 02:00:09AM +0200, Ian Kumlien wrote:
> > Yes, But... When you come from AmigaOS, and have used Executive...
> > things like this is dis concerning. Executive is a scheduler addition
> > for amigaos that has many schedulers to choose from. One of which is th=
e
> > original feedback scheduler. While a feedback scheduler consumes some
> > cpu it still allows you to play mp3's while surfing the net on a 50 mhz
> > 68060. Hearing about 500mhz machines that skip is somewhat.. odd.
>=20
> Ian, I came from Amiga to Linux many moons ago, and their target are
> very different... on Amiga, the mouse pointer is drawn as a hardware
> sprite (same as an C64 or an arcade machine), and the mouse
> movement counters are handled in hardware too, so your mouse pointer
> can't _EVER_ get laggy.

I also joined linux a long time ago... but the hardware pointer is not
the issue. I'm more referring to using cpublit and dragging the
scrollbar in a window... Like f.ex. Voyager.

(And, in this case, 50Mhz is the limitation not the scheduler. With 10
times that power i bet you could do it all with the cpu, just like a
common pc today.)

> The sound system is very different, on Amiga you ask the system to
> callback to you when audio needs replenishing, and anyways you could
> boost the player priority so that multichanel or mp3 playing gets more
> priority than other tasks. I can recall playing mp3 on a 68030/50
> and having to boost the player's priority so that it would get no
> skipping. As you probably know 68060 machines, even if at the same mhz,
> have about 8x raw calculation power.

Eh, a 060 struggles with a mp3, it consumes most of the cpu and it can
still render a browser window (not as fast as it could originally, but
thats not my point).

> So, I also feel very bad about linux when my audio skips on my 900mhz
> machine and I see reports that it does the same on 2400mhz ones, but I
> can understand that the general design and target is not the same...
> Amiga was _designed_, both software and hardware wise, for realtime
> while Unix and thus Linux is designed for multiuser timesharing.

AmigaOS is lowlatency but not realtime. And, with executive you run a
unix scheduler (feedback).

> All that said, having a mp3 decoder as a kernel module reading from=20
> mlocked ram would a great way to have Amiga-like music replaying ;)

Hummm, Last time i played a mp3 on my amiga i kinda decoded it in the
delfina dsp =3D)
(to bad noone has done that for emu10k1... )

> Geert, perhaps you could tell us how linux music playing feels
> for a desktop m68k machine?=20
>=20
> [ I'm CCing you since you are the only one from the m68k port   =20
>   which I can see posting on a regular basis.]
>=20
> > And afair it has no real interactivity estimator.=20
> >=20
> > (If you are interested you can always search for Executive on aminet..
> > It has several scheduler policies including those that work great on
> > small machines (25mhz or so))

> If the user or a program decided so, it could _always_ change a task
> priority to upper or lower levels, which is what I did to my mp3 player
> to avoid skips on my under powered machine (mp3 playing used 85%cpu) ;).

Heh, what cpu?

But a task raising it's cpu on it's own can be a pain since it could
dominate the machine on non executive running machines.

> "Executive" was an application which patched the Amiga scheduler and
> hooked up a priority manager. By altering task' priorities, it managed
> to get the standard round-robin scheduler to behave like a feedback one.
> (Executive was _G_R_E_A_T_ :)))

Executive implements dynamic priorities in a fixed priority OS, ie nice.
You select the range it should use to catch processes and where it
should place em. And, Executive is still great even though i haven't
used it for quite some time.

> Executive was configured to never touch tasks with elevated priorities,
> so in fact all user tasks would get the feedback scheduler but system
> drivers such as keyboard input system would continue running as realtime
> round-robin.

Hummm, input.device would never consume so much cpu that it would need
to be penalized.=20
=20
> > imho, that shouldn't really be needed... =3DP
> > (although executive apparently had a pri boost for active window... I
> > doubt that i ran with it though... Been a while =3D))
>=20
> Yes, it added +1 to the task which owner the active window
> (this is also used in Windows if I recall correctly). But even without
> this "hack", both executive-enabled and standard systems ran great.

Give priority to "front most" program is in Windows and OS/2. I disabled
it in OS/2 Warp something on a p120 and watched it crawl =3DP.

--=20
Ian Kumlien <pomac@vapor.com>

--=-ke9BbR40daE1F82yk19m
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/U8z77F3Euyc51N8RAovCAJwICsYPj1zhd2h9JYaYXixkRByXKwCfbBPE
XrNX9mDKpfYClyrCAhFMysU=
=oGxb
-----END PGP SIGNATURE-----

--=-ke9BbR40daE1F82yk19m--

