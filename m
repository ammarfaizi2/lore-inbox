Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWC1NJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWC1NJc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 08:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWC1NJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 08:09:31 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:14216 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751256AbWC1NJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 08:09:31 -0500
Date: Tue, 28 Mar 2006 07:09:06 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org
Subject: [PATCH] document security_inode_xattr_getsuffix()
Message-ID: <20060328130906.GC19243@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the security_inode_xattr_getsuffix() hook in
include/linux/security.h.  This is (currently) called only from
kernel/auditsc.c, and slipped in without a comment.

:100644 100644 3d8602e... 092740e... M	include/linux/security.h

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -386,6 +386,10 @@ struct swap_info_struct;
  * 	Check permission before removing the extended attribute
  * 	identified by @name for @dentry.
  * 	Return 0 if permission is granted.
+ * @inode_xattr_getsuffix:
+ * 	Return the extended attribute name suffix for the loaded LSM.
+ * 	Takes no arguments.
+ * 	Returns a const char*.
  * @inode_getsecurity:
  *	Copy the extended attribute representation of the security label 
  *	associated with @name for @inode into @buffer.  @buffer may be
