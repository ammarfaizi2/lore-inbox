Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132912AbRDQWa3>; Tue, 17 Apr 2001 18:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132913AbRDQWaU>; Tue, 17 Apr 2001 18:30:20 -0400
Received: from linas.org ([207.170.121.1]:37623 "HELO backlot.linas.org")
	by vger.kernel.org with SMTP id <S132912AbRDQWaC>;
	Tue, 17 Apr 2001 18:30:02 -0400
Date: Tue, 17 Apr 2001 17:29:53 -0500
To: Gunther.Mayer@t-online.de
Cc: linux-kernel@vger.kernel.org
Subject: resending Re: mouse problems in 2.4.2 -> lost byte -> Patch(2.4.3)!]
Message-ID: <20010417172953.B6403@backlot.linas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: linas@backlot.linas.org (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Resending ...

----- Forwarded message from Linas Vepstas <linas@linas.org>, linas@linas.o=
rg -----

Subject: Re: mouse problems in 2.4.2 -> lost byte -> Patch(2.4.3)!
In-Reply-To: <3AD0C8AD.1A4D7D12@t-online.de> "from Gunther Mayer at Apr 8, =
2001
	10:23:09 pm"
To: Gunther Mayer <Gunther.Mayer@t-online.de>
Date: Thu, 12 Apr 2001 22:18:10 -0500 (CDT)
From: Linas Vepstas <linas@linas.org>
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,=20
	Vojtech Pavlik <vojtech@suse.cz>, linas@linas.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]

The 'mouse-lost-byte' saga continues:

It's been rumoured that Gunther Mayer said:
>=20
> Original Problem: PS/2 mouse pointer goes upper right corner and stays th=
ere.
> Diagnosis: one byte was lost=20
>=20
> Losing bytes on psaux is a bug!
>=20
> We must first understand, how bytes can be lost (most probable first):
 [...]
>=20
> This patch printk's necessary information on the first 2 cases and
> should be applied to the stable kernel, as this will help to resolve a se=
vere bug !
>=20

[ Attachment, skipping... ]

I now am having a terrible time reproducing the problem.  Based on this,
I nominate another possibility: race conditions involving APM/ACPI/bios.

Here's some more diagnostic info, as best as I can remember it:

Long ago (circa 2.3.99/2.4.0) I enabled APM/ACPI in the kernel, and in the
bios, with the intent of auto-shutting off the monitor after a few hours.
(This is a desktop machine, so no battery concerns, but I was feeling
green,  what with the cost of solar cells and all ...). This, coupled
with XFree86-3.3 seemed to work fine, for a long time (months).

I think (don't quite remember) upgrading to 2.4.2 is when the mouse
problems started.  And also some screen-saver problems.  Every
now-and-then, it seemed I would move my mouse just as the screen-saver
kicked in (at least thats what I think was happening).  Screen would
flash, X would freeze for half a second, some confusion, and back to
normal.  Or not: sometimes the pointer would fly up to top left, and do
the 'lost byte' symptoms.=20

Don't know if this really was apm/acpi triggering this, but some freinds
warned me of possible bad interactions, so I started shutting down
apm/acpi. First in the kernel (one week), later in bios (another week).
This seemed to make matters worse.   Towards the end, the screensaver
would kick in after a minute.  And, very oddly, would kick in whenever I
clicked on a netscape link (!really!).

After reviewing/fiddling my bios settings for apm for the umpteenth time
I reported my 'missing mouse byte' problem to LKML.  And ever since,=20
I've been unable to reproduce the problem.   I am now trying to fiddle
with bios to turn APM back on (and also in the kernel), but so far,
no luck in destabizing the kernel (and also, no luck in getting the
monitor to auto-shutoff...)

--linas




----- End forwarded message -----

--=20
Linas Vepstas   -- linas@linas.org -- http://linas.org/

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE63MPfZKmaggEEWTMRAjHBAJ9pljaPwENpEgLvXV9Qtf2fry0N1ACgiKCa
FT9XDkMWNweK4W6qxmwm6bA=
=Uzwa
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
