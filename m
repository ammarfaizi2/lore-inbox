Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbTHZTGi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 15:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbTHZTGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 15:06:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:52643 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261941AbTHZTGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 15:06:21 -0400
Date: Tue, 26 Aug 2003 11:55:36 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1151] New: 2.6.0 Test Kernel Fails to Build
Message-ID: <49040000.1061924136@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1151

           Summary: 2.6.0 Test Kernel Fails to Build
    Kernel Version: 2.6.0-test4
            Status: NEW
          Severity: normal
             Owner: ak@suse.de
         Submitter: eklinger@uci.edu


Distribution: Red Hat Enterprise AS Tyroon Beta
Hardware Environment: Dual AMD Opteron 64-bit
Software Environment: standard
Problem Description: Kernel fails to build

Steps to reproduce: Configure kernel and compile. The error is below:

arch/x86_64/kernel/built-in.o(.text+0xcd7f): In function `do_suspend_lowlevel':
: undefined reference to `save_processor_state'
arch/x86_64/kernel/built-in.o(.text+0xcd86): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_esp'
arch/x86_64/kernel/built-in.o(.text+0xcd8d): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_eax'
arch/x86_64/kernel/built-in.o(.text+0xcd94): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_ebx'
arch/x86_64/kernel/built-in.o(.text+0xcd9b): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_ecx'
arch/x86_64/kernel/built-in.o(.text+0xcda2): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_edx'
arch/x86_64/kernel/built-in.o(.text+0xcda9): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_ebp'
arch/x86_64/kernel/built-in.o(.text+0xcdb0): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_esi'
arch/x86_64/kernel/built-in.o(.text+0xcdb7): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_edi'
arch/x86_64/kernel/built-in.o(.text+0xcdbe): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_r08'
arch/x86_64/kernel/built-in.o(.text+0xcdc5): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_r09'
arch/x86_64/kernel/built-in.o(.text+0xcdcc): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_r10'
arch/x86_64/kernel/built-in.o(.text+0xcdd3): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_r11'
arch/x86_64/kernel/built-in.o(.text+0xcdda): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_r12'
arch/x86_64/kernel/built-in.o(.text+0xcde1): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_r13'
arch/x86_64/kernel/built-in.o(.text+0xcde8): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_r14'
arch/x86_64/kernel/built-in.o(.text+0xcdef): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_r15'
arch/x86_64/kernel/built-in.o(.text+0xcdf6): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_eflags'
arch/x86_64/kernel/built-in.o(.text+0xce4a): In function `do_suspend_lowlevel':
: undefined reference to `saved_context'
arch/x86_64/kernel/built-in.o(.text+0xce54): In function `do_suspend_lowlevel':
: undefined reference to `saved_context'
arch/x86_64/kernel/built-in.o(.text+0xce5e): In function `do_suspend_lowlevel':
: undefined reference to `saved_context'
arch/x86_64/kernel/built-in.o(.text+0xce68): In function `do_suspend_lowlevel':
: undefined reference to `saved_context'
arch/x86_64/kernel/built-in.o(.text+0xce71): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_eflags'
arch/x86_64/kernel/built-in.o(.text+0xce79): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_esp'
arch/x86_64/kernel/built-in.o(.text+0xce80): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_ebp'
arch/x86_64/kernel/built-in.o(.text+0xce87): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_eax'
arch/x86_64/kernel/built-in.o(.text+0xce8e): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_ebx'
arch/x86_64/kernel/built-in.o(.text+0xce95): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_ecx'
arch/x86_64/kernel/built-in.o(.text+0xce9c): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_edx'
arch/x86_64/kernel/built-in.o(.text+0xcea3): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_esi'
arch/x86_64/kernel/built-in.o(.text+0xceaa): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_edi'
arch/x86_64/kernel/built-in.o(.text+0xceb1): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_r08'
arch/x86_64/kernel/built-in.o(.text+0xceb8): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_r09'
arch/x86_64/kernel/built-in.o(.text+0xcebf): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_r10'
arch/x86_64/kernel/built-in.o(.text+0xcec6): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_r11'
arch/x86_64/kernel/built-in.o(.text+0xcecd): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_r12'
arch/x86_64/kernel/built-in.o(.text+0xced4): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_r13'
arch/x86_64/kernel/built-in.o(.text+0xcedb): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_r14'
arch/x86_64/kernel/built-in.o(.text+0xcee2): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_r15'
arch/x86_64/kernel/built-in.o(.text+0xceed): In function `do_suspend_lowlevel':
: undefined reference to `restore_processor_state'
make: *** [.tmp_vmlinux1] Error 1


