Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272736AbTG1Idt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 04:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272742AbTG1Idt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 04:33:49 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:2322 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S272736AbTG1Idr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 04:33:47 -0400
Date: Mon, 28 Jul 2003 10:49:00 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k wd33c93 locking
Message-ID: <20030728084859.GY7452@lug-owl.de>
Mail-Followup-To: Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <200307261451.h6QEpT9s002280@callisto.of.borg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e8znkWhb8vS+si4n"
Content-Disposition: inline
In-Reply-To: <200307261451.h6QEpT9s002280@callisto.of.borg>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--e8znkWhb8vS+si4n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-07-26 16:51:29 +0200, Geert Uytterhoeven <geert@linux-m68k.org>
wrote in message <200307261451.h6QEpT9s002280@callisto.of.borg>:
> M68k wd33c93: host_lock is a pointer to a spinlock, not a spinlock (from =
Ralf
> B=E4chle)

> --- linux-2.6.x/drivers/scsi/a3000.c	Fri May  9 10:21:34 2003
> +++ linux-m68k-2.6.x/drivers/scsi/a3000.c	Fri Jun  6 13:33:13 2003
> @@ -36,9 +36,9 @@
>  		return IRQ_NONE;
>  	if (status & ISTR_INTS)
>  	{
> -		spin_lock_irqsave(&a3000_host->host_lock, flags);
> +		spin_lock_irqsave(a3000_host->host_lock, flags);
>  		wd33c93_intr (a3000_host);
> -		spin_unlock_irqrestore(&a3000_host->host_lock, flags);
> +		spin_unlock_irqrestore(a3000_host->host_lock, flags);
>  		return IRQ_HANDLED;
>  	}
>  	printk("Non-serviced A3000 SCSI-interrupt? ISTR =3D %02x\n", status);

Is this the fix to A3000 SCSI? Hmmm... I'd give my box another try these
days:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--e8znkWhb8vS+si4n
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/JON7Hb1edYOZ4bsRAlYrAJ9D/3GmW0XFOD8nSm46kNhU25f8swCcCU5z
XG/wXcK+KJmDcix7GQvPxes=
=MA6h
-----END PGP SIGNATURE-----

--e8znkWhb8vS+si4n--
