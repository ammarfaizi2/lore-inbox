Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287148AbRL2HQo>; Sat, 29 Dec 2001 02:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287145AbRL2HQf>; Sat, 29 Dec 2001 02:16:35 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:171 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S287148AbRL2HQV>; Sat, 29 Dec 2001 02:16:21 -0500
Subject: NETIF_F_(SG|FRAGLIST|HIGHDMA) docs anywhere?
From: Daniel Stodden <stodden@in.tum.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-xSFVlNoQYwz1NgJvVZDG"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 29 Dec 2001 08:16:12 +0100
Message-Id: <1009610172.2105.0.camel@bitch>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xSFVlNoQYwz1NgJvVZDG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


hi.

software-only network device, currently implementing none of the
dev->features flags.

the driver transmits packets via pci dma to other processors residing on
a shared PCI bus segment. so i guess supporting at least scatter/gather
should give some performance improvements in order to get rid of
skb_linearize() on xmit? since transmission is done completely by the
local cpu, all of F_SG/FRAGLIST/HIGHDMA look relatively easy to
implemement to me.=20

my major problem is test cases and getting the picture behind these
structures. is there any documentation around on the
skb_shinfo(skb)->frags and skb_shinfo(skb)->frag_list stuff? i've spend
quite some time now trying to figure out exactly under which
circumstances which of both applies. not too successful i must admit :)

frag_list seems to be the list involved with keeping track of ip
fragmentation. so dev->hard_start_xmit() with frag_list set would only
happen on routers or when??

when is nr_frags>0? i've found some postings indicating sendfile(2) will
benefit here. is this the only case? need some test code..

any hint appreciated,
dns

--=20
___________________________________________________________________________
 mailto:stodden@in.tum.de


--=-xSFVlNoQYwz1NgJvVZDG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8LW28SPSplX5M5nQRAvviAKCQ8p8q7O0Vb05nzXEsa4CFs6guIwCdE5Mc
5OcwE4Hi6RVIsYgDoC4WC7M=
=xFlE
-----END PGP SIGNATURE-----

--=-xSFVlNoQYwz1NgJvVZDG--
