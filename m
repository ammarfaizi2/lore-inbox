Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbTHZV15 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 17:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbTHZV15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 17:27:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:36499 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262846AbTHZV1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 17:27:55 -0400
Message-Id: <200308262127.h7QLRsg08273@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linstab@osdl.org
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [osdl-aim-7] 2.6.0-test4, -test4-mm1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Aug 2003 14:27:54 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All results: http://developer.osdl.org/cliffw/reaim/index.html

I am now running two workloads, new_dbase and compute:
The compute workload has much less IO, more system time.

On the 1 and 2 cpu machines, very little delta, test4 a little better:
1-CPU
STP id PLM# Kernel Name       Workfile  MaxJPM MaxUser Host     Change
278204 2070 2.6.0-test4-mm1   new_dbase 988.42   17      stp1-001 0.00
278000 2067 linux-2.6.0-test4 new_dbase 990.15   17      stp1-003 0.18

278205 2070 2.6.0-test4-mm1   compute   1011.76  17     stp1-003 0.00
278001 2067 linux-2.6.0-test4 compute   1019.36  17     stp1-000 0.75
2-CPU
278215 2070 2.6.0-test4-mm1   new_dbase 1325.86  22     stp2-000 0.00
278011 2067 linux-2.6.0-test4 new_dbase 1331.56  24     stp2-000 0.43

278216 2070 2.6.0-test4-mm1   compute   1511.41  26     stp2-001 0.00
278012 2067 linux-2.6.0-test4 compute   1535.87  26     stp2-001 1.62

Running on the 8-cpu machines, delta is larger:

STP id PLM# Kernel Name       Workfile  MaxJPM MaxUser Host     Change
278184 2070 2.6.0-test4-mm1   new_dbase 8203.60  136   stp8-001 0.00
277980 2067 linux-2.6.0-test4 new_dbase 8483.27  144   stp8-002 3.41

278186 2070 2.6.0-test4-mm1   compute   9601.96  160  stp8-003 0.00
277982 2067 linux-2.6.0-test4 compute   9432.60  160  stp8-000 -1.76

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
(3 runs each, average of all 6 reported runs repeated with workfile.compute)

cliffw


