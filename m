Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWIKRhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWIKRhv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 13:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWIKRhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 13:37:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45963 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751286AbWIKRhu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 13:37:50 -0400
To: torvalds@osdl.org
Subject: [git pull] audit updates and fixes
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GMpjB-0002Ek-NP@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 11 Sep 2006 18:37:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Audit fixes and missing bits; compared to the last attempt there are two added
fixes from Amy...  Please, pull:
git://git.kernel.org/pub/scm/linux/kernel/git/viro/audit-current.git/ audit.b28


Shortlog:

Al Viro:
      syscall classes hookup for ppc and s390
      audit: more syscall classes added
      audit: AUDIT_PERM support

Amy Griffis:
      sanity check audit_buffer
      update audit rule change messages

Steve Grubb:
      fix ppid bug in 2.6.18 kernel

Diffstat:

 arch/i386/kernel/audit.c           |   28 +++++++++++++++
 arch/ia64/ia32/audit.c             |   26 ++++++++++++++
 arch/ia64/kernel/audit.c           |   35 +++++++++++++++++++
 arch/powerpc/kernel/Makefile       |    2 +
 arch/powerpc/kernel/audit.c        |   66 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/compat_audit.c |   38 +++++++++++++++++++++
 arch/s390/kernel/Makefile          |    4 +-
 arch/s390/kernel/audit.c           |   66 +++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/compat_audit.c    |   38 +++++++++++++++++++++
 arch/x86_64/ia32/audit.c           |   26 ++++++++++++++
 arch/x86_64/kernel/audit.c         |   35 +++++++++++++++++++
 include/asm-generic/audit_read.h   |    8 ++++
 include/asm-generic/audit_write.h  |   11 ++++++
 include/linux/audit.h              |   11 ++++++
 kernel/audit.c                     |    6 +++
 kernel/audit.h                     |    1 
 kernel/auditfilter.c               |   37 +++++++++++++++++---
 kernel/auditsc.c                   |   51 ++++++++++++++++++++++++++++
 18 files changed, 483 insertions(+), 6 deletions(-)
