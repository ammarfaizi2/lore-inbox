Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbTINJgr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 05:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbTINJgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 05:36:47 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:38878
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262343AbTINJgj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 05:36:39 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] reaim 2x,4x,8x with various SMP balancing patches
Date: Sun, 14 Sep 2003 19:44:10 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200309141944.45097.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

With the help of the OSDL hardware I've thrown a bootload of reaim benchmarks 
at these various patches because of the confusion regarding their usefulness. 
2.6.0-test5 is the baseline, and the 3 unique patches CMT,A3,BT were added by 
themselves and all together to 2.6.0-test5 for comparison. Finally the full 
2.6.0-test5-mm1 patch was compared. The A3 patch was modified slightly to 
overcome the one minor magnitude error for fairness. Looking at the url for 
each benchmark and examining the "Graph - Jobs per minute" is useful to 
assess where the performance hovers. 


Legend

260t5 - vanilla 2.6.0-test5
CMT - sched-CAN_MIGRATE_TASK-fix.patch
A3 - sched-2.6.0-test2-mm2-A3.patch
BT - sched-balance-tuning.patch
all - CMT + A3 + BT
mm1 - 2.6.0-test5-mm1


2 CPU:

Kernel	Throughput	URL
260t5	1337.11		http://khack.osdl.org/stp/279474/
CMT	1321.92		http://khack.osdl.org/stp/279796/
A3	1304.82		http://khack.osdl.org/stp/279799
BT	1326.27		http://khack.osdl.org/stp/279802
All	1337.79		http://khack.osdl.org/stp/279805/
mm1	1316.95		http://khack.osdl.org/stp/279588/


4 CPU:

Kernel	Throughput	URL
260t5	5406.68		http://khack.osdl.org/stp/279883
CMT
A3	5099.14		http://khack.osdl.org/stp/279800
BT	5721.79		http://khack.osdl.org/stp/279803
All	4919.36		http://khack.osdl.org/stp/279806
mm1	5360.32		http://khack.osdl.org/stp/279887


8 CPU:

Kernel	Throughput	URL
260t5	8812.21		http://khack.osdl.org/stp/279448/
CMT	8794.14		http://khack.osdl.org/stp/279798
A3	7084.15		http://khack.osdl.org/stp/279801
BT	8615.13		http://khack.osdl.org/stp/279804
All	7629.14		http://khack.osdl.org/stp/279919
mm1	8478.10		http://khack.osdl.org/stp/279562/


4xCMT seemed to not successfully finish.

In summary, it appears that all the patches cause detriment to performance, 
except the combination of BT with 4 cpus. The A3 patch is particularly 
detrimental, but it is reassuring to see that the extra patches in mm1 (which 
includes O1int patches) recover a lot of that performance, even with the 
other balancing patches.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/ZDhtZUg7+tp6mRURAmJAAJ4zMYHg7iSuVHi7SpiS5hkmoaQl9wCggrcB
SSH6dbJthgABVnEIn4K/z3M=
=Jz7G
-----END PGP SIGNATURE-----

