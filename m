Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316488AbSE1OYu>; Tue, 28 May 2002 10:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316620AbSE1OYt>; Tue, 28 May 2002 10:24:49 -0400
Received: from fw.2d3d.co.za ([66.8.28.230]:11749 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S316488AbSE1OYr>;
	Tue, 28 May 2002 10:24:47 -0400
Date: Tue, 28 May 2002 16:24:35 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Changing the current RTC device interface
Message-ID: <20020528162435.A4917@crystal.2d3d.co.za>
Mail-Followup-To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 4:15pm  up 26 days, 23:03, 16 users,  load average: 0.03, 0.02, 0.00
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have a board with multiple RTC chips (Built-in RTC in the processor +
external battery backed RTC).

There are pros and cons to each RTC chip. The CPU's RTC doesn't have a
battery, but have high resolution timing + multiple rtc counters/interrupts,
so it is especially suited for apps that want to use /dev/rtc for high
resolution timing.

On the other hand the external RTC chip can keep time, but its timing is
crap (1hz to 8khz in steps of powers of two), so you don't want to use that
for timing.

At the moment, Linux only allows for a single RTC device, so one can't reap
the benefits of both chips mentioned above.

How about we get a major number assigned to rtc subsystem and then allows
for multiple rtc devices.

The same argument goes for the non-volatile ram found on RTC chips, so we
actually need to change the entire RTC interface so that we can throw away
/dev/nvram

Any objections / suggestions / comments about things that's wrong/right
about the current RTC implementation?

--=20

Regards
 Abraham

Never leave anything to chance; make sure all your crimes are premeditated.

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE885MjzNXhP0RCUqMRAp9UAJ9GJnsR+Rh+zH8EU0Pb/+EBpF/7UwCgjXq3
nHqkZf/tUysYYZIS2ZZQkQ8=
=Vf7R
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
