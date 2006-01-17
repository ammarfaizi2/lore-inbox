Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWAQPXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWAQPXe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 10:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWAQPXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 10:23:34 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:40748 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S1751249AbWAQPXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 10:23:33 -0500
Date: Wed, 18 Jan 2006 00:23:22 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 2.6.16-rc1] defines MMU mode specific syscalls as 'cond_syscall'
To: linux-kernel@vger.kernel.org
Message-id: <200601180023.22875.hyok.choi@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some syscalls are not linked in nommu mode. The MMU depending
syscalls are needed to be defined as 'cond_syscall'.

Signed-off-by: Hyok S. Choi <hyok.choi@samsung.com>
---

 kernel/sys_ni.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 17313b9..f5c2548 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -114,3 +114,14 @@ cond_syscall(sys32_sysctl);
 cond_syscall(ppc_rtas);
 cond_syscall(sys_spu_run);
 cond_syscall(sys_spu_create);
+
+/* mmu depending weak syscall entries */
+cond_syscall(sys_mprotect);
+cond_syscall(sys_msync);
+cond_syscall(sys_mlock);
+cond_syscall(sys_munlock);
+cond_syscall(sys_mlockall);
+cond_syscall(sys_munlockall);
+cond_syscall(sys_mincore);
+cond_syscall(sys_madvise);
+cond_syscall(sys_remap_file_pages);

