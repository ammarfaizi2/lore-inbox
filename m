Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268367AbUIGRJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268367AbUIGRJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 13:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268235AbUIGQx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:53:27 -0400
Received: from jade.spiritone.com ([216.99.193.136]:16007 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268054AbUIGQvx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:51:53 -0400
Date: Tue, 07 Sep 2004 09:51:48 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Stop reiser4 from turning itself on by default
Message-ID: <544430000.1094575908@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think we really want experimental filesystems on by default.

--- 2.6.9-rc1-mm4/fs/Kconfig.reiser4.old	2004-09-07 08:45:01.000000000 -0700
+++ 2.6.9-rc1-mm4/fs/Kconfig.reiser4	2004-09-07 08:45:20.000000000 -0700
@@ -1,7 +1,6 @@
 config REISER4_FS
 	tristate "Reiser4 (EXPERIMENTAL very fast general purpose filesystem)"
 	depends on EXPERIMENTAL && !4KSTACKS
-	default y
 	---help---
 	  Reiser4 is more than twice as fast for both reads and writes as
 	  ReiserFS V3, and is the fastest Linux filesystem, by a lot,

