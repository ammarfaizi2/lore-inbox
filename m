Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWE2TpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWE2TpP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 15:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWE2TpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 15:45:15 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:59792 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751251AbWE2TpN (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 15:45:13 -0400
Message-Id: <200605291944.k4TJixBW011192@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Adaptive Readahead V14 - statistics question...
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1148931899_7266P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 29 May 2006 15:44:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1148931899_7266P
Content-Type: text/plain; charset=us-ascii

Running 2.6.17-rc4-mm3 + V14.  I see this in /debug/readahead/events:

[table summary]      total   initial     state   context  contexta  backward  onthrash    onseek      none
random_rate             8%        0%        4%       46%        9%       44%        0%       38%       18%
ra_hit_rate            89%       97%       90%       40%       83%       76%        0%       49%        0%
la_hit_rate            62%       99%       88%       29%       84%     9500%        0%      200%     3700%
var_ra_size            703         4      8064        39      5780         3         0        59      3010
avg_ra_size              6         2        67         6        33         2         0         4        36
avg_la_size             37         1        96         4        45         0         0         0         0

Are the 9500%, 200%, and 3700% numbers in la_hit_rate related to reality
in any way, or is something b0rken?

And is there any documentation on what these mean, so you can tell if it's
doing anything useful? (One thing I've noticed is that xmms, rather than gobble
up 100K of data off disk every 10 seconds or so, snarfs a big 2M chunk every
3-4 minutes, often sucking in an entire song at (nearly) one shot...)

(Complete contents of readahead/events follows, in case it helps diagnose...)

[table requests]     total   initial     state   context  contexta  backward  onthrash    onseek      none
cache_miss            3934       543        93      2013        39      1199         0        47       417
random_read           1772        59        49      1059        11       575         0        19       327
io_congestion            4         0         4         0         0         0         0         0         0
io_cache_hit          1082         1        63       855        14       144         0         5         0
io_block             26320     18973      3519      2225       265      1288         0        50      1371
readahead            18601     15540      1008      1203       110       710         0        30      1483
lookahead             1972       153       671      1050        98         0         0         0         0
lookahead_hit         1241       152       596       312        84        95         0         2        37
lookahead_ignore         0         0         0         0         0         0         0         0         0
readahead_mmap           0         0         0         0         0         0         0         0         0
readahead_eof        14951     14348       569        19        15         0         0         0         0
readahead_shrink         0         0         0         0         0         0         0         0        70
readahead_thrash         0         0         0         0         0         0         0         0         0
readahead_mutilt         0         0         0         0         0         0         0         0         0
readahead_rescue         0         0         0         0         0         0         0         0       138

[table pages]        total   initial     state   context  contexta  backward  onthrash    onseek      none
cache_miss            6541      2472       754      2026        43      1199         0        47      1194
random_read           1784        62        51      1065        12       575         0        19       337
io_congestion          396         0       396         0         0         0         0         0         0
io_cache_hit         10185         2       571      7930      1383       293         0         6         0
readahead           111015     30757     67949      6864      3642      1681         0       122     53677
readahead_hit        98812     30052     61602      2762      3041      1294         0        61       277
lookahead            72607       185     64222      3734      4466         0         0         0         0
lookahead_hit        68640       184     59207      4475      4774         0         0         0         0
lookahead_ignore         0         0         0         0         0         0         0         0         0
readahead_mmap           0         0         0         0         0         0         0         0         0
readahead_eof        39959     25045     14102        64       748         0         0         0         0
readahead_shrink         0         0         0         0         0         0         0         0      1076
readahead_thrash         0         0         0         0         0         0         0         0         0
readahead_mutilt         0         0         0         0         0         0         0         0         0
readahead_rescue         0         0         0         0         0         0         0         0      9538

[table summary]      total   initial     state   context  contexta  backward  onthrash    onseek      none
random_rate             8%        0%        4%       46%        9%       44%        0%       38%       18%
ra_hit_rate            89%       97%       90%       40%       83%       76%        0%       49%        0%
la_hit_rate            62%       99%       88%       29%       84%     9500%        0%      200%     3700%
var_ra_size            703         4      8064        39      5780         3         0        59      3010
avg_ra_size              6         2        67         6        33         2         0         4        36
avg_la_size             37         1        96         4        45         0         0         0         0


--==_Exmh_1148931899_7266P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEe087cC3lWbTT17ARAmLaAKCDkAEhYxyisPa55SN5p2PeFGHTFQCeLUjI
rnqHJPMBXyE+B8l8YGQpD78=
=C5MI
-----END PGP SIGNATURE-----

--==_Exmh_1148931899_7266P--
