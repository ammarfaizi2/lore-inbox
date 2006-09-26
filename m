Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWIZMiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWIZMiy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 08:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWIZMiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 08:38:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56482 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932068AbWIZMix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 08:38:53 -0400
Subject: [SYSFS] Add a declaration for fs_subsys
From: Steven Whitehouse <swhiteho@redhat.com>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 26 Sep 2006 13:45:11 +0100
Message-Id: <1159274711.11901.460.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The fs_subsys of sysfs does not have a declaration in any header
file, despite it being an exported symbol. This patch adds one so
that modules don't have to add their own. This is something used
by GFS2 (and already in the GFS2 tree) but I think can safely be
considered generic infrastructure.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 include/linux/fs.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1d3e601..48f9821 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1377,6 +1377,9 @@ extern struct subsystem fs_subsys;
 #define FLOCK_VERIFY_READ  1
 #define FLOCK_VERIFY_WRITE 2
 
+/* /sys/fs */
+extern struct subsystem fs_subsys;
+
 extern int locks_mandatory_locked(struct inode *);
 extern int locks_mandatory_area(int, struct inode *, struct file *, loff_t, size_t);
 
-- 
1.4.1



