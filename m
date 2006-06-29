Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933082AbWF2XHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933082AbWF2XHp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 19:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933087AbWF2XHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 19:07:45 -0400
Received: from pool-72-66-205-146.ronkva.east.verizon.net ([72.66.205.146]:22467
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S933082AbWF2XHo (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 19:07:44 -0400
Message-Id: <200606292307.k5TN7MGD011615@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Roman Zippel <zippel@linux-m68k.org>
Cc: john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: Your message of "Wed, 28 Jun 2006 13:44:12 +0200."
             <Pine.LNX.4.64.0606281335380.17704@scrub.home>
From: Valdis.Kletnieks@vt.edu
References: <20060624061914.202fbfb5.akpm@osdl.org> <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu> <Pine.LNX.4.64.0606271212150.17704@scrub.home> <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu> <Pine.LNX.4.64.0606271903320.12900@scrub.home> <Pine.LNX.4.64.0606271919450.17704@scrub.home> <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu> <1151453231.24656.49.camel@cog.beaverton.ibm.com> <Pine.LNX.4.64.0606281218130.12900@scrub.home>
            <Pine.LNX.4.64.0606281335380.17704@scrub.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1151622441_4578P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 29 Jun 2006 19:07:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1151622441_4578P
Content-Type: text/plain; charset=us-ascii

On Wed, 28 Jun 2006 13:44:12 +0200, Roman Zippel said:

> Valdis, could you please add a call to the function below in 
> __get_realtime_clock_ts() when the problem triggers to print the complete 
> internal clock state.

Sorry for the delay, I got distracted by other stuff I'm paid to do.. ;)

Here's what a test reboot got:

   26.578105] audit(1151617213.106:2): policy loaded auid=4294967295
[   26.597401] audit(1151617213.070:3): avc:  granted  { load_policy } for  pid=1 comm="init" scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r
:security_t:s0 tclass=security
[   26.683670] unexpected nsec: -840940811,1655512912
[   26.704096] clock tsc: m:4290198220,s:22,cl:42659140158,ci:1595067,xn:18158513697558798592,xi:18446736466713803524,e:3648592523541009408
[   26.726249] unexpected nsec: -969254771,1077037877
[   26.748379] clock tsc: m:4290198222,s:22,cl:42729323106,ci:1595067,xn:17978369712466660208,xi:18446736466716993658,e:4180283123443907584
[   26.795463] unexpected nsec: -1374919676,1598670381
[   26.819393] clock tsc: m:4290198248,s:22,cl:42842572863,ci:1595067,xn:17672124937802117152,xi:18446736466758465400,e:5038236766383932416
[   27.266329] unexpected nsec: -782710824,2549621102
[   27.291643] clock tsc: m:4290198468,s:22,cl:43597039554,ci:1595067,xn:15690541101761319008,xi:18446736467109380140,e:-7692993275657145344
[   27.346941] unexpected nsec: -325230283,2119385465
[   27.373616] clock tsc: m:4290198437,s:22,cl:43727835048,ci:1595067,xn:15348267530081761464,xi:18446736467059933063,e:-6702146452294080512
[   27.437732] unexpected nsec: -1295951870,2004275512
[   27.465648] clock tsc: m:4290198398,s:22,cl:43876176279,ci:1595067,xn:14951950762871702254,xi:18446736466997725450,e:-5578375800491670528
[   27.535596] unexpected nsec: -689435342,2026093159
[   27.565211] clock tsc: m:4290198355,s:22,cl:44034087912,ci:1595067,xn:14537619597154605516,xi:18446736466929137569,e:-4382097184645369856
[   27.848139] unexpected nsec: -724490858,2057851911
[   27.879434] clock tsc: m:4290198101,s:22,cl:44536534017,ci:1595067,xn:13204554107451287893,xi:18446736466523990551,e:-575679729966697472
[   27.912117] unexpected nsec: -1417871539,554358979
[   27.944886] clock tsc: m:4290198101,s:22,cl:44641808439,ci:1595067,xn:12934338129808808595,xi:18446736466523990551,e:221869107013499904
[   37.257357] unexpected nsec: -138785571,1134135898
[   37.291448] clock tsc: m:3483968852,s:22,cl:59571635559,ci:1595067,xn:12754194144714192038,xi:908396457673218998,e:311350649952236544
[   42.318566] unexpected nsec: -321935843,935054298
[   42.353815] clock tsc: m:3080902004,s:22,cl:67660220316,ci:1595067,xn:90071992551050208,xi:4413529548527152531,e:5223654203068061696
[   47.381773] unexpected nsec: -922994772,489529208
[   47.418133] clock tsc: m:1738504176,s:22,cl:75750400140,ci:1595067,xn:10700552714632370560,xi:249397886484535734,e:1008065933768526848
[  107.031802] Real Time Clock Driver v1.12ac

That tell you anything?

--==_Exmh_1151622441_4578P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEpF0pcC3lWbTT17ARAqhXAJ40DwQM7loZH9vD/madvCeIU8aJ9QCeI9Mx
ZaUDLnQOWGaEAv5ge4DKsZc=
=PMIO
-----END PGP SIGNATURE-----

--==_Exmh_1151622441_4578P--
