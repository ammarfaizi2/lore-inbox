Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263238AbTIVUjR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTIVUid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:38:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:26765 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263238AbTIVUiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:38:17 -0400
Message-Id: <200309222038.h8MKcFv15332@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5-mm3/mm4 - osdl-aim-7
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Sep 2003 13:38:15 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Short summary: we mostly rock.
- latest 2.4 is better at UP, worse at SMP vs 2.5
- mm3/4 and stock -test5 now very close for most loads,
  
Full data, including elevator comparisons, at:
http://developer.osdl.org/cliffw/reaim/index.html

stp1 CPU machine

STP id PLM# Kernel Name                MaxJPM  MaxU Change Host    Options
Newest Kernel - Baseline for % change - Workfile new_dbase
280322 2160 2.6.0-test5-mm4           990.48   17  0.00 stp1-000  profile=2
279455 2110 linux-2.6.0-test5         992.06   17  0.16 stp1-003  profile=2
280264 2159 patch-2.4.23-pre5         1067.19  18  7.74 stp1-003  profile=2

Newest Kernel - Baseline for % change - Workfile compute
280323 2160 2.6.0-test5-mm4           1014.33   17  0.00 stp1-001  profile=2
279456 2110 linux-2.6.0-test5         1017.43   17  0.31 stp1-000  profile=2
280265 2159 patch-2.4.23-pre5         1080.85   18  6.55 stp1-000  profile=2

stp2 CPU machine

STP id PLM# Kernel Name                MaxJPM  MaxU Change Host    Options
Newest Kernel - Baseline for % change - Workfile new_dbase
280349 2160 2.6.0-test5-mm4           1335.58   22  0.00 stp2-001  profile=2
279886 2112 linux-2.6.0-test5         1332.15   22 -0.25 stp2-001  profile=2
280291 2159 patch-2.4.23-pre5         1301.73   22 -2.53 stp2-001  profile=2


STP id PLM# Kernel Name                MaxJPM  MaxU Change Host    Options
Newest Kernel - Baseline for % change - Workfile compute
280350 2160 2.6.0-test5-mm4           1502.61   24  0.00 stp2-001  profile=2
279475 2110 linux-2.6.0-test5         1545.03   26  2.82 stp2-002  profile=2
280292 2159 patch-2.4.23-pre5         1485.33   24 -1.14 stp2-001  profile=2

stp4 CPU machine

STP id PLM# Kernel Name                     MaxJPM  MaxU Change Host    Options
Newest Kernel - Baseline for % change - Workfile new_dbase
280236 2155 2.6.0-test5-mm3           5365.30   92  0.00 stp4-000  profile=2
279883 2110 linux-2.6.0-test5         5406.68   92  0.77 stp4-000  profile=2

STP id PLM# Kernel Name                     MaxJPM  MaxU Change Host    Options
Newest Kernel - Baseline for % change - Workfile compute
280237 2155 2.6.0-test5-mm3           5208.20   88  0.00 stp4-000  profile=2
279493 2110 linux-2.6.0-test5         5175.28   88 -0.63 stp4-000  profile=2


stp8 CPU machine

STP id PLM# Kernel Name                     MaxJPM  MaxU Change Host    Options
Newest Kernel - Baseline for % change - Workfile new_dbase
280188 2155 2.6.0-test5-mm3           8317.55  136  0.00 stp8-000  profile=2
279444 2110 linux-2.6.0-test5         8785.24  144  5.62 stp8-002  profile=2
279826 2141 patch-2.4.23-pre4         6888.10  112 -17.18 stp8-000  profile=2


STP id PLM# Kernel Name                     MaxJPM  MaxU Change Host    Options
Newest Kernel - Baseline for % change - Workfile compute
280189 2155 2.6.0-test5-mm3           9745.39  160  0.00 stp8-000  profile=2
279445 2110 linux-2.6.0-test5         9758.11  160  0.13 stp8-002  profile=2
279057 2090 patch-2.4.23-pre3         9838.69  160  0.95 stp8-002  profile=2
------------------
cliffw
---------------
Detail on any run:
http://khack.osdl.org/stp/<STP id> 
Hardware details:
http://khack.osdl.org/stp/<STP id>/environment/machine_info
More results:
http://developer.osdl.org/cliffw/reaim/index.html
---------------

Code location:
bk://developer.osdl.org/osdl-aim-7
tarball:
http://sourceforge.net/projects/re-aim-7

Run parameters:

./reaim -s$CPU_COUNT -x -t -i$CPU_COUNT -f workfile.new_dbase -r3 -b 
-l./stp.config
./reaim -s$CPU_COUNT -q -t -i$CPU_COUNT -f workfile.new_dbase -r3 -b 
-l./stp.config
(3 runs each, average of all 6 reported) 

cliffw



