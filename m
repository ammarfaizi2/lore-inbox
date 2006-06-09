Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWFIRY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWFIRY3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWFIRY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:24:29 -0400
Received: from ns.protei.ru ([195.239.28.26]:48647 "EHLO mail.protei.ru")
	by vger.kernel.org with ESMTP id S1030193AbWFIRY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:24:29 -0400
Message-ID: <4489AEBE.2050809@protei.ru>
Date: Fri, 09 Jun 2006 21:24:14 +0400
From: Nickolay <nickolay@protei.ru>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.17-rc4 bugfix with initramfs
References: <20060409001127.GA101@oleg>
In-Reply-To: <20060409001127.GA101@oleg>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix double inclusion of ramfs-input.

Signed-off-by: Nickolay Vinogradov <nickolay@protei.ru>

--- /linux-2.6.17-rc4.orig.old/usr/Makefile 2006-06-08 
21:41:08.000000000 +0400
+++ linux-2.6.17/usr/Makefile 2006-06-09 21:16:53.000000000 +0400
@@ -21,8 +21,7 @@
$(CONFIG_INITRAMFS_SOURCE),-d)
ramfs-args := \
$(if $(CONFIG_INITRAMFS_ROOT_UID), -u $(CONFIG_INITRAMFS_ROOT_UID)) \
- $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID)) \
- $(ramfs-input)
+ $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID))

# .initramfs_data.cpio.gz.d is used to identify all files included
# in initramfs and to detect if any files are added/removed.


-- 
Nickolay Vinogradov
Russia, Saint Petersburg


