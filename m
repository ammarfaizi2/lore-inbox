Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267698AbSLSXim>; Thu, 19 Dec 2002 18:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267699AbSLSXil>; Thu, 19 Dec 2002 18:38:41 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:14720 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S267698AbSLSXik> convert rfc822-to-8bit; Thu, 19 Dec 2002 18:38:40 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] scheduler tunables with contest - starvation_limit
Date: Fri, 20 Dec 2002 10:48:50 +1100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212201048.52690.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

osdl, contest, tunable - starvation limit on 2.5.52-mm1

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
sta_lim1000 [3]         39.7    179     0       0       1.10
sta_lim2000 [3]         39.7    181     0       0       1.10

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
sta_lim1000 [3]         36.7    194     0       0       1.01
sta_lim2000 [3]         37.0    194     0       0       1.02

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
sta_lim1000 [3]         48.2    146     10      47      1.33
sta_lim2000 [3]         45.6    157     7       37      1.26

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
sta_lim1000 [3]         57.9    158     1       10      1.60
sta_lim2000 [3]         54.3    153     1       10      1.50

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
sta_lim1000 [3]         72.9    125     1       8       2.01
sta_lim2000 [3]         67.6    130     1       9       1.87

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
sta_lim1000 [3]         89.6    98      12      19      2.47
sta_lim2000 [3]         79.9    104     11      19      2.21

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
sta_lim1000 [3]         68.1    124     8       19      1.88
sta_lim2000 [3]         68.5    116     9       20      1.89

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
sta_lim1000 [3]         49.9    151     5       6       1.38
sta_lim2000 [3]         50.9    150     5       6       1.41

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
sta_lim1000 [3]         43.8    167     0       9       1.21
sta_lim2000 [3]         43.5    168     0       9       1.20

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
sta_lim1000 [3]         106.8   77      36      2       2.95
sta_lim2000 [3]         112.4   73      36      2       3.10

Slight balance changes here. Most io things take slightly longer with lower 
starvation limit and mem_load takes less time.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+AlriF6dfvkL3i1gRAugYAJ93cYDhjqXjM4TIZsLF+zvUtMoJ5QCfS5EC
nIPWPR1JF0awLBCvL1uBzJ4=
=eU+1
-----END PGP SIGNATURE-----
