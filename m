Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268303AbUIKUYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268303AbUIKUYO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 16:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUIKUYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 16:24:13 -0400
Received: from hcc022004.bai.ne.jp ([210.171.22.4]:25993 "HELO
	tigger.internet.email.ne.jp") by vger.kernel.org with SMTP
	id S268303AbUIKUYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 16:24:07 -0400
Date: Sun, 12 Sep 2004 05:24:03 +0900 (JST)
Message-Id: <20040912.052403.730551818.takata@linux-m32r.org>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc1-mm4 0/6] [m32r] Update to fix compile errors
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I made patches to fix compile errors for m32r architecture port.
These patches are against 2.6.9-rc1-mm4.
Please apply them.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

[PATCH 2.6.9-rc1-mm4 1/6] [m32r] Update for profiling
  This patch is for profiling support. 
  profile_tick() is used instead of m32r_do_profile().

 arch/m32r/kernel/smp.c    |   10 ++++------
 arch/m32r/kernel/time.c   |    5 ++---
 include/asm-m32r/hw_irq.h |   33 +--------------------------------
 include/asm-m32r/ptrace.h |   14 ++++++++------
 4 files changed, 15 insertions(+), 47 deletions(-)

--
[PATCH 2.6.9-rc1-mm4 2/6] [m32r] Update zone_sizes_init()
  This patch upgrades zone_sizes_init() function.
  This patch is required because free_area_init_node()'s interface 
  has been changed.

 arch/m32r/mm/discontig.c |    2 +-
 arch/m32r/mm/init.c      |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

--
[PATCH 2.6.9-rc1-mm4 3/6] [m32r] Update to fix compile errors
  This patch updates code to fix compile errors, and so on.

 arch/m32r/kernel/Makefile  |    2 -
 arch/m32r/kernel/process.c |    5 +--
 arch/m32r/kernel/signal.c  |   68 +++++++++++++++++++++++++--------------------
 include/asm-m32r/hardirq.h |   18 -----------
 include/asm-m32r/page.h    |    4 +-
 5 files changed, 43 insertions(+), 54 deletions(-)

--
[PATCH 2.6.9-rc1-mm4 4/6] [m32r] Update uaccess.h
  This patch updates asm-m32r/uaccess.h.

 include/asm-m32r/uaccess.h |  349 +++++++++++++++++++++++++++++++++++++--------
 1 files changed, 290 insertions(+), 59 deletions(-)

--
[PATCH 2.6.9-rc1-mm4 5/6] [m32r] Update checksum functions
  This patch update checksum routines.
  And EXPORT_SYMBOL() is moved from m32r_ksyms.c to csum_partial_copy.c.

 arch/m32r/kernel/m32r_ksyms.c     |    2 
 arch/m32r/lib/csum_partial_copy.c |   39 ++--------
 include/asm-m32r/checksum.h       |  136 +++++++++++---------------------------
 3 files changed, 52 insertions(+), 125 deletions(-)

--
[PATCH 2.6.9-rc1-mm4 6/6] [m32r] Update CF/PCMCIA drivers
  This patch updates m32r-specific CF/PCMCIA drivers and 
  fixes compile errors.

 arch/m32r/drivers/m32r_cfc.c |   14 +++++++-------
 arch/m32r/drivers/m32r_pcc.c |   25 ++++++++++++++-----------
 2 files changed, 21 insertions(+), 18 deletions(-)
-----

Thank you.
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
