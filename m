Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264336AbTDXAUD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbTDXAUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:20:02 -0400
Received: from c-180372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.24]:60421
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S264336AbTDXATw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:19:52 -0400
Subject: Re: [Bug 623] New: Volume not remembered.
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Cc: "Martin J. Bligh" <mbligh@aracnet.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QO9U2mNcwJrQCW2FO4as"
Organization: 
Message-Id: <1051144315.2199.22.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Apr 2003 02:31:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QO9U2mNcwJrQCW2FO4as
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Apr 2003 00:30:16 +0200, Martin J. Bligh wrote:
>> Yes, but that's a user space problem too. Nothing prevents your
>> distribution to crank up the volume to 100% also on a first-time
>> installation.
>=20
> 100% would be stupid too. If the distro can pick a reasonable value, the
> kernel can too. Thus the argument "push the problem into userspace"
> doesn't do anything for me.

100% isn't good. F.ex. emu10k1 cards would lead to more bugreports since
you get clipping with that volume.

>> The kernel should pick a value that's safe in all cases. And this is
>> zero. Don't forget that there can be several seconds between the
>> driver's initialization and the moment when the user-space utility gets
>> to change the settings.
>=20
> So if people want 0 volume for some reason, they can set *that* in
> userspace. Windows can manage to do this without cocking it up. I don't
> see why we can't achieve it.

Which is stupid, since you need it zero before it can get to userspace.
(see the examples) And i know windows users who hates windows
soundcontrol since it plays a lame sound at boot up and you can't lower
the volume there (yes, easy workaround, but the same thing).

But, imho:
	PCM should not be 0, Setting main volume to 0 is good, but 	seeing the
common user getting there might be a problem.

Imagine:
Joe User installs Joe-Distro and starts xmms, now, with the default
config you change the 'master' volume but pcm is still 0. This is
something that will/could/might/etc cause reports like that.

Problem is, emu10k1 is good somewhere on the lines of 90% when it comes
to pcm... I dunno if other cards has simular issues.

Change PCM (and simular) if anything, changing master will only cause
problems, as seen.

CC, since I'm not on this ml.

--=20
Ian Kumlien <pomac@vapor.com>

--=-QO9U2mNcwJrQCW2FO4as
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+pzB77F3Euyc51N8RAiBIAJ9GpEevQqisaD1sKNM6agNiY/EZRgCfRl87
1IpIaj1K7VL2uKy9n4Fiz9k=
=oU6S
-----END PGP SIGNATURE-----

--=-QO9U2mNcwJrQCW2FO4as--

