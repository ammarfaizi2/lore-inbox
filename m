Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262903AbSJAWhD>; Tue, 1 Oct 2002 18:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262902AbSJAWhC>; Tue, 1 Oct 2002 18:37:02 -0400
Received: from jalon.able.es ([212.97.163.2]:41418 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S262901AbSJAWgp>;
	Tue, 1 Oct 2002 18:36:45 -0400
Date: Wed, 2 Oct 2002 00:42:06 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCHSET] Linux 2.4.20-pre8-jam1
Message-ID: <20021001224206.GB3927@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

New release of this patchset. Some overview of updates:

- new base on Andrea's -pre8-aa1
- ext3-0.9.19
- netdrv-8
- bproc-3.2.1

and the usual ton of bugfixes collected from LKML.

Get it at:

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.20-pre8-jam1.tar.gz
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.20-pre8-jam1/

and enjoy !!.

Full contents:

10-highpage-init.bz2
	Cleanup one_highpage_init() as in 2.5.
	Author: Christoph Hellwig <hch@sgi.com>

11-memparam.bz2
	Fix mem=XXX kernel parameter when user gives a size bigger than what
	kernel autodetected (kill a previous change)
	Author: Adrian Bunk <bunk@fs.tum.de>,
			Leonardo Gomes Figueira <sabbath@planetarium.com.br>

12-clone-detached.bz2
	Fix a crash that can be caused by a CLONE_DETACHED thread.
	Author: Ingo Molnar <mingo@elte.hu>

13-self_exec_id.bz2
	Fix bad signaling between threads when ancestor dies.
	Author: Zeuner, Axel <Axel.Zeuner@partner.commerzbank.com>

14-nfs-resend.bz2
	Fix NFS stalls.
	Author: Trond Myklebust <trond.myklebust@fys.uio.no>

15-module-size-checks.bz2
	Fixes two minor bugs in kernel/module.c related with module size checks.
	Author: Peter Oberparleiter <oberpapr@softhome.net>

16-handle2dentry.bz2
	Factor out duplicated code for handle2dentry conversation.
	Author: Christoph Hellwig <hch@lst.de>

17-cache-detection.bz2
	Fix cache detection (trace cache) in P3s.
	Author: Dave Jones <davej@codemonkey.org.uk>

18-scsi-error-tmout.bz2
	Prevent endless loop in SCSI error handling.
	Author: Borzenkov Andrey <Andrej.Borsenkow@mow.siemens.ru>

19-per-cpu-stats.bz2
	Kill some per-cpu stats, not so often used.
	Author: William Lee Irwin III <wli@holomorphy.com>

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

31-ext3-0.9.19.bz2
	ext3 fs update.
	Author: Stephen Tweedie <sct@redhat.com>

32-netdrv-8.bz2
	Network driver subsystem update.
	Author: Jeff Garzik <jgarzik@pobox.com>

33-task_cpu.bz2
	Implement "task_cpu()" and "set_task_cpu()" as wrappers for reading and
	writing task->cpu. Optmize to dummy versions in UP.
	Additional changes for Andrea's tree.
	Author: Robert Love <rml@tech9.net>

34-sched-misc.bz2
	O1 scheduler miscellaneous updates.
	Author: Robert Love <rml@tech9.net>

40-sched-hints.bz2
	Hint-based scheduling on top of O1 scheduler.
	Author: Robert Love <rml@tech9.net>

41-corefile-name.bz2
	This patch will allow you to configure the way core files are named through
	the /proc filesystem.
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

70-i2c-2.6.6-cvs.bz2
71-sensors-2.6.6-cvs.bz2
	LM-Sensors update to 2.6.5-cvs tree.
	URL: http://secure.netroedge.com/~lm78/

72-i2c-build.bz2
	Add dmi_scan.o to export-objs.

75-bttv-0.7.97.bz2
76-bttv-doc-0.7.97.bz2
	BTTV updates.
	Author: Gerd Knorr <kraxel@bytesex.org>
	URL: http://bytesex.org/bttv/

80-bproc-3.2.1.bz2
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
Mandrake Linux release 9.0 (dolphin) for i586
Linux 2.4.20-pre8-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
