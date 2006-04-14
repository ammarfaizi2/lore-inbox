Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWDNCmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWDNCmp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 22:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWDNCmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 22:42:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:32869 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751110AbWDNCmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 22:42:44 -0400
X-IronPort-AV: i="4.04,119,1144047600"; 
   d="scan'208"; a="23811233:sNHT16231299"
Subject: Re: [PATCH 8/8] IA64 various hugepage size - Modify kernel document
From: Zou Nan hai <nanhai.zou@intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-IA64 <linux-ia64@vger.kernel.org>, Tony <tony.luck@intel.com>,
       Kenneth W <kenneth.w.chen@intel.com>
In-Reply-To: <1144976261.5817.114.camel@linux-znh>
References: <1144974367.5817.39.camel@linux-znh>
	 <1144974667.5817.51.camel@linux-znh>  <1144974881.5817.59.camel@linux-znh>
	 <1144975292.5817.74.camel@linux-znh>  <1144975523.5817.84.camel@linux-znh>
	 <1144975746.5817.94.camel@linux-znh>  <1144975953.5817.102.camel@linux-znh>
	 <1144976261.5817.114.camel@linux-znh>
Content-Type: text/plain
Organization: 
Message-Id: <1144976418.5817.122.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 Apr 2006 09:00:18 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the kernel document about hugetlb

Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>

diff -Nraup a/Documentation/vm/hugetlbpage.txt b/Documentation/vm/hugetlbpage.txt
--- a/Documentation/vm/hugetlbpage.txt	2006-03-20 13:53:29.000000000 +0800
+++ b/Documentation/vm/hugetlbpage.txt	2006-04-12 06:13:50.000000000 +0800
@@ -68,9 +68,12 @@ If the user applications are going to re
 call, then it is required that system administrator mount a file system of
 type hugetlbfs:
 
-	mount none /mnt/huge -t hugetlbfs <uid=value> <gid=value> <mode=value>
+	mount none /mnt/huge -t hugetlbfs -o <uid=value> <gid=value> <mode=value>
 		 <size=value> <nr_inodes=value>
 
+on IA64 there is another mount option page_size=value which could
+mount a hugetlbfs with given huge page size;
+
 This command mounts a (pseudo) filesystem of type hugetlbfs on the directory
 /mnt/huge.  Any files created on /mnt/huge uses hugepages.  The uid and gid
 options sets the owner and group of the root of the file system.  By default



