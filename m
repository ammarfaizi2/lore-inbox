Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265543AbTFRVca (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 17:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265544AbTFRVca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 17:32:30 -0400
Received: from palrel10.hp.com ([156.153.255.245]:36040 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265543AbTFRVca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 17:32:30 -0400
Date: Wed, 18 Jun 2003 14:46:26 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200306182146.h5ILkQ0g021996@napali.hpl.hp.com>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: linux-kernel@vger.kernel.org
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

highmem.h uses stuff like page_address(), but fails to include
<linux/mm.h>.  Patch below fixes this.

Thanks,

	--david

diff -Nru a/include/linux/highmem.h b/include/linux/highmem.h
--- a/include/linux/highmem.h	Wed Jun 18 13:32:51 2003
+++ b/include/linux/highmem.h	Wed Jun 18 13:32:51 2003
@@ -3,6 +3,8 @@
 
 #include <linux/config.h>
 #include <linux/fs.h>
+#include <linux/mm.h>
+
 #include <asm/cacheflush.h>
 
 #ifdef CONFIG_HIGHMEM
