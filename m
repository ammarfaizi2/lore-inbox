Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbUBUGPM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 01:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbUBUGPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 01:15:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:51086 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261513AbUBUGPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 01:15:08 -0500
Date: Fri, 20 Feb 2004 22:15:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Joe Thornber <thornber@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 2/6] dm: remove v1 ioctl interface
Message-Id: <20040220221525.115dc972.akpm@osdl.org>
In-Reply-To: <20040220153436.GP27549@reti>
References: <20040220153145.GN27549@reti>
	<20040220153436.GP27549@reti>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber <thornber@redhat.com> wrote:
>
>  Remove the version-1 ioctl interface.

This breaks the build on 64-bit machines.




 include/linux/compat_ioctl.h |    7 -------
 1 files changed, 7 deletions(-)

diff -puN include/linux/compat_ioctl.h~dm-02-compat_ioctl-fix include/linux/compat_ioctl.h
--- 25-power4/include/linux/compat_ioctl.h~dm-02-compat_ioctl-fix	2004-02-20 22:12:40.000000000 -0800
+++ 25-power4-akpm/include/linux/compat_ioctl.h	2004-02-20 22:12:40.000000000 -0800
@@ -140,13 +140,6 @@ COMPATIBLE_IOCTL(DM_VERSION)
 COMPATIBLE_IOCTL(DM_REMOVE_ALL)
 COMPATIBLE_IOCTL(DM_DEV_CREATE)
 COMPATIBLE_IOCTL(DM_DEV_REMOVE)
-COMPATIBLE_IOCTL(DM_DEV_RELOAD)
-COMPATIBLE_IOCTL(DM_DEV_SUSPEND)
-COMPATIBLE_IOCTL(DM_DEV_RENAME)
-COMPATIBLE_IOCTL(DM_DEV_DEPS)
-COMPATIBLE_IOCTL(DM_DEV_STATUS)
-COMPATIBLE_IOCTL(DM_TARGET_STATUS)
-COMPATIBLE_IOCTL(DM_TARGET_WAIT)
 #endif
 /* Big K */
 COMPATIBLE_IOCTL(PIO_FONT)

_

