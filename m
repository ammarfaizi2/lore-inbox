Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbWHALMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbWHALMA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWHALGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:06:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58076 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932630AbWHALF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:05:29 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 5/33] i386 Kconfig: Add a range definition to config PHYSICAL_START
Date: Tue,  1 Aug 2006 05:03:20 -0600
Message-Id: <1154430232873-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernels physical start address must fall in the first 1GB on i386.
This just adds a small range definition to enforce that.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index daa75ce..062fa01 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -766,6 +766,7 @@ config PHYSICAL_START
 
 	default "0x1000000" if CRASH_DUMP
 	default "0x100000"
+	range 0x100000 0x37c00000
 	help
 	  This gives the physical address where the kernel is loaded. Normally
 	  for regular kernels this value is 0x100000 (1MB). But in the case
-- 
1.4.2.rc2.g5209e

