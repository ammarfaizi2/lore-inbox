Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUCDSTT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbUCDSTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:19:12 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:48362 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S262065AbUCDSSX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:18:23 -0500
Date: Thu, 4 Mar 2004 18:18:20 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Patrick Petermair <kernel-ml@petermair.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec 1210SA SATA Controller Performance
Message-ID: <20040304181820.GA1719@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Patrick Petermair <kernel-ml@petermair.at>,
	linux-kernel@vger.kernel.org
References: <403B5B47.2030907@petermair.at> <403DAB74.1000504@pobox.com> <40474DE7.4000505@petermair.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <40474DE7.4000505@petermair.at>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 04, 2004 at 04:40:23PM +0100, Patrick Petermair wrote:
> Hi!
> 
> Sorry, for replying so late .. was a busy week and didn't have access to 
> the server until today.
> 
> >Do you have Seagate disks?
> 
> Yup, 2 Seagate Barracuda 7200.7 (80GB). Any problems with Seagate and 
> Adaptec 1210SA?

   Yes.

   There is a known problem with Seagate's SATA drives and the SiI
3112 controller that is used on the Adaptec 1210SA. The difficulty is
that certain [common] transfer sizes have to be split up into two
transfers in order to avoid triggering the erratum (which hangs the
machine, IIRC). This drops performance drastically. There is currently
no solution to the low performance of the Seagate/SiI combination.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
  --- Prof Brain had been in search of The Truth for 25 years, with ---  
             the intention of putting it under house arrest.             

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAR3LsssJ7whwzWGARAlXHAKCFvaCXqQY5vUrZ68e5WGIMTNYZEgCfdEw/
l1Tk+3j9KI0ARPtNiMm28fI=
=7f83
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
