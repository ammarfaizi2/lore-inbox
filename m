Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbTIAMa3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 08:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbTIAMa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 08:30:29 -0400
Received: from [213.69.232.58] ([213.69.232.58]:21514 "HELO
	flapp.schottelius.org") by vger.kernel.org with SMTP
	id S262856AbTIAMa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 08:30:27 -0400
Date: Mon, 1 Sep 2003 14:28:18 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: bastian@schottelius.org
Subject: [BUGS?: 2.6.0test4] iptables and tc problems
Message-ID: <20030901122818.GE5524@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bastian@schottelius.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Content-Disposition: inline
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux flapp 2.6.0-test4
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

While trying to setup qos with test4 I get some problems:

When running qos-neu (http://schotteli.us/~nico/qos-neu) dmesg says:
HTB init, kernel part version 3.13
HTB: quantum of class 10010 is small. Consider r2q change.
HTB: quantum of class 10011 is small. Consider r2q change.
HTB: quantum of class 10012 is small. Consider r2q change.

And then testing with the ftp (passive) transmissions shows 16kbyte/s, alth=
ough
I moved mark 13 to 2kbit.

Then trying to match the ftp connections
bruehe:~#  iptables -A OUTPUT -m owner --uid-owner 0 -j ACCEPT  =20
iptables: Invalid argument
bruehe:~# iptables -t mangle -A POSTROUTING -o ppp0 -m owner --uid-owner 10=
01 -j MARK --set-mark 55
iptables: Invalid argument

Why does iptables or the kernel not accept that?

Greetings,

Nico

--=20
quote:   there are two time a day you should do nothing: before 12 and afte=
r 12
         (Nico Schottelius after writin' a very senseless email)
cmd:     echo God bless America | sed 's/.*\(A.*\)$/Why \1?/'
pgp:     new id: 0x8D0E27A4 | ftp.schottelius.org/pub/familiy/nico/pgp-key.=
new
url:     http://nerd-hosting.net - domains for nerds (from a nerd)

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/UztizGnTqo0OJ6QRAr8YAKDRWDgqQ9B38NUO0m9lWym+NsCwAgCeNxz6
jHzR94NlcLyH7XJuXO+etuU=
=SgyZ
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
