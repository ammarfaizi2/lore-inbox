Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbVKAGEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbVKAGEt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 01:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVKAGEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 01:04:49 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:666 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S932570AbVKAGEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 01:04:48 -0500
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Date: Tue, 1 Nov 2005 17:04:43 +1100
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert dmasound_awacs to dynamic input_dev allocation
Message-ID: <20051101060443.GF11202@cse.unsw.EDU.AU>
References: <20051101020329.GA7773@cse.unsw.EDU.AU> <200511010014.57026.dtor_core@ameritech.net> <20051101055052.GA16672@cse.unsw.EDU.AU> <200511010055.32726.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G6nVm6DDWH/FONJq"
Content-Disposition: inline
In-Reply-To: <200511010055.32726.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 01, 2005 at 12:55:31AM -0500, Dmitry Torokhov wrote:
> Now you are leaking memory if something else fails... FOr example when
> chip is not present.

Good point.  I guess the original comment is because the final
dmasound_init() can fail but we'll still have all sorts of memory,
irq's and io that aren't cleaned up.  So your previous patch probably
introduces the least problems.

-i

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDZwV7WDlSU/gp6ecRAjV4AJ9DuOekbWgp2OFLjOOc/bhHVcpeVACgywX3
BW59t0dipvbTDsfxYtNJzpM=
=Rx/u
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--
