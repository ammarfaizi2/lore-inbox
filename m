Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVACSRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVACSRe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVACSOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:14:15 -0500
Received: from holomorphy.com ([207.189.100.168]:65180 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261523AbVACSJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 13:09:27 -0500
Date: Mon, 3 Jan 2005 10:09:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [3/8] kill gen_init_cpio.c printk() of size_t warning
Message-ID: <20050103180915.GK29332@holomorphy.com>
References: <20050103172013.GA29332@holomorphy.com> <20050103172303.GB29332@holomorphy.com> <20050103172615.GD29332@holomorphy.com> <20050103172839.GE29332@holomorphy.com> <41D9881B.4020000@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D9881B.4020000@pobox.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 12:59:55PM -0500, Jeff Garzik wrote:
> This removes whitespace in the process, violating the file's chosen 
> style (and typical lkml style).

I have no personal interest in the whitespace involved. The following
amended patch is likely to avoid inconsistencies with the rest of the
file regarding whitespace.


-- wli


Index: mm1-2.6.10/usr/gen_init_cpio.c
===================================================================
--- mm1-2.6.10.orig/usr/gen_init_cpio.c	2005-01-03 06:45:53.000000000 -0800
+++ mm1-2.6.10/usr/gen_init_cpio.c	2005-01-03 09:42:18.000000000 -0800
@@ -112,7 +112,7 @@
 		(long) gid,		/* gid */
 		1,			/* nlink */
 		(long) mtime,		/* mtime */
-		strlen(target) + 1,	/* filesize */
+		(unsigned)strlen(target) + 1,/* filesize */
 		3,			/* major */
 		1,			/* minor */
 		0,			/* rmajor */
