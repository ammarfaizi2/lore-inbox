Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTENL0D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 07:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTENL0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 07:26:03 -0400
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:65216 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S261500AbTENL0B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 07:26:01 -0400
Date: Wed, 14 May 2003 13:38:48 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.68-mm2: Memory & swap issues ?
Message-Id: <20030514133848.74b8736f.philippe.gramoulle@mmania.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.11claws141 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I just wanted to know if there had been some issues regarding memory and/or swap ?

I've been running 2.5.68-mm2 for about 3 weeks now:

$ uptime 
 13:14:43 up 21 days,  2:02, 23 users,  load average: 2.23, 2.25, 2.26

So far, my 600 Mb swap partition is almost full as shown on the following graphs:

http://philou.org/2.5.68-mm2/graph.php.html

dark yellow color is for _remaining_ swap memory.

$ free

             total       used       free     shared    buffers     cached
Mem:        514452     485336      29116          0       7812      66664
-/+ buffers/cache:     410860     103592
Swap:       618460     603320      15140

$ cat /proc/meminfo

MemTotal:       514452 kB
MemFree:         20720 kB
Buffers:          8200 kB
Cached:          74148 kB
SwapCached:      38488 kB
Active:         412740 kB
Inactive:        12824 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       514452 kB
LowFree:         20720 kB
SwapTotal:      618460 kB
SwapFree:        15156 kB
Dirty:            7228 kB
Writeback:           0 kB
Mapped:         337808 kB
Slab:            57520 kB
Committed_AS:  1023568 kB
PageTables:       2804 kB
VmallocTotal:   516040 kB
VmallocUsed:      3308 kB
VmallocChunk:   512688 kB


Usage is typical desktop with many eterms, Opera, mozilla, Pan, Sylpheed , postfix, Enlightenement, xmms etc.. opened all the time.
Hardware is DELL MT530 ( 1.5Ghz XEON SMP,512 Mo RAM, Debian Unstable , Dual heads with Nvidia opensource nv driver)

Should i look into memory leaks with those programs instead ?

Thanks,

Philippe
