Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269212AbTGVD1w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 23:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269218AbTGVD1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 23:27:52 -0400
Received: from h80ad26d6.async.vt.edu ([128.173.38.214]:33159 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269212AbTGVD1o (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 23:27:44 -0400
Message-Id: <200307220342.h6M3gbgf003555@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: junkio@cox.net
Cc: =?iso-2022-jp-2?b?ShsuQRtOdnJuRW5nZWw=?= 
	<joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Port SquashFS to 2.6 
In-Reply-To: Your message of "Mon, 21 Jul 2003 19:52:39 PDT."
             <7vd6g3uvbc.fsf@assigned-by-dhcp.cox.net> 
From: Valdis.Kletnieks@vt.edu
References: <fa.k0do8p6.ch6pps@ifi.uio.no> <fa.hre90bn.e6k5pf@ifi.uio.no>
            <7vd6g3uvbc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1483653688P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Jul 2003 23:42:37 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1483653688P
Content-Type: text/plain; charset=us-ascii

On Mon, 21 Jul 2003 19:52:39 PDT, junkio@cox.net said:

> If an architecture has a big stack usage per call that is
> imposed by the ABI, and larger kernel stack is allocated
> compared to other architectures because of this reason,
> shouldn't there be about the same amount of usable space left
> for the kernel programs within the allocated per-process kernel
> stack space to use?  If that is not the case then the port to
> that particular architecture would not be optimal, wouldn't it?

Not necessarily.  It's quite possible (likely even) that one architecture might
have N bytes overhead per call,  and is allowed a 4K stack, and some other
architecture has (N+30%) overhead, so 4K isn't enough - 5K is needed. However,
other considerations cause a whole-page allocation, so instead of allocating
5K, it goes to 8K, with a 3K wastage....

So yes, you can end up with suboptimal results.


--==_Exmh_1483653688P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/HLKtcC3lWbTT17ARAqU1AKDn7YRP3d9LDpdnr9UywKJ8w02QyQCg1lY2
5iFvLot8aE/ryGalvpABl7s=
=Mrn4
-----END PGP SIGNATURE-----

--==_Exmh_1483653688P--
