Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVBKGvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVBKGvj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 01:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVBKGvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 01:51:38 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:65177 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262198AbVBKGvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 01:51:36 -0500
Date: Fri, 11 Feb 2005 07:50:43 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Update panic() comment
Message-ID: <20050211065043.GA2701@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Update panic() comment

panic() doesn't flush the filesystem cache anymore. The comment above the
function still claims it does.

Thanks,
Heiko

diff -urN a/kernel/panic.c b/kernel/panic.c
--- a/kernel/panic.c	Fri Feb 11 07:41:57 2005
+++ b/kernel/panic.c	Fri Feb 11 07:42:08 2005
@@ -49,8 +49,7 @@
  *	panic - halt the system
  *	@fmt: The text string to print
  *
- *	Display a message, then perform cleanups. Functions in the panic
- *	notifier list are called after the filesystem cache is flushed (when possible).
+ *	Display a message, then perform cleanups.
  *
  *	This function never returns.
  */
