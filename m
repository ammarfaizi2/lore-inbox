Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVCRVKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVCRVKd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 16:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVCRVKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 16:10:33 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:34904 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261372AbVCRVK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 16:10:27 -0500
X-IronPort-AV: i="3.91,102,1110175200"; 
   d="scan'208"; a="237570766:sNHT21440504"
Date: Fri, 18 Mar 2005 15:10:26 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.30-pre3] linux/fs.h: remove root_device_name declaration
Message-ID: <20050318211026.GA26112@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/fs.h has:
extern char root_device_name[];

but it's been declared static in init/do_mounts.c since March 2002.
gcc-4.0.0-0.32 from FC4-test1 errors out due to the static/non-static
mismatch.  Time to kill it from include/linux/fs.h.  

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

===== include/linux/fs.h 1.100 vs edited =====
--- 1.100/include/linux/fs.h	2005-02-07 12:30:59 -06:00
+++ edited/include/linux/fs.h	2005-03-18 15:00:48 -06:00
@@ -1559,7 +1559,6 @@
 unsigned long generate_cluster(kdev_t, int b[], int);
 unsigned long generate_cluster_swab32(kdev_t, int b[], int);
 extern kdev_t ROOT_DEV;
-extern char root_device_name[];
 
 
 extern void show_buffers(void);
