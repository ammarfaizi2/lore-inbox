Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265902AbTGDJe1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 05:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbTGDJe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 05:34:26 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:60941 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265902AbTGDJdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 05:33:19 -0400
Date: Fri, 4 Jul 2003 11:47:45 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH - RFC] [1/5] 64-bit network statistics - generic net
Message-ID: <20030704094745.GG29233@lug-owl.de>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200307032231.39842.jeffpc@optonline.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="psiQidSaV97t/NN8"
Content-Disposition: inline
In-Reply-To: <200307032231.39842.jeffpc@optonline.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--psiQidSaV97t/NN8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-07-03 22:31:27 -0400, Jeff Sipek <jeffpc@optonline.net>
wrote in message <200307032231.39842.jeffpc@optonline.net>:
Content-Description: clearsigned data
> The variables for network statistics (in struct net_device_stats) are uns=
igned=20
> longs. On 32-bit architectures, this makes them overflow every 4GB or 2^3=
2=20
> packets. The following series of patches [against 2.5.74] makes the=20
> statistics variable type configurable. The default is to leave everything=
 the=20
> way it was (unsigned long). However, when NETSTATS64 is set in the config=
,=20
> the statistics use 64-bit variables (u_int64_t) - this works only on 32-b=
it=20
> architectures.

Well... I don't really like to break userspace, but why don't we simply
make packet/traffic counters long long / u_int64_t? This way, we'd
simply keep almost all drivers untouched and only need to fiddle with
some sprints()/printk() statements?

Really, how many programs use the current statistics? I'd prefer to
modify them over adding strange patches like this one to the kernel...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--psiQidSaV97t/NN8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/BU1BHb1edYOZ4bsRAohsAJ0ervTO3drSzsx4hkTksc7LjqwfDACdHI49
5o1DYEODlS3uUd2AepfBU/g=
=FQOh
-----END PGP SIGNATURE-----

--psiQidSaV97t/NN8--
