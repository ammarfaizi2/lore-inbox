Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264075AbTKSOH5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 09:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbTKSOH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 09:07:57 -0500
Received: from research.rutgers.edu ([128.6.25.145]:45003 "EHLO
	research.rutgers.edu") by vger.kernel.org with ESMTP
	id S264075AbTKSOHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 09:07:55 -0500
Subject: Kernel 2.6.0-test9 Zombie Issue
From: Taliver Heath <taliver@cs.rutgers.edu>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TpdRDUQV2hD9k8+VIhMt"
Organization: Darklab
Message-Id: <1069250850.11115.5.camel@leblon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 19 Nov 2003 09:07:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TpdRDUQV2hD9k8+VIhMt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

linux_ver:
Linux leblon 2.6.0-test9 #1 Thu Nov 13 09:18:59 EST 2003 i686 unknown

Gnu C                  3.3.2
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.11n
module-init-tools      0.9.15-pre3
e2fsprogs              1.27
xfsprogs               2.6.0
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 100.
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.11
Modules Loaded         uhci_hcd visor usbserial intel_agp agpgart
parport_pc lp parport hid 8250 serial_core cpuid msr apm es1371
soundcore ac97_codec usbkbd usbcore


Problem description:
I've noticed that if my system is very heavily loaded, I start to get
Zombies for any short lived processes.  I've googled for this, but can't
seem to find anything relating to it.  I'm running the 2.6.0-test9
kernel.  Is this something in the FAQ?

Specifically, I can recreate this behavior by getting my system
overloaded (converting .wav to .ogg, xmms, mozilla 10 page reload, on
fluxbox on a PIII 667) and then running many instances of aumix from the
keyboard shortcut.  Fluxbox normally detects the death of the children,
and I have a few Zombies which come from other programs as well
(mozilla, evolution, and others).

My theory is, and this has no code check to back it up in the slightest,
is that the preempt patch is throwing off the process management of the
kernel.  Or worse, perhaps the wait call is returning that it was
interrupted, and few programs are written to suppoort error checking on
the wait call (since in many instances you don't really care what
happened to the process).

I apologize for not scouring the kernel archives about this before I
emailed, but a quick scan didn't seem to turn up anything relevant.

--Taliver Heath

--=-TpdRDUQV2hD9k8+VIhMt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/u3kh9SFqLxG7mPYRAooiAJ9Z67xwoUM4/CriTSom1AdNO9GabgCgkwQQ
heHJ4laN2QtX/ebVlm4N04Y=
=+IWk
-----END PGP SIGNATURE-----

--=-TpdRDUQV2hD9k8+VIhMt--

