Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUF2Q4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUF2Q4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 12:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUF2Q4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 12:56:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:42720 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265805AbUF2Q4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 12:56:08 -0400
Date: Tue, 29 Jun 2004 18:56:00 +0200
From: Kurt Garloff <garloff@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nice 19 process still gets some CPU
Message-ID: <20040629165600.GI4732@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Con Kolivas <kernel@kolivas.org>,
	Timothy Miller <miller@techsource.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <40E035CE.1020401@techsource.com> <40E03376.20705@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G2kvLHdEX2DcGdqq"
Content-Disposition: inline
In-Reply-To: <40E03376.20705@kolivas.org>
X-Operating-System: Linux 2.6.5-17-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G2kvLHdEX2DcGdqq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Con, Timothy,

On Tue, Jun 29, 2004 at 01:04:22AM +1000, Con Kolivas wrote:
> Timothy wrote:
> | I would expect that nice 0 processes should get SO MUCH more than nice
> | 19 processes that the nice 19 process would practically starve (and in
> | the case of a nice 19 process, I think starvation by nice 0 processes is
> | just fine), but it looks like it's not starving.
> |
> | Why is that?
>=20
> It definitely should _not_ starve. That is the unixy way of doing
> things. Everything must go forward. Around 5% cpu for nice 19 sounds
> just right. If you want scheduling only when there's spare cpu cycles
> you need a sched batch(idle) implementation.

5% seems a bit much for many people and they'd rather like to see 0%,
but given that we need to make progress, it could be tuned to ~1%.

Note that whenever the compiler will need to wait for the disk (page in
binary code, swapping, reading headers), the nice process will get to
run, so in practice the compiler does lose less than it seems at first
sight. If the nice process weren't, you'd see a certain percentage of
I/O wait ...

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG / Novell, Nuernberg, DE               Director SUSE Labs

--G2kvLHdEX2DcGdqq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4Z8gxmLh6hyYd04RAulwAJ4qdyprY5tQerH3F/RGHh7yGWwm2ACeJv8v
a2kJ8iqy/2AKPFBq93hW9T4=
=NNhJ
-----END PGP SIGNATURE-----

--G2kvLHdEX2DcGdqq--
