Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVC0XIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVC0XIx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 18:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVC0XIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 18:08:53 -0500
Received: from neveragain.de ([217.69.76.1]:64942 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S261517AbVC0XIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 18:08:50 -0500
Date: Mon, 28 Mar 2005 01:08:35 +0200
From: Martin Loschwitz <madkiss@madkiss.org>
To: Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org
Subject: Problems on Apple iBook with ALSA and snd-powermac [2.6.11.5]
Message-ID: <20050327230835.GA9006@minerva.local.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Greylist: Sender succeded SMTP AUTH authentication, not delayed by milter-greylist-1.4 (hobbit.neveragain.de [217.69.76.1]); Mon, 28 Mar 2005 01:08:38 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

given that the alsa-user-mailinglist has some strange kind of authentication
mechanism, and admin-authorization and whatever, I'm writing this mail to t=
he
LKML (it would have been CCed here anyway).

The current snd-powermac module from ALSA seems to have trouble with modern
Apple iBook computers (and possible other Apple notebooks, but I can't tell
for sure). With 2.6.11.5 and having snd-powermac loaded, playing some sound
results in a very noisy playback; you can only hear that if you turn volume
on the PCM and VOL mixers up to the maximum, and even then, it's very hard=
=20
to hear. After removing snd-powermac and loading the "old" pmac-driver, the
sound playback works just fine.

I have been able to find out that with 2.6.8 (at least with the version that
Debian ships currently), the problem does not appear; snd-powermac does its
job very nicely there. Given that 2.6.11 included some ALSA changes, I just
compiled 2.6.10 on this box and booted it, and had the same problems I have
with snd-powermac on 2.6.11.5.

Is this a known problem and is a fix available for it? If not, what can I do
to help with hunting this bug? I really like ALSA and prefer it over the old
pmac-sound-driver.

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCRzzyHPo+jNcUXjARAkRHAKCirfqu8IiSs9y2SGCdMYUYkpUwtACglrnq
HuQvPKwcw+XDjgzxNxawpUE=
=IbrA
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
