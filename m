Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316404AbSEOPd5>; Wed, 15 May 2002 11:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316406AbSEOPd4>; Wed, 15 May 2002 11:33:56 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:35773 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id <S316404AbSEOPdz>;
	Wed, 15 May 2002 11:33:55 -0400
Date: Wed, 15 May 2002 17:33:49 +0200
From: Martin Schewe <m@xsms.de>
To: Jeff Meininger <jeffm@boxybutgood.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to map "/dev/root" to "/proc/partitions" entry in user prog?
Message-ID: <20020515153349.GA27312@linux01.gwdg.de>
In-Reply-To: <Pine.LNX.4.44.0205141554240.2160-100000@spaz.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 14, 2002 at 04:12:18PM -0500, Jeff Meininger wrote:
> How can I reliably map /dev/root to the corresponding entry in=20
> /proc/partitions?  Is there some /proc thing I'm missing, or is there an=
=20
> ioctl that can give me the information I'm looking for?

If you use devfs, you can check /dev/root, which is a symlink to your
root device:

	readlink("/dev/root", rootdev, PATH_MAX);

Otherwise you should take a look at busybox/libbb/find_root_device.c.

Regards,
		Martin

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE84n/cvFdT+uCkj6sRAkPQAJ0TNcBG930gw3j4AlBBp7fB0FZb/ACgqBpC
vmnDWPbpTCIOlFd/a1AHZ4I=
=LPxE
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
