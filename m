Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291753AbSCMBZ1>; Tue, 12 Mar 2002 20:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291745AbSCMBZR>; Tue, 12 Mar 2002 20:25:17 -0500
Received: from [217.79.102.244] ([217.79.102.244]:5630 "EHLO
	monkey.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S291753AbSCMBZD>; Tue, 12 Mar 2002 20:25:03 -0500
Subject: Re: Dropped packets on SUN GEM
From: Beezly <beezly@beezly.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020312.171509.08315746.davem@redhat.com>
In-Reply-To: <1015979767.2652.77.camel@monkey>
	<20020312.165609.18574402.davem@redhat.com>
	<1015981634.2652.82.camel@monkey> 
	<20020312.171509.08315746.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-54uRXXWEQ1hDHtj6ahs+"
X-Mailer: Evolution/1.0.2 
Date: 13 Mar 2002 01:24:59 +0000
Message-Id: <1015982699.17761.86.camel@monkey>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-54uRXXWEQ1hDHtj6ahs+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Ahha! ;)=20

Looks like some better output now.

sungem.c:v0.96 11/17/01 David S. Miller (davem@redhat.com)
PCI: Found IRQ 5 for device 00:0a.0
PCI: Sharing IRQ 5 with 00:0b.1
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:00:00:00:00:00=20
eth0: Link is up at 1000 Mbps, full-duplex.
eth0: Pause is enabled (rxfifo: 20480 off: 17408 on: 15872)
eth0: PCS AutoNEG complete.
eth0: PCS link is now up.
eth0: Link is up at 1000 Mbps, full-duplex.
eth0: Pause is enabled (rxfifo: 20480 off: 17408 on: 15872)
eth0: Link is up at 1000 Mbps, full-duplex.
eth0: Pause is enabled (rxfifo: 20480 off: 17408 on: 15872)
eth0: Link is up at 1000 Mbps, full-duplex.
eth0: Pause is enabled (rxfifo: 20480 off: 17408 on: 15872)


On Wed, 2002-03-13 at 01:15, David S. Miller wrote:
>    From: Beezly <beezly@beezly.org.uk>
>    Date: 13 Mar 2002 01:07:14 +0000
>   =20
>    It doesn't appear to :(
> ...  =20
>    eth0: Pause is disabled
>=20
> Some day I will learn how to program, you do have
> Pause enabled I just don't know how to print that
> our properly from the driver :-)
>=20
> --- drivers/net/sungem.c.~2~	Tue Mar 12 16:53:44 2002
> +++ drivers/net/sungem.c	Tue Mar 12 17:14:26 2002
> @@ -1213,15 +1213,15 @@
> =20
>  	if (netif_msg_link(gp)) {
>  		if (pause) {
> -			printk(KERN_INFO "%s: Pause is disabled\n",
> -			       gp->dev->name);
> -		} else {
>  			printk(KERN_INFO "%s: Pause is enabled "
>  			       "(rxfifo: %d off: %d on: %d)\n",
>  			       gp->dev->name,
>  			       gp->rx_fifo_sz,
>  			       gp->rx_pause_off,
>  			       gp->rx_pause_on);
> +		} else {
> +			printk(KERN_INFO "%s: Pause is disabled\n",
> +			       gp->dev->name);
>  		}
>  	}
> =20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


--=-54uRXXWEQ1hDHtj6ahs+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8jqprXu4ZFsMQjPgRAiugAJ9kcRmhzXXHgoSyLB/3Zwg24z3LYgCgusaW
Axw4UCguzvQadWnlS6cw8WU=
=bVEv
-----END PGP SIGNATURE-----

--=-54uRXXWEQ1hDHtj6ahs+--
