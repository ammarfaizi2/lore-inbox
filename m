Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbVKVW7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbVKVW7o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 17:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbVKVW7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 17:59:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63420 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030220AbVKVW7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 17:59:43 -0500
Date: Tue, 22 Nov 2005 15:00:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Cc: torvalds@osdl.org, ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc2
Message-Id: <20051122150002.26adf913.akpm@osdl.org>
In-Reply-To: <43829ED2.3050003@mnsu.edu>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
	<43829ED2.3050003@mnsu.edu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu> wrote:
>
>                 from fs/compat_ioctl.c:52,
>                  from arch/x86_64/ia32/ia32_ioctl.c:14:
> include/linux/ext3_fs.h: In function 'ext3_raw_inode':
> include/linux/ext3_fs.h:696: error: dereferencing pointer to incomplete type

This might help?

--- 25/include/linux/ext3_fs.h~ext3_fsh-needs-buffer_headh	Tue Nov 22 14:59:17 2005
+++ 25-akpm/include/linux/ext3_fs.h	Tue Nov 22 14:59:27 2005
@@ -19,7 +19,7 @@
 #include <linux/types.h>
 #include <linux/ext3_fs_i.h>
 #include <linux/ext3_fs_sb.h>
-
+#include <linux/buffer_head.h>
 
 struct statfs;
 
_

