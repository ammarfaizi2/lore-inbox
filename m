Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUHJJvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUHJJvA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbUHJJuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:50:44 -0400
Received: from cantor.suse.de ([195.135.220.2]:54221 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263818AbUHJJuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:50:23 -0400
Date: Tue, 10 Aug 2004 09:28:24 +0200
From: Kurt Garloff <garloff@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, davidsen@tmr.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RSS ulimit enforcement for 2.6.8
Message-ID: <20040810072824.GA12445@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
	davidsen@tmr.com, linux-kernel@vger.kernel.org
References: <411299D4.5060001@tmr.com> <Pine.LNX.4.44.0408051647440.8229-100000@dhcp83-102.boston.redhat.com> <20040805142019.712c678a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20040805142019.712c678a.akpm@osdl.org>
X-Operating-System: Linux 2.6.7-0-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 05, 2004 at 02:20:19PM -0700, Andrew Morton wrote:
> It might not be.  We could come up with some dopey per-process flag,
> inherited across fork which means "invalidate each file's pagecache when I
> close it". =20

Currently, we don't even have a way to explicitly drop page cache
for a file or filesystem except for umounting it.=20
In the old buffer cache days, BLKFLSBUF would have done it, but
that's pretty much without any effect nowadays.

So maybe you want to add the ioctl as well.
It would be useful for doagnostics and benchmarking as well.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG / Novell, Nuernberg, DE               Director SUSE Labs

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBGHkYxmLh6hyYd04RAszZAJ92F0DJwabWbsy5jMBvvEYfXXvm+gCfQVUl
H3WynyugGhXij0tLRrwRsZM=
=12DF
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
