Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVASQEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVASQEA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 11:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVASQEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 11:04:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20871 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261763AbVASQDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 11:03:54 -0500
Date: Wed, 19 Jan 2005 11:03:28 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       jamal <hadi@cyberus.ca>
Subject: [PATCH][SELINUX] Add Netlink message types for the TC action code.
Message-ID: <Xine.LNX.4.44.0501191056520.29331-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Netlink message types related to the TC action code, 
allowing finer grained SELinux control of this.

Please apply.

Author: jamal <hadi@cyberus.ca>
Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>

---

 security/selinux/nlmsgtab.c |    3 +++
 1 files changed, 3 insertions(+)

--- 2610-bk1/security/selinux/nlmsgtab.c	2004/12/28 04:01:14	1.1
+++ 2610-bk1/security/selinux/nlmsgtab.c	2004/12/28 04:05:39
@@ -56,6 +56,9 @@
 	{ RTM_NEWTFILTER,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_DELTFILTER,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_GETTFILTER,	NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+	{ RTM_NEWACTION,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_DELACTION,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_GETACTION,	NETLINK_ROUTE_SOCKET__NLMSG_READ  },
 	{ RTM_NEWPREFIX,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_GETPREFIX,	NETLINK_ROUTE_SOCKET__NLMSG_READ  },
 	{ RTM_GETMULTICAST,	NETLINK_ROUTE_SOCKET__NLMSG_READ  },

