Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314885AbSGXAW7>; Tue, 23 Jul 2002 20:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315455AbSGXAW7>; Tue, 23 Jul 2002 20:22:59 -0400
Received: from jalon.able.es ([212.97.163.2]:58291 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S314885AbSGXAW5>;
	Tue, 23 Jul 2002 20:22:57 -0400
Date: Wed, 24 Jul 2002 02:26:02 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Todd Lyons <tlyons@mandrakesoft.com>
Subject: [PATCHSET] Linux 2.4.19-rc3-jam1
Message-ID: <20020724002602.GC3622@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

New release.

Main changes:
- updated to -rc3-aa1
- some changes to the processor selection config
- corefile names
- final sensors 2.6.4
- I have dropped the irqrate patch to the end of the list so you can skip
  it without disturbing the rest of patches of applying cleanly. I really
  do not trust it. It gave performance gains, but it hangs my box on rmmod.
  Some small bits of it have gone into -aa tree (expect better net latency ?)

URL:
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-rc3-jam1.tar.gz
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-rc3-jam1/

Enjoy !!

Detailed contents:

00-rc3-aa1.bz2
	-aa tree patch. You can omit this if you already have the matching tree.
	Author: Andrea Arcangeli <andrea@suse.de>
	URL: ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4

01-version.bz2
	EXTRAVERSION

10-init-task-union.bz2
	Kill one extra initializer for task struct (present in -aa and -ac, not
	-rc)

11-module-size-checks.bz2
	Fixes two minor bugs in kernel/module.c related with module size checks.
	Author: Peter Oberparleiter <oberpapr@softhome.net>

12-ide-probe-special.bz2
	ide-probe fix.
	Author: Erik Andersen <andersen@codepoet.org>

13-memparam.bz2
	Fix mem=XXX kernel parameter when user gives a size bigger than what
	kernel autodetected (kill a previous change)
	Author: Adrian Bunk <bunk@fs.tum.de>,
			Leonardo Gomes Figueira <sabbath@planetarium.com.br>

14-kbuild-dead-var.bz2
	CONFIG_DRM_AGP is neither defined nor used.
	Author: Keith Owens <kaos@ocs.com.au>

20-x86-foof-bug.bz2
	Introduce a config/feature _X86_ option for f00f, instead of have it
	depend implicitly on Mx86 flags.
	Author: Brian Gerst <bgerst@didntduck.org>

21-x86-split-group.bz2
	Group common options under just one config option, and make them a bit
	hierarchic.
	Split PII from PPro in processor selection.

22-mem-barriers.bz2
	Use specific machine level instructions for mb() for new
	processors (P3,P4,Athlon).
	Author: Zwane Mwaikambo <zwane@linux.realnet.co.sz>

23-gcc3-march.bz2
	Add support for gcc3 code generation flags for specific processors

24-config-nr_cpus.bz2
	Configure the max number of cpus at compile time (default was 32).
	Saves memory footprint for kernel (around 240Kb in 32->2).
	Author: Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>

30-smptimers-A0.bz2
	Scalable timer implementation. Lock per-CPU instead of global.
	Author: Ingo Molnar <mingo@elte.hu>
	URL: http://redhat.com/~mingo/scalable-timers-patches/

31-nr_requests.bz2
	Make Randy happy ;):
	"One thing I'd like to see -jam try is nr_requests = 256 in 
		drivers/block/ll_rw_blk.c."

40-sched-hints.bz2
	Hint-based scheduling on top of O1 scheduler.
	Authonr: Robert Love <rml@tech9.net>

41-shared-zlib.bz2
	Use only one copy of zlib for whole kernel.
	Authonr: David Woodhouse <dwmw2@infradead.org>
	URL: ftp://ftp.kernel.org/pub/linux/kernel/people/dwmw2/linux-2.4.19-shared-zlib.bz2

42-corefile-name.bz2
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

60-bttv-01-0.7.92.bz2
61-btaudio-01.bz2
	BTTV updates.
	Author: Gerd Knorr <kraxel@bytesex.org>
	URL: http://bytesex.org/bttv/

70-i2c-2.6.4.bz2
71-sensors-2.6.4.bz2
	LM-Sensors update to 2.6.4-final tree.
	URL: http://secure.netroedge.com/~lm78/

80-bproc-3.1.10.bz2
	Beowulf bproc SSI patches+pid allocation race fix.
	Author: Erik Arjan Hendriks <erik@hendriks.cx>
	URL: http://sourceforge.net/projects/bproc

81-export-task_nice.bz2
	Export task_nice() function for bproc.

90-make.bz2
	Makes INSTALL_PATH=/boot and default VGA mode = 6.

95-irqrate-A1.bz2
	IRQ-rate-limiting. Adds the dynamic hard-IRQ-limiting feature and fixes
	softirq performance.
	Author: Ingo Molnar <mingo@elte.hu>
	URL: http://redhat.com/~mingo/irqrate-patches/


-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc3-jam1, Mandrake Linux 9.0 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.10mdk)
