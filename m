Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVKZTgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVKZTgU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 14:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVKZTgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 14:36:20 -0500
Received: from psmtp02.wxs.nl ([195.121.247.11]:18907 "EHLO psmtp02.wxs.nl")
	by vger.kernel.org with ESMTP id S1750703AbVKZTgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 14:36:19 -0500
Date: Sat, 26 Nov 2005 20:36:28 +0100
From: Stef van der Made <svdmade@planet.nl>
Subject: make oldconfig issues since 2.15-rc1-mm1
In-reply-to: <20051126192436.GC17663@elf.ucw.cz>
To: linux-kernel@vger.kernel.org
Message-id: <4388B93C.3070109@planet.nl>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b) Gecko/20050217
References: <20051103221402.GA28206@elf.ucw.cz>
 <1131057308.8523.92.camel@localhost.localdomain>
 <20051106204506.GH29901@elf.ucw.cz> <436F2BB2.3040008@cantab.net>
 <1131360232.8375.50.camel@localhost.localdomain>
 <20051126192436.GC17663@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gentleman,

Since the release of kernel 2.15-rc1-mm1 I can't compile the kernel 
anymore due to this issue while doing an make oldconfig.

When running make oldconfig I get this output:\

  HOSTCC  scripts/kconfig/zconf.tab.o
scripts/kconfig/zconf.tab.c: In function 'conf_parse':
scripts/kconfig/zconf.tab.c:1939: error: 'SYMBOL_CHECK_DONE' undeclared 
(first use in this function)
scripts/kconfig/zconf.tab.c:1939: error: (Each undeclared identifier is 
reported only once
scripts/kconfig/zconf.tab.c:1939: error: for each function it appears in.)
make[1]: *** [scripts/kconfig/zconf.tab.o] Error 1

When trying to compile the kernel using make but a non update .config 
file I get this output which might be related to the previous issue:

bash-2.05b$ make
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC      arch/i386/kernel/apm.o
In file included from include/linux/mm.h:4,
                 from include/linux/poll.h:11,
                 from arch/i386/kernel/apm.c:207:
include/linux/sched.h:256:16: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not 
defined
In file included from include/linux/poll.h:11,
                 from arch/i386/kernel/apm.c:207:
include/linux/mm.h:236:16: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not 
defined
include/linux/mm.h:828:16: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not 
defined
arch/i386/kernel/apm.c: In function 'apm_init':
arch/i386/kernel/apm.c:2293: error: 'pm_active' undeclared (first use in 
this function)
arch/i386/kernel/apm.c:2293: error: (Each undeclared identifier is 
reported only once
arch/i386/kernel/apm.c:2293: error: for each function it appears in.)
arch/i386/kernel/apm.c: In function 'apm_exit':
arch/i386/kernel/apm.c:2384: error: 'pm_active' undeclared (first use in 
this function)
make[1]: *** [arch/i386/kernel/apm.o] Error 1

I'm using gcc-4.0.2, and glibc-2.3.3

Thanks in advance for your help.

Stef

