Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbULOVD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbULOVD4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 16:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbULOVDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 16:03:55 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:4590 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262492AbULOVDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 16:03:49 -0500
Date: Wed, 15 Dec 2004 14:03:46 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cu, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       bjorn.helgaas@hp.com
Subject: Re: [PATCH] add legacy I/O and memory access routines to /proc/bus/pci API
Message-ID: <20041215210346.GK9923@schnapps.adilger.int>
Mail-Followup-To: Jesse Barnes <jbarnes@engr.sgi.com>,
	linux-pci@atrey.karlin.mff.cu, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
	bjorn.helgaas@hp.com
References: <200412140941.56116.jbarnes@engr.sgi.com> <200412150927.51733.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x1F0m3RQhDZyj8sd"
Content-Disposition: inline
In-Reply-To: <200412150927.51733.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x1F0m3RQhDZyj8sd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Dec 15, 2004  09:27 -0800, Jesse Barnes wrote:
> +write
> +  Legacy I/O port space reads and writes must also be to a file
> +  position >64k--the kernel will route them to the target device.

Shouldn't that be < 64k based on the description of lseek?

> +lseek
> +  Can be used to set the current file position.  Note that the file
> +  size is limited to 64k as that's how big legacy I/O space is.

> +ioctl
> +  Note that not all architectures support the *_MMAP_* or *_RW_* ioctl
> +  commands.  If they're not supported, ioctl will return -EINVAL.

Shouldn't they return -ENOTTY?  That indicates to the caller that the
ioctl isn't handled, vs -EINVAL which indicates bad value being passed
(e.g. bad write size).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--x1F0m3RQhDZyj8sd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBwKaypIg59Q01vtYRAoh8AKDmi9a8/dvTmXLivSzSXUPFDWZrHwCeOmpR
dnDEkYV/qdZa16A2p71gpqs=
=y7d8
-----END PGP SIGNATURE-----

--x1F0m3RQhDZyj8sd--
