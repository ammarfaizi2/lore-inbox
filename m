Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWHGVKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWHGVKs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWHGVKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:10:48 -0400
Received: from xenotime.net ([66.160.160.81]:36058 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932294AbWHGVKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:10:47 -0400
Date: Mon, 7 Aug 2006 14:13:28 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, torvalds <torvalds@osdl.org>, ak@suse.de
Subject: [PATCH 0/9] Replace some ARCH_HAS_XYZZY
Message-Id: <20060807141328.4d9c2a72.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006 10:13:12 -0700 (PDT) Linus Torvalds wrote:

[snip]

> The whole "ARCH_HAS_XYZZY" is nothing but crap. It's totally unreadable, 
...
> WE SHOULD GET RID OF ARCH_HAS_XYZZY. It's a disease.

Using Kconfig symbols for some of them seems more appropriate to me,
i.e., moving the symbol definitions from "random" header files to
Kconfig files.  After all, these are just hidden config settings,
so use the Kconfig system and namespace for them.

This series of 9 patches converts:

__ARCH_HAS_DO_SOFTIRQ --> CONFIG_ARCH_DO_SOFTIRQ
ARCH_HAS_NMI_WATCHDOG --> CONFIG_ARCH_NMI_WATCHDOG.
ARCH_HAS_READ_CURRENT_TIMER --> CONFIG_ARCH_READ_CURRENT_TIMER.
ARCH_HAS_SCHED_WAKE_IDLE --> CONFIG_SCHED_SMT.
ARCH_HAS_SOCKET_TYPES --> CONFIG_ARCH_SOCKET_TYPES.
ARCH_HAS_VALID_PHYS_ADDR_RANGE --> CONFIG_ARCH_VALID_PHYS_ADDR_RANGE.
__ARCH_HAS_NO_PAGE_ZERO_MAPPED --> CONFIG_NO_PAGE_ZERO_MAPPED.
ARCH_HAS_POWER_INIT --> CONFIG_ACPI_POWER_INIT.

---
~Randy
