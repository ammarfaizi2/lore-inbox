Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUBXQKx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 11:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbUBXQIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 11:08:51 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:46289 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S262270AbUBXQGN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 11:06:13 -0500
Date: Tue, 24 Feb 2004 16:06:11 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Patrick Petermair <kernel-ml@petermair.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec 1210SA SATA Controller Performance
Message-ID: <20040224160611.GE18494@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Patrick Petermair <kernel-ml@petermair.at>,
	linux-kernel@vger.kernel.org
References: <403B5B47.2030907@petermair.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline
In-Reply-To: <403B5B47.2030907@petermair.at>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 24, 2004 at 03:10:15PM +0100, Patrick Petermair wrote:
> Yesterday I've setup a server with Adaptec's 1210SA SATA Controller and 
> 2 SATA disks. According to the kernel changelog the controller is 
> supported since 2.6.2
> 
> I've installed Debian on an IDE disk, built a 2.6.3 kernel with 
> CONFIG_SCSI_SATA_SIL, rebooted and the kernel detected the controller 
> plus both SATA disks (sda, sdb). As the next step I wanted to create a 
> software raid 1 with the 2 SATA disks. Because it took mdadm forever to 
> finish, I checked /proc/mdstat and saw a progress bar with a rate of 12MB/s!
> 
> Even my oldest IDE disk is faster than this. Is there a way to tweak the 
> SATA controller/disk with some kernel-options or is the driver not 
> providing more speed?

   You don't say what make of disk these are. It may be that you've
fallen foul of the Seagate/SiI erratum, which (as far as I can tell)
still kills performance. I have a 120GiB Seagate disk attached to a
SiI3112 controller, and I'm lucky if I get 12MiB/s with the IDE-layer
driver. I haven't tried the libata driver yet.

   I'm not too worried about that set-up, because I don't need massive
performance off that disk anyway, but something faster might be
nice. :)

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
    --- Jazz is the sort of music where no-one plays anything the ---    
                             same way once.                              

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAO3ZzssJ7whwzWGARAl/1AJ0Uk6xwuHpvl1FqQnqubuQMH8Hy8gCgp3uV
0djq4Ha+1advsPBocLyd/lI=
=S88I
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--
