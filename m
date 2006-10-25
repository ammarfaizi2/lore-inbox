Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWJYP5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWJYP5R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 11:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWJYP5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 11:57:17 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:52723 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932206AbWJYP5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 11:57:17 -0400
From: Oliver Bock <o.bock@fh-wolfenbuettel.de>
To: linux-kernel@vger.kernel.org
Subject: BUG: warning at fs/inotify.c:171/set_dentry_child_flags()
Date: Wed, 25 Oct 2006 17:57:16 +0200
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610251757.16852.o.bock@fh-wolfenbuettel.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:dd33dd6c1d5f49fc970db4042b12446b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got this message six times in about 15 seconds.
It happened without mounting anything...

BUG: warning at fs/inotify.c:171/set_dentry_child_flags()
 [<c018b17c>] set_dentry_child_flags+0x10c/0x1a0
 [<c018b98a>] inotify_add_watch+0x11a/0x130
 [<c018c5c6>] sys_inotify_add_watch+0x166/0x190
 [<c018bcdf>] free_inotify_user_watch+0x4f/0x60
 [<c018b4ae>] put_inotify_watch+0x3e/0x70
 [<c018b573>] inotify_rm_wd+0x93/0xc0
 [<c018bda1>] sys_inotify_rm_watch+0x41/0x60
 [<c010317b>] syscall_call+0x7/0xb

Any idea whether that's something critical?
I'm using 2.6.18.1 (vanilla, i386 on AMD64) and ext3.
I ran fsck afterwards without any issues being reported...


Regards,
Oliver
