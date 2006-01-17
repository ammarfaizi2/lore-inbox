Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWAQT62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWAQT62 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWAQT62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:58:28 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:38292 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964780AbWAQT61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:58:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gnWO1zJvhTzXXfH9mqsAeKPfttpibvmLirqfJ+UsEzouc73d0kN1wUNQIJqUusj+Cyv1SQo8isYRVJVSZ1OPY+Zgt52UIS1vh77giN6WhRW1QGryh/gZz4zQzCzPyOiAl7xGrm3UcWmHkYfvbwHo69BmGDx2NHG4vIqvCvRllDk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] TIPC: add Kconfig help text
Date: Tue, 17 Jan 2006 20:58:31 +0100
User-Agent: KMail/1.9
Cc: Per Liden <per.liden@nospam.ericsson.com>,
       Per Liden <per.liden@ericsson.com>,
       Jon Maloy <jon.maloy@nospam.ericsson.com>,
       Jon Maloy <jon.maloy@ericsson.com>,
       Allan Stephens <allan.stephens@nospam.windriver.com>,
       Allan Stephens <allan.stephens@windriver.com>,
       tipc-discussion@lists.sourceforge.net,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601172058.31503.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A new option such as TIPC should have a clear help text (as should any 
option for that matter) so users have a chance of determining if they 
want the option enabled or not without having to do extensive online 
searches.
Since this is likely to puzzle a lot of people doing "make oldconfig" 
with 2.6.16 using their old 2.6.15 .config I think the patch below (or 
a similar one) should go in before 2.6.16 is released.

Please consider merging.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 net/tipc/Kconfig |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

--- linux-2.6.16-rc1-orig/net/tipc/Kconfig	2006-01-17 19:14:24.000000000 +0100
+++ linux-2.6.16-rc1/net/tipc/Kconfig	2006-01-17 19:30:13.000000000 +0100
@@ -8,7 +8,10 @@
 config TIPC
 	tristate "The TIPC Protocol (EXPERIMENTAL)"
 	---help---
-	  TBD.
+	  The Transparent Inter Process Communication (TIPC) protocol is a
+	  protocol for intra cluster communication.
+	  Unless you are building a cluster using TIPC you probably have no
+	  use for this.
 
 	  This protocol support is also available as a module ( = code which
 	  can be inserted in and removed from the running kernel whenever you
@@ -23,8 +26,8 @@
 	default n
 	help
 	  Saying Y here will open some advanced configuration
-          for TIPC. Most users do not need to bother, so if
-          unsure, just say N.
+          for TIPC. Most users do not need to bother, so if unsure,
+	  just say N.
 
 config TIPC_ZONES
 	int "Maximum number of zones in network"



