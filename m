Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTF0OZF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 10:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbTF0OZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 10:25:05 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:4540 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264372AbTF0OY7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 10:24:59 -0400
From: Con Kolivas <kernel@kolivas.org>
Date: Sat, 28 Jun 2003 00:41:38 +1000
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] O1int patch with contest
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Message-Id: <200306280041.47619.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've had some (off list) requests to see if the interactivity patch I posted 
shows any differences in contest. To be honest I wasn't sure it would, and 
this is not quite what I expected. Below is a 2.5.73-mm1 patched with 
patch-O1int-0306271816 (2.5.73-O1i) compared to 2.5.73-mm1 with contest 
(http://contest.kolivas.org).


no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.73-O1i          1   78      93.6    0.0     0.0     1.00
2.5.73-mm1          1   77      94.8    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.73-O1i          1   75      97.3    0.0     0.0     0.96
2.5.73-mm1          1   75      98.7    0.0     0.0     0.97
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.73-O1i          1   94      78.7    39.0    20.2    1.21
2.5.73-mm1          2   108     67.6    67.0    29.6    1.40
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.73-O1i          1   86      84.9    0.0     0.0     1.10
2.5.73-mm1          3   103     74.8    0.0     0.0     1.34
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.73-O1i          1   92      80.4    1.0     3.3     1.18
2.5.73-mm1          3   113     66.4    2.0     4.4     1.47
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.73-O1i          1   101     73.3    24.6    12.9    1.29
2.5.73-mm1          4   127     59.1    39.7    16.5    1.65
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.73-O1i          1   95      78.9    22.7    11.6    1.22
2.5.73-mm1          2   112     67.9    43.0    19.6    1.45
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.73-O1i          1   92      80.4    2.7     2.2     1.18
2.5.73-mm1          2   100     76.0    7.8     7.0     1.30
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.73-O1i          1   87      86.2    0.0     1.1     1.12
2.5.73-mm1          2   93      80.6    0.0     7.5     1.21
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.73-O1i          1   84      86.9    35.0    1.2     1.08
2.5.73-mm1          2   114     68.4    54.0    1.8     1.48
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.73-O1i          1   222     33.3    2.0     31.5    2.85
2.5.73-mm1          4   365     20.8    5.0     48.2    4.74

I promise I didn't tune it with contest results in mind. There are still 
things I want to do to it that may not affect these results.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+/FekF6dfvkL3i1gRAhHUAJwOiLq+u3nEGn9Ym+c5x4JpTqrK1ACfX79F
WKLTsbtqwXyFpOZ+i+JvgVU=
=nQk2
-----END PGP SIGNATURE-----

