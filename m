Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264295AbUEXPJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264295AbUEXPJu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 11:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbUEXPJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 11:09:50 -0400
Received: from null.rsn.bth.se ([194.47.142.3]:10440 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S264295AbUEXPJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 11:09:48 -0400
Subject: Re: iptables and bootp
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040524164132.7f68e581.Christoph.Pleger@uni-dortmund.de>
References: <20040524164132.7f68e581.Christoph.Pleger@uni-dortmund.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kqPVTVsoZZg3RftdbvBM"
Message-Id: <1085411383.969.63.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 24 May 2004 17:09:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kqPVTVsoZZg3RftdbvBM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-05-24 at 16:41, Christoph Pleger wrote:
> Hello,
>=20
> I'm using the following commands to drop all traffic to and from the
> bootp-port of one of my machines:
>=20
> iptables -I INPUT -i eth0 -p tcp --destination-port bootps -j DROP
> iptables -I INPUT -i eth0 -p udp --destination-port bootps -j DROP
> iptables -I OUTPUT -o eth0 -p tcp --source-port bootps -j DROP
> iptables -I OUTPUT -o eth0 -p udp --source-port bootps -j DROP
>=20
> But this machine gives a reply to another machine's bootp-request that
> was created by the program "bootpc" (it is not possible that that answer
> comes from another bootp-Server). Iptables-Statistics show that
> UDP-packets to the bootps-port have been dropped, but obviously that has
> not really happened (as shown by tcpdump). Dropped outgoing packets from
> port bootps do not appear in the statistics.=20
>=20
> When I change the port number in the above commands (for example, to
> 20003), the packets are actually blocked.
>=20
> Does somebody have any advice?

The bootp-server uses raw sockets, iptables can't (and shouldn't) block
that. By the time iptables gets the packet, the bootp-server already got
a copy of the packet.
The bootp-server uses raw sockets in order to among other things be able
to send replies to a specific macaddress.

linux-kernel isn't the correct list for this. Please look at
http://www.netfilter.org/mailinglists.html

--=20
/Martin

--=-kqPVTVsoZZg3RftdbvBM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAshA3Wm2vlfa207ERAnM8AKDBx0vO2DVUtlScojKzImNiskusmQCfV0j2
xevaCtATGngjAnRX4g6JNGI=
=AOnp
-----END PGP SIGNATURE-----

--=-kqPVTVsoZZg3RftdbvBM--
