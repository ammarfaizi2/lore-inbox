Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbTBJUYM>; Mon, 10 Feb 2003 15:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbTBJUYM>; Mon, 10 Feb 2003 15:24:12 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:17991 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S265097AbTBJUYK>; Mon, 10 Feb 2003 15:24:10 -0500
Date: Mon, 10 Feb 2003 21:33:53 +0100
From: Kurt Garloff <garloff@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Jakob Oestergaard <jakob@unthought.net>, Andrew Morton <akpm@digeo.com>,
       David Lang <david.lang@digitalinsight.com>, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210203353.GA13976@nbkurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andrea Arcangeli <andrea@suse.de>,
	Nick Piggin <piggin@cyberone.com.au>,
	Jakob Oestergaard <jakob@unthought.net>,
	Andrew Morton <akpm@digeo.com>,
	David Lang <david.lang@digitalinsight.com>, riel@conectiva.com.br,
	ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com> <Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com> <20030209203343.06608eb3.akpm@digeo.com> <20030210045107.GD1109@unthought.net> <3E473172.3060407@cyberone.com.au> <20030210073614.GJ31401@dualathlon.random> <3E47579A.4000700@cyberone.com.au> <20030210080858.GM31401@dualathlon.random> <3E476287.8070407@cyberone.com.au> <20030210090248.GP31401@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20030210090248.GP31401@dualathlon.random>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.19-UL1 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2003 at 10:02:48AM +0100, Andrea Arcangeli wrote:
> On Mon, Feb 10, 2003 at 07:27:51PM +1100, Nick Piggin wrote:
> It doesn't make any sense to me your claim that you can decrease the
> readahead by adding anticipatory scheduling, if you do you'll run
> so slow at 8k per request in all common workloads.

Readahead kills seeks and command overhead at the expense of maybe
transfering data needlessly over the bus and consuming RAM.

AS kills seeks. (At the expense of delaying some IO a tiny bit.)

If unecessary seeks are the main problem, with AS smaller READA is=20
possible. If command overhead is a problem, READA needs to be large.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers                 SuSE Labs (Head)
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+SAyxxmLh6hyYd04RAsVlAKCNbYh9WtaKCVG02S7ARZ6SLURpfQCeKboE
lU7SP8GBza50lHcQxmem+JU=
=nVsd
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
