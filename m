Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286188AbRLJIGz>; Mon, 10 Dec 2001 03:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286189AbRLJIGj>; Mon, 10 Dec 2001 03:06:39 -0500
Received: from mail.2d3d.co.za ([196.14.185.200]:19168 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S286188AbRLJIG2>;
	Mon, 10 Dec 2001 03:06:28 -0500
Date: Mon, 10 Dec 2001 10:09:18 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: salinarl <Lanfranco.Salinari@icn.siemens.it>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Question about sniffers and linux
Message-ID: <20011210100918.E1502@crystal.2d3d.co.za>
Mail-Followup-To: Abraham vd Merwe <abraham@2d3d.co.za>,
	salinarl <Lanfranco.Salinari@icn.siemens.it>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <3BEC87A2@webmail>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BEC87A2@webmail>; from Lanfranco.Salinari@icn.siemens.it on Fri, Dec 07, 2001 at 19:44:49 +0100
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.2 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 9:38am  up 19 min,  2 users,  load average: 0.09, 0.04, 0.04
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi salinarl!

You don't need to write a kernel module to do this.

Use RAW sockets. (See man 2 socket). If you're not interested in the link
layer, you can also use DGRAM sockets to get everything from layer 3 and up
(ip, arp, etc.)

> I am new to kernel internals, and I would like to know how can a sniffer
> read whole packets, I mean including the link layer header. In the receive
> path, this happens, I think,  in the net_rx_action(), but in the transmit
> path?
> I know that there is a function called dev_queue_xmit_nit() for this, but
> how can a driver add a link layer header to a packet before this function
> gets called? The hard_start_xmit() of the driver is, in fact, called after
> the dev_queue_xmit_nit(), (in the function dev_queue_xmit() ).
> I think I'm missing something important about the subject, but I hope som=
eone=20
> will answer me, anyway.
> Thank you in advance,
>=20
> Lanfranco
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20

Regards
 Abraham

What we wish, that we readily believe.
		-- Demosthenes

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Antree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8FG2uzNXhP0RCUqMRAraxAJ9W3SPeo3D/49ft5YRzxH2Ttz7G7QCdHyzt
eHYMTv53u6L3k7Duk7RwuI8=
=tI8l
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
