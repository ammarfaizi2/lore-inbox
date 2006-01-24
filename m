Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWAXAin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWAXAin (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 19:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbWAXAin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 19:38:43 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:64919 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030238AbWAXAim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 19:38:42 -0500
Date: Mon, 23 Jan 2006 19:36:03 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 0/9] Shared ia32 syscall table
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Jeff Dike <jdike@addtoit.com>, Chuck Ebbert <76306.1226@compuserve.com>
Message-ID: <200601231938_MC3-1-B687-7C42@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series updates i386 and x86_64 so they share
the same ia32 syscall table.  UML already uses the i386
table and is updated to use the new shared table as well.

This series does not convert unistd.h.

Tested by building and booting UML, i386 and x86_64
(x86_64 was booted with 32-bit userspace.)

All three archs should work at all intermediate steps but
that was not tested.


00-description
	This file.

01_uml_rename_syscalls.patch
	Make UML compatible with to-be-renamed i386 syscalls.

02_i386_rename_syscalls.patch
	Rename some i386 syscalls so they match x86_64.

03_i386_add_new_table.patch
	Create new shared syscall table.

04_i386_shared_syscall.patch
	Convert i386 to using new table.

05_uml_shared_syscall.patch
	Convert UML to using new table.

06_x86_64_rename_syscalls.patch
	Rename some ia32 syscalls to make shared table possible.

07_x86_64_shared_syscall.patch
	Convert x86_64.

08_i386_remove_old_table.patch
	Remove old i386 syscall table.

09_x86_64_remove_old_table.patch
	Remove old x86_64 syscall table.

-- 
Chuck
