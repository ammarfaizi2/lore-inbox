Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTLQGhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 01:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbTLQGhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 01:37:16 -0500
Received: from gizmo01bw.bigpond.com ([144.140.70.11]:16829 "HELO
	gizmo01bw.bigpond.com") by vger.kernel.org with SMTP
	id S263637AbTLQGhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 01:37:14 -0500
Mail-Copies-To: never
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Alexis <alexis@attla.net.ar>
Subject: Re: modules in 2.6.0-test11
Keywords: modules,modprobe,major,char-major-
References: <006501c3c1fa$e1fb8d90$0200000a@heretic>
From: Steve Youngs <sryoungs@bigpond.net.au>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Organization: Linux Users - Fanatics Dept.
X-URL: <http://users.bigpond.net.au/sryoungs/>
X-Request-PGP: <http://users.bigpond.net.au/sryoungs/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Attribution: SY
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>, Alexis
 <alexis@attla.net.ar>
Date: Wed, 17 Dec 2003 16:37:03 +1000
In-Reply-To: <006501c3c1fa$e1fb8d90$0200000a@heretic> (alexis@attla.net.ar's
 message of "Sun, 14 Dec 2003 01:29:36 -0300")
Message-ID: <microsoft-free.87r7z4eyr4.fsf@eicq.dnsalias.org>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

|--==> "a" == alexis  <alexis@attla.net.ar> writes:

  a> The kernel works fine, all modules too but i have to insert them
  a> with insmod or modprobe, i cannot make that modules became loaded
  a> automatically.

Edit '/etc/modprobe.conf' and change "alias char-major-<major> foo" to
"alias char-major-<major>-<minor> foo".  Or "char-major-<major>-*" if
you can't determine the minor number.

The modules themselves are supposed to export these chardev aliases, which
will obsolete the entries in '/etc/modprobe.conf', but as yet only one or
two actually do this.  I have patches that fix most of the serial drivers
and right now I'm working my way through './drivers/char/'.  But I haven't
yet sent them in. 

-- 
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|              Ashes to ashes, dust to dust.               |
|      The proof of the pudding, is under the crust.       |
|------------------------------<sryoungs@bigpond.net.au>---|

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Eicq - The XEmacs ICQ Client <http://eicq.sf.net/>

iEYEABECAAYFAj/f+ZIACgkQHSfbS6lLMANUrgCgm9dgCKO67tQ6Z4zvU+idO3Vh
m2kAn313ECmsaQ9LC0Wu9rIlITlZiOQB
=b2aM
-----END PGP SIGNATURE-----
--=-=-=--
