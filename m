Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270777AbTGVN5X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 09:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270829AbTGVN5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 09:57:22 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:61057 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S270777AbTGVN4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 09:56:46 -0400
Message-ID: <F341E03C8ED6D311805E00902761278C0D2A2BE2@xfc04.fc.hp.com>
From: "MIYOSHI,DENNIS (HP-Loveland,ex1)" <dennis.miyoshi@hp.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Build fails for ia64 with linux-2.6.0-test1-bk2 with missing file
	.
Date: Tue, 22 Jul 2003 10:11:46 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi;
 
I was not sure who to send this too, so I am following the directions in the
REPORTING-BUGS files.
 
Thanks in advance.
 
Dennis E. Miyoshi, PE
Hendrix Release Manager
Hewlett-Packard Company
825 14th Street, S.W.,  MS E-200
Loveland, CO  80537
(970) 898-6110
 
 
BUG REPORT
Build fails for ia64 with linux-2.6.0-test1-bk2 with missing file.
 
Description of problem:
1.  Pulled 2.6.0-test1
2.  Pulled 2.6.0-test1-bk2 patch
3.  Applied bk2 patch to 2.6.0-test1
4.  make menuconfig
5.  make compressed modules
 
Failed with the following:
   kernel/profile.c:11:26: asm/sections.h:  No such file or directory
   kernel/profile.c: In function `profile_init':
   kernel/profile.c:38: `_etext' undeclared (first use in this function)
   kernel/profile.c:38: (Each undeclared identifier is reported only once
   kernel/profile.c:38: for each function it appears in.)
   kernel/profile.c:38: `_stext' undeclared (first use in this function)
   make[1]: *** [kernel/profile.o] Error 1
   make: *** [kernel] Error 2
 
Proposed Solution:
I believe that the include/asm/sections.h files needs to be linked to one of
the incude/asm-arch/sections.h files.
 
Keywords:
ia64, build, sections.h
 
Processor Information:
processor  : 0
vendor     : GenuineIntel
arch       : IA-64
family     : Itanium 2
model      : 0
revision   : 7
archrev    : 0
features   : branchlong
cpu number : 0
cpu regs   : 4
cpu MHz    : 900.000000
itc MHz    : 900.000000
BogoMIPS   : 1346.37
