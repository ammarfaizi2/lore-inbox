Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVHBC60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVHBC60 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 22:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVHBC60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 22:58:26 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:25325 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261340AbVHBC6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 22:58:25 -0400
From: Grant Coady <lkml@dodo.com.au>
To: linux-kernel@vger.kernel.org
Subject: Report: 2.6.13-rc4-mm1: only 8 errors for 752 randconfig builds
Date: Tue, 02 Aug 2005 12:58:12 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <71mte1lpe4fvbdpas6pa2023qdephibv2d@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Automating random config kernel build testing, for 2.6.13-rc4-mm1:

Done processing 752 random builds, from which:
###   8 .configs produced errors
###  11 .configs produced undefs
###  52 .configs produced warnings

Abbreviated errors (first 2 lines/error):

grant@sempro:/opt/linux$ zcat result-report-error-abbrev.gz|cut -d: -f2-
arch/i386/kernel/cpu/transmeta.c: In function `init_transmeta':
arch/i386/kernel/cpu/transmeta.c:82: error: invalid lvalue in assignment
arch/i386/mach-es7000/es7000.h:82: error: field `id' has incomplete type
arch/i386/mach-es7000/es7000.h:88: error: field `Header' has incomplete type
arch/i386/mach-es7000/es7000plat.c: In function `parse_unisys_oem':
arch/i386/mach-es7000/es7000plat.c:154: error: `es7000_rename_gsi' undeclared (first use in this function)
drivers/char/ipmi/ipmi_msghandler.c:1397: warning: `ipmb_file_read_proc' defined but not used
drivers/char/ipmi/ipmi_msghandler.c:1406: warning: `version_file_read_proc' defined but not used
drivers/char/speakup/speakup.c: In function `speakup_bits':
drivers/char/speakup/speakup.c:1983: error: `pb_edit' undeclared (first use in this function)
drivers/mtd/maps/nettel.c: In function `nettel_init':
drivers/mtd/maps/nettel.c:419: error: `ROOT_DEV' undeclared (first use in this function)
include/asm-i386/mach-default/mach_apic.h:25: error: syntax error before "bitmap"
include/asm-i386/mach-default/mach_apic.h:26: warning: function declaration isn't a prototype
include/asm-i386/mach-visws/do_timer.h: In function `do_timer_overflow':
include/asm-i386/mach-visws/do_timer.h:32: error: `i8259A_lock' undeclared (first use in this function)
ipc/shm.c:174: error: `shmem_set_policy' undeclared here (not in a function)
ipc/shm.c:174: error: initializer element is not constant
sound/core/memalloc.c: In function `snd_mem_exit':
sound/core/memalloc.c:658: error: `snd_mem_proc' undeclared (first use in this function)

Further info, full error results, configs producing errors, etc from 
http://scatter.mine.nu/test/kernel/2.6.13-rc4-mm1/

Warnings recorded are those not deprecated, not #warning.
bzip2 tarballs of configs producing errors, undefs 22kB, warnings 86kB
A significant data reduction from the 28MB raw build results :)

Note: the report generator lists all faults for a particular source file, 
explains why summary above for errors shows warnings in first 2 lines.

Grant.

