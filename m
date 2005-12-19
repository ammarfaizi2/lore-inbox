Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbVLSIRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbVLSIRX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 03:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbVLSIRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 03:17:22 -0500
Received: from colin.muc.de ([193.149.48.1]:25348 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030277AbVLSIRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 03:17:22 -0500
Date: 19 Dec 2005 09:17:14 +0100
Date: Mon, 19 Dec 2005 09:17:14 +0100
From: Andi Kleen <ak@muc.de>
To: discuss@x86-64.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Cc: lse-tech@projects.sourceforge.net
Subject: [ANNOUNCE] numactl-0.8 - user space NUMA policy interface released
Message-ID: <20051219081714.GA33604@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for the huge cc list. I will try to create a more focussed
list for numa policy user space in the future.

numactl-0.8 has been released. It consists of libnuma - which
is the prefered NUMA API to the NUMA policy system calls in the
Linux kernel -, numactl - a command line program for to 
run programs with a specific NUMA policy and various tools.

The biggest new features compared to 0.6 (0.7 was skipped) are lots
of bug fixes, PPC support and support for parsing numa distances
from sysfs.

It is backwards binary compatible to earlier libnuma releases. 

This version has everything I wanted to implement for numactl 1.0.
Unless some bad bugs come up it will be eventually renamed to
numactl-1.0

Please report all problems to ak@suse.de

ftp://ftp.suse.com/pub/people/ak/numa/numactl-0.8.tar.gz
36fb1f81d647d66cf9c119db3c215be4  numactl-0.8.tar.gz

Changes since 0.6.5: 

0.7-pre1

- add test/regress2 and some fixes to test programs
- Fix DSO relocation patch for global variables
- Change nodeset sizes back to be binary compatible with SLES9
- Cosmetic changes to manpages (pointed out by Eric S. Raymond) 
- Make numa_run_on_node etc. act on current thread only even on NPTL systems
  (Dinakar Guniguntala)
- Make numa_no_nodes / numa_all_nodes const (Werner Almesberger) 
- Fix up the warnings caused by above change
- Add numa_distance() on systems with ACPI
- remove some obsolete code
- add rdtsc for ppc64
- fix unsigned/unsigned long confusion in cpumasks (Matt Dobson)
- fix CPU_BYTES and rename CPU_WORDS to CPU_LONGS (Matt Dobson) 
- Print node distances in numactl

0.8
- hardend numactl command line parsing against bad arguments in some cases
- remove cpumask/nodemask confusion which has become a FAQ:
  --cpubind deprecated, added --cpunodebind and --physcpubind= options
  print both in --show, old cpumask kept for compatibility
- Fix --show problems
- various fixes for bugs noted by Mike Stroyan (thanks!)
- install set_mempolicy manpage
- various smaller fixes

-Andi Kleen
