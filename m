Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWCQMiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWCQMiw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 07:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWCQMiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 07:38:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32517 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932168AbWCQMiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 07:38:51 -0500
Date: Fri, 17 Mar 2006 13:38:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Kirill Korotaev <dev@sw.ru>, Pavel Emelianov <xemul@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, James.Bottomley@HansenPartnership.com,
       linux-kernel@vger.kernel.org
Subject: -mm: sysrq patch breaks Voyager build
Message-ID: <20060317123849.GI3914@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus.patch causes 
the following compile error with CONFIG_X86_VOYAGER=y:

<--  snip  -->

...
  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o: In function `die_nmi': undefined reference to `smp_show_regs'
arch/i386/kernel/built-in.o: In function `die_nmi': undefined reference to `smp_nmi_call_function'
drivers/built-in.o: In function `sysrq_handle_showregs':sysrq.c:(.text+0x255ef): undefined reference to `smp_show_regs'
:sysrq.c:(.text+0x255f4): undefined reference to `smp_nmi_call_function'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

