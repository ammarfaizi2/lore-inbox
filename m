Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261506AbSLUEaA>; Fri, 20 Dec 2002 23:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSLUEaA>; Fri, 20 Dec 2002 23:30:00 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:49280 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S261506AbSLUE37> convert rfc822-to-8bit; Fri, 20 Dec 2002 23:29:59 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] scheduler tunables with contest - interactive_delta
Date: Sat, 21 Dec 2002 15:39:32 +1100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212211539.56815.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

osdl hardware, contest benchmark, 2.5.52-mm2 varying the interactive delta:

I've cut it down to the two loads that seem to be affected significantly. The 
other changes are subtle. id1 is interactive_delta = 1 and so on:

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
id1 [5]                 78.2    108     9       19      2.16
id2 [5]                 87.9    96      12      19      2.43
id3 [5]                 79.4    105     10      18      2.19
id4 [5]                 84.9    109     12      22      2.34
id5 [7]                 99.8    94      18      24      2.76
id6 [5]                 103.3   104     18      25      2.85
id7 [5]                 104.1   89      17      22      2.87

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
id1 [3]                 78.0    100     34      2       2.15
id2 [5]                 94.3    84      35      2       2.60
id3 [5]                 92.6    85      32      2       2.56
id4 [5]                 65.8    134     39      3       1.82
id5 [5]                 63.0    143     38      3       1.74
id6 [5]                 69.7    129     38      2       1.92
id7 [5]                 90.6    87      32      2       2.50

Seems like io_load likes lower interactive deltas (lower the better?) and 
mem_load likes high interactive_deltas (sweet spot 5).

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+A/CEF6dfvkL3i1gRAoM2AJ45DsfpltAWXNoaXIWmArMRdz2PIgCffpWP
A9gVU7M6NBIoGaFYQyx17wE=
=Mayt
-----END PGP SIGNATURE-----
