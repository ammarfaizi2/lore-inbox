Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUENOI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUENOI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 10:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUENOI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 10:08:58 -0400
Received: from aun.it.uu.se ([130.238.12.36]:15336 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261169AbUENOI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 10:08:56 -0400
Date: Fri, 14 May 2004 16:08:49 +0200 (MEST)
Message-Id: <200405141408.i4EE8nOY018391@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][0/7] perfctr-2.7.2 for 2.6.6-mm2: summary
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches add perfctr-2.7.2, the performance-monitoring
counters driver, to kernel 2.6.6-mm2.

Based on comments from Andrew Morton, this version:
- switches to a new syscall instead of ioctl()s
- is split in several logically distinct parts

Summary: perfctr drives the performance counters in i386,
x86_64, and PowerPC processors. It supports virtualised
per-process counters with low-overhead user-space sampling,
and global-mode counters for system-wide measurements.

Perfctr has been in use for several years, at major HPC centres
and among various researchers, for application-level performance
measurements.

Documentation is limited at the moment. We're working on it.

Invariably, kernel hackers ask how perfctr differs from oprofile.
The short answer is that oprofile and perfctr are based on
different approaches with different goals. Perfctr is primarily
about allowing application developers to count performance-
related events in application code. Overflow interrupts can
be caught for profiling purposes, when the hardware and kernel
allow this, but the counts themselves are the primary objects
of interest. Oprofile primarily does interrupt-driven profiling
using various clock-like interrupt sources, one of which may
be the CPU's performance counters.

The set of patches that follow are:

1/7: core driver files and kernel changes
2/7: i386 driver and arch changes
3/7: x86_64 driver and arch changes
4/7: PowerPC driver and arch changes
5/7: driver for virtualised (per-process) performance counters
6/7: driver for global-mode (system-wide) performance counters
7/7: remaining small changes

/Mikael Pettersson
