Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293129AbSCKIa0>; Mon, 11 Mar 2002 03:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293156AbSCKIaJ>; Mon, 11 Mar 2002 03:30:09 -0500
Received: from [217.79.102.244] ([217.79.102.244]:49146 "EHLO
	monkey.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S293129AbSCKI3w>; Mon, 11 Mar 2002 03:29:52 -0500
Subject: Re: Sun GEM card looses TX on x86 32bit PCI
From: Beezly <beezly@beezly.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020310.175858.21402963.davem@redhat.com>
In-Reply-To: <1015792619.1801.4.camel@monkey>
	<20020310.173935.74819813.davem@redhat.com> 
	<20020310.175858.21402963.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ttKYhrnvuzFqA0qeeOsU"
X-Mailer: Evolution/1.0.2 
Date: 11 Mar 2002 08:29:48 +0000
Message-Id: <1015835388.1802.12.camel@monkey>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ttKYhrnvuzFqA0qeeOsU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

With both patches applied I get the same effect :(

On Mon, 2002-03-11 at 01:58, David S. Miller wrote:
>=20
> I inadvertantly left out this part of the patch, sorry.
>=20
> --- drivers/net/sungem.h.~1~	Wed Jan 23 07:40:02 2002
> +++ drivers/net/sungem.h	Sun Mar 10 17:22:07 2002
> @@ -986,6 +986,8 @@
>  	int			mii_phy_addr;
>  	int			gigabit_capable;
> =20
> +	u32			mac_rx_cfg;
> +
>  	/* Autoneg & PHY control */
>  	int			link_cntl;
>  	int			link_advertise;

Here's the relevant output in /var/log/kern.log;

Mar 11 08:22:53 monkey kernel: sungem.c:v0.96 11/17/01 David S. Miller
(davem@redhat.com)
Mar 11 08:22:53 monkey kernel: PCI: Found IRQ 5 for device 00:0a.0
Mar 11 08:22:53 monkey kernel: PCI: Sharing IRQ 5 with 00:0b.1
Mar 11 08:22:53 monkey kernel: eth0: Sun GEM (PCI) 10/100/1000BaseT
Ethernet 00:00:00:00:00:00=20
Mar 11 08:22:56 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:22:56 monkey kernel: eth0: Pause is disabled
Mar 11 08:22:56 monkey kernel: eth0: PCS AutoNEG complete.
Mar 11 08:22:56 monkey kernel: eth0: PCS link is now up.
Mar 11 08:22:57 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:22:57 monkey kernel: eth0: Pause is disabled
Mar 11 08:22:58 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:22:58 monkey kernel: eth0: Pause is disabled
Mar 11 08:22:59 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:22:59 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:00 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:00 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:02 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:02 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:03 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:03 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:04 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:04 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:04 monkey kernel: eth0: no IPv6 routers present
Mar 11 08:23:05 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:05 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:06 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:06 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:08 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:08 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:09 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:09 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:10 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:10 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:11 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:11 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:12 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:12 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:14 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:14 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:15 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:15 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:16 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:16 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:17 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:17 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:18 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:18 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:20 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:20 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:21 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:21 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:22 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:22 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:23 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:23 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:24 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:24 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:26 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:26 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:27 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:27 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:28 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:28 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:29 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:29 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:30 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:30 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:32 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:32 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:33 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:33 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:34 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:34 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:35 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:35 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:36 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:36 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:38 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:38 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:39 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:39 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:40 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:40 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:41 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:41 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:42 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:42 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:44 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:44 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:45 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:45 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:46 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:46 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:47 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:47 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:48 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:48 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:50 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:50 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:51 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:51 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:52 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:52 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:53 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:53 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:54 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:54 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:56 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:56 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:57 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:57 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:58 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:58 monkey kernel: eth0: Pause is disabled
Mar 11 08:23:59 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:23:59 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:00 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:00 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:02 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:02 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:03 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:03 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:04 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:04 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:05 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:05 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:06 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:06 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:08 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:08 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:09 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:09 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:10 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:10 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:11 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:11 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:12 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:12 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:14 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:14 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:15 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:15 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:16 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:16 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:17 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:17 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:18 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:18 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:20 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:20 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:21 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:21 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:22 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:22 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:23 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:23 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:24 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:24 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:26 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:26 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:27 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:27 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:28 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:28 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:29 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:29 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:30 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:30 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:32 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:32 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:33 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:33 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:34 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:34 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:35 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:35 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:36 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:36 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:38 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:38 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:39 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:39 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:40 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:40 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:41 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:41 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:42 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:42 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:44 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:44 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:45 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:45 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:46 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:46 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:47 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:47 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:48 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:48 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:50 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:50 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:51 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:51 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:52 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:52 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:53 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:53 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:54 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:54 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:56 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:56 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:57 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:57 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:58 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:58 monkey kernel: eth0: Pause is disabled
Mar 11 08:24:59 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:24:59 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:00 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:00 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:02 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:02 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:03 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:03 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:04 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:04 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:05 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:05 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:06 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:06 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:08 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:08 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:09 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:09 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:10 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:10 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:11 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:11 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:12 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:12 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:14 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:14 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:15 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:15 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:16 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:16 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:17 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:17 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:18 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:18 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:20 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:20 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:21 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:21 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:22 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:22 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:23 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:23 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:24 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:24 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:26 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:26 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:27 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:27 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:28 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:28 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:29 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:29 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:30 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:30 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:32 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:32 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:33 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:33 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:34 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:34 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:35 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:35 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:36 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:36 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:38 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:38 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:39 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:39 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:40 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:40 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:41 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:41 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:42 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:42 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:44 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:44 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:45 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:45 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:46 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:46 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:47 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:47 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:48 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:48 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:50 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:50 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:51 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:51 monkey kernel: eth0: Pause is disabled
Mar 11 08:25:52 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 11 08:25:52 monkey kernel: eth0: Pause is disabled


And ifconfig output after RX has hung;

eth0      Link encap:Ethernet  HWaddr 00:03:BA:04:5B:D7 =20
          inet addr:10.0.0.12  Bcast:10.0.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:257020 errors:0 dropped:1 overruns:1 frame:1
          TX packets:257071 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100=20
          RX bytes:390064145 (371.9 MiB)  TX bytes:389098800 (371.0 MiB)
          Interrupt:5 Base address:0x8400=20


--=-ttKYhrnvuzFqA0qeeOsU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8jGr8Xu4ZFsMQjPgRAkVAAJ4uqGl1/2U1NTHwxTKL7x6KhXDt4ACfbbE1
w4ANInWj8+a7pDe3ga9sCLw=
=n6Ir
-----END PGP SIGNATURE-----

--=-ttKYhrnvuzFqA0qeeOsU--
