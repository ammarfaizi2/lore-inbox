Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275012AbRJ3Muh>; Tue, 30 Oct 2001 07:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275082AbRJ3Mu1>; Tue, 30 Oct 2001 07:50:27 -0500
Received: from mail.2d3d.co.za ([196.14.185.200]:17829 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S275012AbRJ3MuP>;
	Tue, 30 Oct 2001 07:50:15 -0500
Date: Tue, 30 Oct 2001 14:54:30 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: david.heremans@siemens.atea.be
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Low-level help needed with leds
Message-ID: <20011030145430.A16835@crystal.2d3d.co.za>
Mail-Followup-To: Abraham vd Merwe <abraham@2d3d.co.za>,
	david.heremans@siemens.atea.be,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20011030124918.A1932@PCF988>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011030124918.A1932@PCF988>; from david.heremans@siemens.atea.be on Tue, Oct 30, 2001 at 12:49:18 +0100
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.2 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 1:59pm  up 17 days, 22:40,  7 users,  load average: 0.02, 0.06, 0.01
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi david.heremans!

I browsed through linux/drivers/char/pc_keyb.c and linux/drivers/keyboard.c
and it doesn't seem like it's caching sets/gets. I quickly browsed through
your code, but I didn't really look for errors. Instead, I hacked a quick
program for you which does exactly what you want. I don't have an ipac, but
I tested it on my PC (just pressed the keys, etc.) and it should work. If it
doesn't you should check the datasheet and see whether there shouldn't be
any delays between settings the leds.

PS: The program is attached

> I'm writing to this maillinglist as a last resort, since reading books
> and other peoples code didn't solve my problem, and it is on the vague
> boundary of userspace/kernel.
>=20
> I recently got hold of a nice little piece of hardware that must be
> connected between the computer and the keyboard. You can program this
> device by sending it bytes trough the keyboard-leds.
> More about this device at http://www.andywarne.pwp.blueyonder.co.uk/,
> the device is called the I-Pac.
>=20
> The programming protocol description I got from the maker of this hardwar=
e states this
> sequence.
> 1. Set any led combination execpt all leds on.
> 2. Send five times all leds on.
> 3. The I-Pac will send a key-down code for the 'Y' (ready to program) or
> 'J' (jumper set to fixed) key.
>=20
> I don't get this key code back.
> I was wondering if I misunderstood the way the Linux kernel sends this
> LEDs commands. Does it send extra led commands that I don't know about?
> Maybe it doesn't send twice the same led formation since it would be a
> logical optimisation? Honestly, I'm completely clueless by now, and
> digging into the Linux source code is way to complicated for me, I
> honestly tried but got lost in it (tasklets et all) :-(
>=20
> I took the liberty of attaching a simplified version of
> my programming tool. If some of the more knowledgable people here could
> please help me out, thanks.
>=20
> Sincerely,
> David Heremans
>=20
> PS: I'm not subscribed to this list, I just scan the archieves and
> digests from time to time. So I you reply please put me in CC.
> PPS: When compiling the c program I also got redefine warnings in
> headers, sugestions to solve these are also welcomme, the include list I
> use is a mix of other example programs, so I'm not sure which are the
> exact ones to use.

> -rw-r--r-- david/david    3131 2001-10-16 09:47:33 console-lib-program-ip=
ac.inc
> -rw------- david/david    3491 2001-10-16 22:28:02 program-ipac.c


--=20

Regards
 Abraham

Work is the crab grass in the lawn of life.
		-- Schulz

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Antree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--82I3+IH0IqGh5yIs
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="ipac.tar.gz"
Content-Transfer-Encoding: base64

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
ocPYACgAAA==

--82I3+IH0IqGh5yIs--

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE73qMGzNXhP0RCUqMRAvFqAKCJpcqHJUUa0ceVoD5fMJPbOcbAFACdH1W8
4UAIHsv4dXda1l5JW4Y4j/o=
=8ghM
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
