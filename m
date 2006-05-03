Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbWECDIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWECDIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 23:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWECDIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 23:08:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:22218 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965074AbWECDIu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 23:08:50 -0400
Date: Wed, 3 May 2006 04:08:49 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] symlink nesting level change
Message-ID: <20060503030849.GZ27946@ftp.linux.org.uk>
References: <14CFC56C96D8554AA0B8969DB825FEA0012B309B@chicken.machinevisionproducts.com> <44580CF2.7070602@tlinx.org> <e3966u$dje$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3966u$dje$1@terminus.zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 07:57:34PM -0700, H. Peter Anvin wrote:
> Followup to:  <44580CF2.7070602@tlinx.org>
> By author:    Linda Walsh <lkml@tlinx.org>
> In newsgroup: linux.dev.kernel
> > Is this what you are looking for?
> > include/linux/namei.h    MAX_NESTED_LINKS = 5
> > (used in fs/namei.c, where comment claims MAX_NESTING is equal to 8)
> 
> Wonder if it would make sense to make this a sysctl...

No.  It's way past time to bump it to 8.  Everyone had been warned - for
months now.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
--- a/include/linux/namei.h	2006-03-31 20:08:42.000000000 -0500
+++ b/include/linux/namei.h	2006-05-02 23:06:46.000000000 -0400
@@ -11,7 +11,7 @@
 	struct file *file;
 };
 
-enum { MAX_NESTED_LINKS = 5 };
+enum { MAX_NESTED_LINKS = 8 };
 
 struct nameidata {
 	struct dentry	*dentry;
