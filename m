Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVHBM7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVHBM7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 08:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVHBM7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 08:59:30 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:29655 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261505AbVHBM7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 08:59:01 -0400
From: Grant Coady <lkml@dodo.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc5 randconfig kernel build errors
Date: Tue, 02 Aug 2005 22:58:59 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <lrque1drc20ev6o6441mn918e753r7vmki@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Preliminary results, better sample (some hundreds) in a day or so.

2.6.13-rc5
~~~~~~~~~~
Done processing 70 random builds, from which:
###   6 .configs produced errors
###   4 .configs produced undefs
###  29 .configs produced warnings

# zcat result-report-error-abbrev.gz|cut -d: -f2-
arch/i386/mach-es7000/es7000.h:82: error: field `id' has incomplete type
arch/i386/mach-es7000/es7000.h:88: error: field `Header' has incomplete type
arch/i386/mach-es7000/es7000plat.c:154: error: `es7000_rename_gsi' undeclared (first use in this function)
arch/i386/mach-es7000/es7000plat.c:168: warning: implicit declaration of function `acpi_find_rsdp'
arch/i386/mach-es7000/es7000plat.c:170: error: dereferencing pointer to incomplete type
drivers/char/ipmi/ipmi_msghandler.c:1397: warning: `ipmb_file_read_proc' defined but not used
drivers/char/ipmi/ipmi_msghandler.c:1406: warning: `version_file_read_proc' defined but not used
drivers/char/ipmi/ipmi_msghandler.c:1416: warning: `stat_file_read_proc' defined but not used
drivers/mtd/maps/nettel.c:419: error: `ROOT_DEV' undeclared (first use in this function)
drivers/mtd/maps/nettel.c:419: warning: implicit declaration of function `MKDEV'
include/asm-i386/mach-default/mach_apic.h: At top level:
include/asm-i386/mach-default/mach_apic.h:100: error: dereferencing pointer to incomplete type
include/asm-i386/mach-default/mach_apic.h:109: error: `phys_cpu_present_map' undeclared (first use in this function)
include/asm-i386/mach-visws/do_timer.h:32: error: `i8259A_lock' undeclared (first use in this function)
sound/core/memalloc.c:658: error: `snd_mem_proc' undeclared (first use in this function)

Details: http://scatter.mine.nu/test/kernel/2.6.13-rc5/

Grant.

