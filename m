Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTIHBHR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 21:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTIHBHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 21:07:13 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:11157 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261825AbTIHBHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 21:07:11 -0400
Date: Mon, 8 Sep 2003 03:06:55 +0200 (MEST)
Message-Id: <200309080106.h8816tVf024134@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.6.0 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.6.0 of perfctr, the Linux/x86 performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

This is the new stable series of perfctr. The main feature
changes since the previous stable series, perfctr-2.4, are:

* Added support for 2.6 kernels and 64-bit AMD64 kernels.
* Added support for AMD64, Pentium-M, and VIA Nehemiah processors.
* 64-bit AMD64 kernels work with 32-bit x86 user-space binaries.
* Much improved support for binary compatibility between different
  versions of the driver and user-space.
* Improved layout of counter state objects. Fewer cache lines are
  touched at counter suspend/resume/sample operations.
* More robust Pentium 4 support, especially for hyper-threaded P4s.
* Extended cascading should work on P4 Model 2 CPUs.
* The library contains data structures with event set and
  unit mask descriptions. (Complete except for P4.)
* Support for kernels older than 2.4.16 has been dropped.
	
Many people still use perfctr-2.4 because they also use PAPI
(http://icl.cs.utk.edu/projects/papi/). I've made a separate
patch available, patch-papi-2.3.4-perfctr-2.6, which applies
to the current PAPI release and allows it to work also with
perfctr-2.6.

Changes from 2.6.0-pre5:

Version 2.6.0, 2003-09-08
- The driver now kills a process' performance counters if the
  process migrates to a forbidden CPU. This ensures that unsafe
  changes to a process' CPU affinity mask don't break the driver,
  the hardware state, or other processes. (This is an issue on
  hyper-threaded P4s only.)
- A bug fix in perfctr-2.6.0-pre3 broke compiling the driver
  non-modular in modular 2.4 kernels. Corrected that problem.

/ Mikael Pettersson
