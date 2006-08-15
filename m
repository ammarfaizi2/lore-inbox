Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965232AbWHOGuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbWHOGuX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 02:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbWHOGuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 02:50:23 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:48814 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965232AbWHOGuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 02:50:23 -0400
Date: Tue, 15 Aug 2006 08:48:40 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Howells <dhowells@redhat.com>
cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org#
Subject: Re: [RHEL5 PATCH 2/4] VFS: Make inode numbers 64-bits
In-Reply-To: <20060814211509.27190.51352.stgit@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.61.0608150844290.3819@yvahk01.tjqt.qr>
References: <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com>
 <20060814211509.27190.51352.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>This patch changes __kernel_ino_t to be "unsigned long long" on all

Why not "uint64_t" (or u64)?


>--- a/include/asm-mips/stat.h
>+++ b/include/asm-mips/stat.h
>@@ -18,7 +18,7 @@ #if (_MIPS_SIM == _MIPS_SIM_ABI32) || (_
> struct stat {
> 	unsigned	st_dev;
> 	long		st_pad1[3];		/* Reserved for network id */
>-	ino_t		st_ino;
>+	unsigned long	st_ino;
> 	mode_t		st_mode;
> 	nlink_t		st_nlink;
> 	uid_t		st_uid;

Will the kernel still fold 64-bit inums to 32-bit for stat[32]()?


Jan Engelhardt
-- 
