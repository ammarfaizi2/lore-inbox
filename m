Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272254AbTG1Bix (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272246AbTG1ABo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:44 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272895AbTG0XBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:35 -0400
Subject: 2.6.0-test2: fix ip_conntrack_core.h compile error
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-eJvosp5Zx64b7hyGSGxL"
Message-Id: <1059334945.578.7.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3.99 
Date: Sun, 27 Jul 2003 21:42:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eJvosp5Zx64b7hyGSGxL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Fix compile error in 2.6.0-test2 when Netfilter IP connection tracking
is enabled.


--=-eJvosp5Zx64b7hyGSGxL
Content-Disposition: attachment; filename=conntrack.path
Content-Type: text/plain; name=conntrack.path; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- include/linux/netfilter_ipv4/ip_conntrack_core.h	2003-07-27 21:38:40.805982872 +0200
+++ /usr/src/linux-2.6.0-test2-O10/include/linux/netfilter_ipv4/ip_conntrack_core.h	2003-07-27 21:36:26.799354976 +0200
@@ -1,5 +1,6 @@
 #ifndef _IP_CONNTRACK_CORE_H
 #define _IP_CONNTRACK_CORE_H
+#include <linux/netfilter.h>
 #include <linux/netfilter_ipv4/lockhelp.h>
 
 /* This header is used to share core functionality between the

--=-eJvosp5Zx64b7hyGSGxL--

