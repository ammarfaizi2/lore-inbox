Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264205AbUEDCfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264205AbUEDCfk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 22:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264204AbUEDCfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 22:35:39 -0400
Received: from aun.it.uu.se ([130.238.12.36]:10977 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264211AbUEDCfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 22:35:23 -0400
Date: Tue, 4 May 2004 04:35:17 +0200 (MEST)
Message-Id: <200405040235.i442ZHqW025291@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.7.0 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.7.0 of perfctr, the Linux performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

perfctr-2.7.0 includes changes allowing it to coexist
safely with other drivers, mainly oprofile, using the
performance counter hardware.
These changes are extensive and preliminary.

perfctr-2.6.7 has also been released. It is a minor
update from perfctr-2.6.6, intended primarily to bring
updated kernel support to users of the stable branch.

Version 2.7.0, 2004-05-04
- Added a minimal performance counter resource management API
  to the kernel patch. This allows different drivers to claim
  the hardware as they need it, without risk of conflicts.
  Tested with the NMI watchdog, oprofile, and perfctr all
  loaded (but obviously not active) at the same time.
  Available for the 2.6.6-rc3 kernel.
- Significant rewrites in the x86 and x86_64 low-level drivers
  for the new API. Instead of reserving the hardware as long as
  the driver is loaded, it is reserved and released dynamically
  based on whether the high-level driver needs it or not.

Version 2.6.7, 2004-05-04
- Merged several x86_64-specific driver files with their x86
  counterparts, reducing the amount of duplicated code.
- Added textual descriptions to the library's P6 event sets.
  From Bryan O'Sullivan.
- Changed examples/signal/signal to count retired instructions
  instead of retired micro-operations on AMD K7. Needed to avoid
  a loop with the same instruction overflowing indefinitely.
- Updated kernel support: 2.6.6-rc3, 2.4.27-pre1, 2.4.22-1.2188.nptl
  (FC1), 2.4.21-9.0.1 (RHEL3), 2.4.20-31.9 (RH9).

/ Mikael Pettersson
