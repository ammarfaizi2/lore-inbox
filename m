Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161364AbWG1Xfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161364AbWG1Xfg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 19:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161367AbWG1Xfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 19:35:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17059 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161364AbWG1Xff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 19:35:35 -0400
Date: Fri, 28 Jul 2006 19:35:33 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: use after free on ctrl-alt-del
Message-ID: <20060728233533.GC3217@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.18-rc2-git6, I see this when I hit ctrl-alt-del
on one of my machines (oddly on no others though).

BUG: unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
6b6b6b6b
*pde = 00000000
Oops: 0000 [#2]    <-- The other oopsen were from SATA, more bugs to follow.
eax: dfa4d49c ebx: 6b6b6b6b ecx: 00000000 edx: 00000001
esi: dfa4d49c edi: 00000000 ebp: c1858e7c esp: c1858e68
...
Call Trace:
show_stack_log_lvl+0x8a
show_registers
die
do_page_fault
error_code
blocking_notifier_call_chain
kernel_restart_prepare
kernek_restart
sys_reboot
syscall_call

		Dave

-- 
http://www.codemonkey.org.uk
