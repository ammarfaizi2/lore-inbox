Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbTIOVcO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbTIOVcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:32:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:18381 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261634AbTIOVb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:31:59 -0400
Message-Id: <200309152131.h8FLVue10269@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org
Subject: [osdl-aim-7] 2.6.0-test5-mm2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Sep 2003 14:31:56 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here are results from OSDL's 
Scalable Test Platform. 

Performance falls off compared to -test5 on the
8-cpu machines. 

We are also experiencing some warnings on some tests:

Badness in as_dispatch_request at drivers/block/as-iosched.c:1241

And, we have three machines with processes hanging in 'D' state. 
More data as we get it.
cliffw

-----------------------------
Database workload

stp1 CPU machine

STP id PLM# Kernel Name                    Workfile   MaxJPM  MaxU Change Host 
   Options
Newest Kernel - Baseline for % change
279938 2144 2.6.0-test5-mm2                new_dbase  999.53   17  0.00 
stp1-001  profile=2
279569 2112 2.6.0-test5-mm1-fix11.0        new_dbase  990.94   17 -0.86 
stp1-003  profile=2
279455 2110 linux-2.6.0-test5              new_dbase  992.06   17 -0.75 
stp1-003  profile=2
stp 2-cpu 
279957 2144 2.6.0-test5-mm2                new_dbase  1306.85   22  0.00 
stp2-002  profile=2
279879 2142 2.6.0-test5-O1int20.1-2        new_dbase  1325.89   22  1.46 
stp2-003  profile=2
279474 2110 linux-2.6.0-test5              new_dbase  1337.11   22  2.32 
stp2-000  profile=2
stp 8-cpu
279931 2144 2.6.0-test5-mm2                new_dbase  8273.17  136  0.00 
stp8-003  profile=2 elevator=cfq
279929 2144 2.6.0-test5-mm2                new_dbase  8309.33  136  0.44 
stp8-003  profile=2 elevator=deadline
279927 2144 2.6.0-test5-mm2                new_dbase  8547.23  136  3.31 
stp8-000  profile=2
279448 2110 linux-2.6.0-test5              new_dbase  8812.21  144  6.52 
stp8-000  profile=2 elevator=cfq
279446 2110 linux-2.6.0-test5              new_dbase  8950.07  144  8.18 
stp8-002  profile=2 elevator=deadline
279444 2110 linux-2.6.0-test5              new_dbase  8785.24  144  6.19 
stp8-002  profile=2


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



