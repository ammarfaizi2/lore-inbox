Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751975AbWKFLJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbWKFLJE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 06:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752305AbWKFLJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 06:09:03 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:26701 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751975AbWKFLJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 06:09:02 -0500
Message-ID: <454F17AC.8010003@sw.ru>
Date: Mon, 06 Nov 2006 14:08:28 +0300
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Matthew Wilcox <willy@debian.org>
CC: Andy Whitcroft <apw@shadowen.org>, reiserfs-dev@namesys.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: [PATCH 2.6.19-rc4] Documentation: remount_fs() needs lock_kernel
References: <20061101235407.a92f94a5.akpm@osdl.org>	<454B5B56.4090307@shadowen.org> <20061103110210.08169843.akpm@osdl.org> <454F16ED.7060204@sw.ru>
In-Reply-To: <454F16ED.7060204@sw.ru>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:	Vasily Averin <vvs@sw.ru>

fixed long-lived typo: remount_fs() needs BKL

Signed-off-by:	Vasily Averin <vvs@sw.ru>

--- linux-2.6.19-rc4/Documentation/filesystems/Locking.umntlk	2006-11-02
13:25:04.000000000 +0300
+++ linux-2.6.19-rc4/Documentation/filesystems/Locking	2006-11-06
13:22:35.000000000 +0300
@@ -124,7 +124,7 @@ sync_fs:		no	no	read
 write_super_lockfs:	?
 unlockfs:		?
 statfs:			no	no	no
-remount_fs:		no	yes	maybe		(see below)
+remount_fs:		yes	yes	maybe		(see below)
 clear_inode:		no
 umount_begin:		yes	no	no
 show_options:		no				(vfsmount->sem)


