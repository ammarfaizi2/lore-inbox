Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWE0MXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWE0MXA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 08:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWE0MXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 08:23:00 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:41022 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751490AbWE0MW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 08:22:59 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc5 0/7] Kernel memory leak detector 0.2
Date: Sat, 27 May 2006 13:07:09 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060527120709.21451.3187.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new version (0.2) of the kernel memory leak detector based
on the tracing garbage collection technique. See the
Documentation/kmemleak.txt file for a more detailed description. The
patches are also available from
http://homepage.ntlworld.com/cmarinas/kmemleak/.

Thanks to all who contributed useful suggestions for these patches.

What's new in this version:

- cleaned up the code according to the suggestions on LKML
- implemented the buffering of allocation/freeing calls before
  kmemleak is properly initialised (many allocations would be missed
  without this feature)
- moved the pointer leaks information from /proc/memleak to
  /sys/kernel/debug/memleak (debugfs)
- the task stacks are not scanned by default because this can lead
  to many false negatives
- fixed the locking and tested on SMP (ARM)
- fixed other bugs

To do:

- better testing
- better support for modules (module static variables, new pointer
  aliases found in modules)
- test Ingo's suggestion on task stack scanning
- NUMA support

-- 
Catalin
