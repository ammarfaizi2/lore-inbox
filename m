Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSGHI2F>; Mon, 8 Jul 2002 04:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSGHI2E>; Mon, 8 Jul 2002 04:28:04 -0400
Received: from jalon.able.es ([212.97.163.2]:36075 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S312601AbSGHI2C>;
	Mon, 8 Jul 2002 04:28:02 -0400
Date: Mon, 8 Jul 2002 10:30:36 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCHSET] Linux 2.4.19-rc1-jam1
Message-ID: <20020708083036.GA4674@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

After some travel, here is a new version.
I was wating for another -rc or -aa, but anyways, here is 2.4.19-rc1-jam1:

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-rc1-jam1.tar.gz
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-rc1-jam1/

Current contents:

00-aa-rc1aa1.bz2
01-version.bz2

02-blk-dev-ram.bz2
	Fix typo.

03-nfs-attr-cache.bz2
	Fixes a bug in __nfs_refresh_inode() wrt to caches.
	Author: Trond Myklebust <trond.myklebust@fys.uio.no>

04-nfs-lockd.bz2
	Fix lockd oops.
	Author: Trond Myklebust <trond.myklebust@fys.uio.no>

10-config-nr_cpus.bz2
	Configure the max number of cpus at compile time (default was 32).
	Saves memory footprint for kernel (around 240Kb in 32->2).
	Author: Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>

11-mem-barriers.bz2
	Use specific machine level instructions for mb() for new
	processors (P3,P4,Athlon).
	Author: Zwane Mwaikambo <zwane@linux.realnet.co.sz>

12-polsel-fasthpath.bz2
	Speedup poll/select for the very common case when number of
	descriptors is small.
	Author:  Andi Kleen <ak@muc.de>

13-p2-split.bz2
	Split PII from PPro in processor selection.
	Change FOOF bug check compilation to a new flag.

14-gcc3-march.bz2
	Add support for gcc3 code generation flags for specific processors

20-sched-hints.bz2
	Hint-based scheduling on top of O1 scheduler.
	Authonr: Robert Love <rml@tech9.net>

30-shared-zlib.bz2
	Use only one copy of zlib for whole kernel.
	Authonr: David Woodhouse <dwmw2@infradead.org>
	URL: ftp://ftp.kernel.org/pub/linux/kernel/people/dwmw2/linux-2.4.19-shared-zlib.bz2

40-ide-10.bz2
	IDE update, version convert.10.
	Author: Andre Hedrick <andre@linux-ide.org>
	URL: http://www.linuxdiskcert.org/

41-severworks-ide.bz2
	Attempt to fix the ServerWorks problem sit certain disks and DMA.
	Author: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>

42-ide-cd-dma-3.bz2
	Make reading audio from IDE CDROMs use DMA.
	Author: Andrew Morton <akpm@zip.com.au>

50-e100-build.bz2
	Attepmt to fix duplicate install of e100.o module in -aa.

51-e100-2.0.30-k1.bz2
	Intel e100 driver update. -aa reverted to a previous one, due to some
	bug reports.
	Backported fron 2.5.

52-e1000-4.2.17-k1.bz2
	Intel e1000 gigE driver.
	Backported fron 2.5.

70-i2c-2.6.4-20020806.bz2
71-sensors-2.6.4-20020806.bz2
	LM-Sensors update to 2.6.4-cvs tree.
	URL: http://secure.netroedge.com/~lm78/

80-bproc-3.1.10.bz2
	Beowulf bproc SSI patches+pid allocation race fix.
	Author: Erik Arjan Hendriks <erik@hendriks.cx>
	URL: http://sourceforge.net/projects/bproc

81-export-task_nice.bz2
	Export task_nice() function for bproc.

90-make.bz2
	Makes INSTALL_PATH=/boot and default VGA mode = 6.


-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc1-jam1, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.7mdk)
