Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319486AbSIMB5z>; Thu, 12 Sep 2002 21:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319484AbSIMB4t>; Thu, 12 Sep 2002 21:56:49 -0400
Received: from jalon.able.es ([212.97.163.2]:53137 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S319486AbSIMB4P>;
	Thu, 12 Sep 2002 21:56:15 -0400
Date: Fri, 13 Sep 2002 04:01:00 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCHSET] Linux 2.4.20-pre6-jam1
Message-ID: <20020913020100.GC1723@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Just some updates and a ton of bugfixes collected. At least it did not
blow up on my face.

Updates:
- pre6-aa0: this is not really a -aa, but pre5-aa2 rediffed.
- task_cpu, sched misc updates
- bproc 3.2

Enjoy at:
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.20-pre6-jam1.tar.gz

Perhaps some of the fixes (everything named 1X-xxxxx) are worthy and non
intrusive for next pre. Marcelo, would you mind taking a look at those ?

Current contents:

10-module-size-checks.bz2
	Fixes two minor bugs in kernel/module.c related with module size checks.
	Author: Peter Oberparleiter <oberpapr@softhome.net>

11-ide-probe-special.bz2
	ide-probe fix.
	Author: Erik Andersen <andersen@codepoet.org>

12-memparam.bz2
	Fix mem=XXX kernel parameter when user gives a size bigger than what
	kernel autodetected (kill a previous change)
	Author: Adrian Bunk <bunk@fs.tum.de>,
			Leonardo Gomes Figueira <sabbath@planetarium.com.br>

13-self_exec_id.bz2
	Fix bad signaling between threads when ancestor dies.
	Author: Zeuner, Axel <Axel.Zeuner@partner.commerzbank.com>

14-clone-detached.bz2
	Fix a crash that can be caused by a CLONE_DETACHED thread.
	Author: Ingo Molnar <mingo@elte.hu>
	
15-reiser-write.bz2
	ReiserFS file write bug fix for 2.4
	Author: Hans Reiser <reiser@namesys.com>

16-xfs-vs-sched.bz2
	Fix collision between new xfs and new scheduler.
	Author: Andrea Arcangeli <andrea@suse.de>

17-piix-tb.bz2
	Back port piix ide fixup to 2.4.19.
	Author: Hu Gang <hugang@soulinfo.com>

18-handle2dentry.bz2
	Factor out duplicated code for handle2dentry conversation.
	Author: Christoph Hellwig <hch@lst.de>

20-x86-split-group.bz2
	Group common options under just one config option, and make them a bit
	hierarchic.
	Split PII from PPro in processor selection.

21-mem-barriers.bz2
	Use specific machine level instructions for mb() for new
	processors (P3,P4,Athlon).
	Author: Zwane Mwaikambo <zwane@linux.realnet.co.sz>

22-gcc3-march.bz2
	Add support for gcc3 code generation flags for specific processors

23-config-nr_cpus.bz2
	Configure the max number of cpus at compile time (default was 32).
	Saves memory footprint for kernel (around 240Kb in 32->2).
	Author: Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>

30-smptimers-A0.bz2
	Scalable timer implementation. Lock per-CPU instead of global.
	Author: Ingo Molnar <mingo@elte.hu>
	URL: http://redhat.com/~mingo/scalable-timers-patches/

40-sched-hints.bz2
	Hint-based scheduling on top of O1 scheduler.
	Author: Robert Love <rml@tech9.net>

41-task_cpu.bz2
42-task_cpu-aa.bz2
	Implement "task_cpu()" and "set_task_cpu()" as wrappers for reading and
	writing task->cpu. Optmize to dummy versions in UP.
	-aa are additional changes for Andrea's tree.
	Author: Robert Love <rml@tech9.net>

43-sched-misc.bz2
	O1 scheduler miscellaneous updates.
	Author: Robert Love <rml@tech9.net>

45-corefile-name.bz2
	This patch will allow you to configure the way core files are named through
	the /proc filesystem You can specify patterns, e.g. "core.%p" to get pid
	appended, "%e.core" to get the name of the executable, or
	"/var/core/core.%h" to get all yor core files in /var/core and have the
	hostname appended.
	Author: Jes Rahbek Klinke <jrk@evalesco.com>

50-ide-10-partial.bz2
	IDE update, version convert.10. Partial because Promise driver is not
	merged and is probably not functional.
	Author: Andre Hedrick <andre@linux-ide.org>
	URL: http://www.linuxdiskcert.org/

51-severworks-ide.bz2
	Attempt to fix the ServerWorks problem sit certain disks and DMA.
	Author: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>

52-ide-cd-dma-3.bz2
	Make reading audio from IDE CDROMs use DMA.
	Author: Andrew Morton <akpm@zip.com.au>

60-bttv-0.7.97.bz2
61-bttv-doc-0.7.97.bz2
	BTTV updates.
	Author: Gerd Knorr <kraxel@bytesex.org>
	URL: http://bytesex.org/bttv/

70-i2c-2.6.5-cvs.bz2
71-sensors-2.6.5-cvs.bz2
	LM-Sensors update to 2.6.5-cvs tree.
	URL: http://secure.netroedge.com/~lm78/

72-i2c-build.bz2
	Add dmi_scan.o to export-objs.

80-bproc-3.2.0.bz2
	Beowulf bproc SSI patches.
	Author: Erik Arjan Hendriks <erik@hendriks.cx>
	URL: http://sourceforge.net/projects/bproc

81-export-task_nice.bz2
	Export task_nice() function for bproc.

90-make.bz2
	Makes INSTALL_PATH=/boot and default VGA mode = 6.


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.20-pre6-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
