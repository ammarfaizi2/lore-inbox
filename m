Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316023AbSFDAiK>; Mon, 3 Jun 2002 20:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316047AbSFDAiK>; Mon, 3 Jun 2002 20:38:10 -0400
Received: from jalon.able.es ([212.97.163.2]:6878 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316023AbSFDAiJ>;
	Mon, 3 Jun 2002 20:38:09 -0400
Date: Tue, 4 Jun 2002 02:38:03 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCHSET] Linux 2.4.19-pre9-jam1
Message-ID: <20020604003803.GA1705@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Some changes in this release...
Andrea has merged the O1 scheduler, even with some updates, so half
the reason for may tree (updated VM and O1-sched) is gone (what is
good). So instead of cloning half of Andrea's tree, now -jam applies
on -aa. In fact, you even do not need to get -aa separately, it is
included as patch 00-aa-xxx.

You will notice that the ide-convert.10 patch has been dropped. The
highmem support in -aa IDE code made me to heasitate... And there are
new e100/e1000 drivers from 2.5.20.

Get it at:
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-pre9-jam1.tar.gz
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-pre9-jam1/

and enjoy (or burn your box).


Contents:

00-aa-pre9aa2.bz2
	-aa tree patch. You can omit this if you already have the matching
	tree.

01-version.bz2
	EXTRAVERSION

10-lowlatency-mini-rest.bz2
	Bits from mini-low-latency missing from aa tree. Still to decide
	if they are good or bad...
	Author: Andrew Morton <akpm@zip.com.au>
	URL: http://www.zip.com.au/~akpm/linux/schedlat.html#downloads

11-read-latency-2.bz2
	Minimal low-latency + read-latency changes.
	Author: Andrew Morton <akpm@zip.com.au>
	URL: http://www.zip.com.au/~akpm/linux/schedlat.html#downloads

12-irqbalance-B1.bz2
	Balance interrupts between cpus when APIC does not, especially
	in some P4 Xeon motherboards.
	Author: Ingo Molnar <mingo@elte.hu>

13-irqrate-A1.bz2
	IRQ-rate-limiting. Adds the dynamic hard-IRQ-limiting feature and fixes
	softirq performance.
	Author: Ingo Molnar <mingo@elte.hu>
	URL: http://redhat.com/~mingo/irqrate-patches/

14-smptimers-A0.bz2
    Scalable timer implementation. Lock per-CPU instead of global.
	Author: Ingo Molnar <mingo@elte.hu>
	URL: http://redhat.com/~mingo/scalable-timers-patches/

20-ext3-0.9.18.bz2
	Update to latest ext3.

30-shared-zlib.bz2
	Use only one copy of zlib for whole kernel.
	Authonr: David Woodhouse <dwmw2@infradead.org>
	URL: ftp://ftp.kernel.org/pub/linux/kernel/people/dwmw2/linux-2.4.19-shared-zlib.bz2

45-e100-2.0.30-k1.bz2
46-e1000-4.2.17-k1.bz2
	Intel drivers for 100 and 1000 Intel cards.
	Backported from 2.5.20.

70-i2c-2.6.4-cvs.bz2
71-sensors-2.6.4-cvs.bz2
	LM-Sensors update to 2.6.4-cvs tree.
	URL: http://www.netroedge.com/~lm78/

80-bproc-3.1.10.bz2
	Beowulf bproc SSI patches+pid allocation race fix.
	Author: Erik Arjan Hendriks <erik@hendriks.cx>
	URL: http://sourceforge.net/projects/bproc

81-export-task_nice.bz2
	Export task_nice() function for bproc.

90-make.bz2
	Makes INSTALL_PATH=/boot and default VGA mode = 6.

91-x86-model.bz2
	Split PII from PPro in processor selection.

92-gcc3-march.bz2
	Add support for gcc3 code generation flags for specific processors



-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre9-jam1 #1 SMP lun jun 3 19:59:12 CEST 2002 i686
