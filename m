Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVJ2FqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVJ2FqG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 01:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVJ2FqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 01:46:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33758 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751127AbVJ2FqF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 01:46:05 -0400
Date: Sat, 29 Oct 2005 06:46:03 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] missing include in infiniband
Message-ID: <20051029054603.GA7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	use of IS_ERR/PTR_ERR in infiniband/core/agent.c, without
a portable chain of includes pulling err.h (breaks on a bunch of
platforms).
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-base/drivers/infiniband/core/agent.h current/drivers/infiniband/core/agent.h
--- RC14-base/drivers/infiniband/core/agent.h	2005-10-28 22:35:58.000000000 -0400
+++ current/drivers/infiniband/core/agent.h	2005-10-29 01:25:34.000000000 -0400
@@ -39,6 +39,7 @@
 #ifndef __AGENT_H_
 #define __AGENT_H_
 
+#include <linux/err.h>
 #include <rdma/ib_mad.h>
 
 extern int ib_agent_port_open(struct ib_device *device, int port_num);
