Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284619AbRLIXO3>; Sun, 9 Dec 2001 18:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284555AbRLIXOW>; Sun, 9 Dec 2001 18:14:22 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:11015 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S284604AbRLIXOM>; Sun, 9 Dec 2001 18:14:12 -0500
Date: Mon, 10 Dec 2001 00:13:23 +0100
From: Kurt Garloff <garloff@suse.de>
To: Greg Hennessy <gsh@cox.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: horrible disk thorughput on itanium
Message-ID: <20011210001323.D25025@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Greg Hennessy <gsh@cox.rr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011206110713.A8404@cox.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Content-Disposition: inline
In-Reply-To: <20011206110713.A8404@cox.rr.com>
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 06, 2001 at 11:07:14AM -0500, Greg Hennessy wrote:
> [root@hydra bonnie]# cat bonnie.hydra bonnie.leo=20
[...]
> 	      --Seeks---
> Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU
> /sec %CPU
>           100  1765 100.0 282891 100.1 377295 100.0  2058 100.0 592709
> 	  99.5 51920.4 196.5

I bet you have more than 100MB RAM, so you measure memory performance
instead of disk performance in the block reads and writes. Same for seeks.
Don't do that. Always use at least twice you ram size if you're interested
in seeing your disk speed.
Newer bonnies warn you about it. The current release is 1.2.
http://www.garloff.de/kurt/linux/bonnie/

The char reads/writes seem to suffer glibc overhead.
You can use the _unlocked variants with option -u and see whether this makes
a difference.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8E/ATxmLh6hyYd04RApRkAJ4xD8gwbbQ2ukEjPil3hjgnTyQEMACfQsDQ
RhUaLwj8elhk62TgGadmwiY=
=qf1Q
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
