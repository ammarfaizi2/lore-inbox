Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288756AbSATPlu>; Sun, 20 Jan 2002 10:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288759AbSATPlk>; Sun, 20 Jan 2002 10:41:40 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:44954 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S288756AbSATPl0>; Sun, 20 Jan 2002 10:41:26 -0500
Date: Sun, 20 Jan 2002 10:41:19 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= <christophe.barbe@ufies.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: usb-ohci, ov511, video4linux
Message-ID: <20020120154119.GB2873@online.fr>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: debian SID Gnu/Linux 2.4.17 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


I've two problems with the 2.4 series that seems to be related.
The common point is the usb-ohci module.

Since 2.4.0, sometimes X loose the usb mouse. X show nothing special in
its log and the kernel nothing (I have compiled the usb debug code).
This seems to appear when the CPU is mostly used for another application
(most of the time the CPU is 100% used when I loose the mouse).
If I switch to the console (Ctrl-Alt-F1) and switch back to X, the usb
mouse is back. My first thought was that it was a X bug. But the other
problem I have seems to indicate this is a kernel problem.

I bought a usb webcam (D-Link DCS100) which uses the ov511 chipset
familly. I use the last driver (not the one shipped with the kernel) but
I think this is not an issue.
Now It works for a few seconds (minutes) and the application using it
freeze. If I kill the app and retsart it, I works for a few seconds (it
looks like X and the mouse).
Here also it seems to appear when another app use most of the CPU.

The Xawtv outputs are interesting :

# xawtv
This is xawtv-3.68, running on Linux/i586 (2.4.17)
/dev/video0 [v4l]: no overlay support
v4l-conf had some trouble, trying to continue anyway
v4l: timeout (got SIGALRM), hardware/driver problems?
ioctl: VIDIOCSYNC(0): Appel syst=E8me interrompu
v4l: timeout (got SIGALRM), hardware/driver problems?
ioctl: VIDIOCSYNC(1): Appel syst=E8me interrompu

What do you think about it ?

I've enabled 'Allow IRQ during APM bios calls'. It seems slighly better
for the mouse but not significantly enough to be sure.

I've tried to boot without apm (apm=3Doff) but problems are still there.

Should I try a preemt or low-latency kernel ?

Christophe

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Dogs believe they are human. Cats believe they are God.

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8SuUfj0UvHtcstB4RArnTAJ9AZUJwalTr8hA+31/OtPVNc+cP8ACghU7h
GKUsE7LfiLO4xdWEZ56gL04=
=teCk
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
