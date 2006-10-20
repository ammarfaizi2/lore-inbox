Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946775AbWJTA7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946775AbWJTA7W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 20:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946774AbWJTA7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 20:59:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:61380 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1946772AbWJTA7U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 20:59:20 -0400
Date: Fri, 20 Oct 2006 01:59:17 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
Message-ID: <20061020005917.GY29920@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk> <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org> <20061018160609.GO29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180926380.3962@g5.osdl.org> <20061020005337.GV29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020005337.GV29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another preliminary: skbuff -> poll

---
 fs/compat.c                        |    1 +
 fs/gfs2/locking/dlm/plock.c        |    1 +
 include/linux/skbuff.h             |    1 -
 include/net/inet_connection_sock.h |    1 +
 include/net/udp.h                  |    1 +
 5 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/fs/compat.c b/fs/compat.c
index 0f06acb..1c3e9a6 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -46,6 +46,7 @@ #include <linux/personality.h>
 #include <linux/rwsem.h>
 #include <linux/tsacct_kern.h>
 #include <linux/highmem.h>
+#include <linux/poll.h>
 #include <linux/mm.h>
 
 #include <net/sock.h>		/* siocdevprivate_ioctl */
diff --git a/fs/gfs2/locking/dlm/plock.c b/fs/gfs2/locking/dlm/plock.c
index 7365aec..3799f19 100644
--- a/fs/gfs2/locking/dlm/plock.c
+++ b/fs/gfs2/locking/dlm/plock.c
@@ -8,6 +8,7 @@
 
 #include <linux/miscdevice.h>
 #include <linux/lock_dlm_plock.h>
+#include <linux/poll.h>
 
 #include "lock_dlm.h"
 
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c9c83ae..6aa8b11 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -23,7 +23,6 @@ #include <asm/atomic.h>
 #include <asm/types.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
-#include <linux/poll.h>
 #include <linux/net.h>
 #include <linux/textsearch.h>
 #include <net/checksum.h>
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 0bcf9f2..4167a24 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -18,6 +18,7 @@ #define _INET_CONNECTION_SOCK_H
 #include <linux/compiler.h>
 #include <linux/string.h>
 #include <linux/timer.h>
+#include <linux/poll.h>
 
 #include <net/inet_sock.h>
 #include <net/request_sock.h>
diff --git a/include/net/udp.h b/include/net/udp.h
index db0c05f..e287df5 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -27,6 +27,7 @@ #include <net/inet_sock.h>
 #include <net/sock.h>
 #include <net/snmp.h>
 #include <linux/seq_file.h>
+#include <linux/poll.h>
 
 #define UDP_HTABLE_SIZE		128
 
-- 
1.4.2.GIT

