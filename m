Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbVKQNa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVKQNa4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVKQNa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:30:56 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:37592 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750817AbVKQNaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:30:55 -0500
Date: Thu, 17 Nov 2005 19:00:57 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: ak@suse.de, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 10/10] kexec: increase max segment limit
Message-ID: <20051117133057.GN3981@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20051117131339.GD3981@in.ibm.com> <20051117131825.GE3981@in.ibm.com> <20051117132004.GF3981@in.ibm.com> <20051117132138.GG3981@in.ibm.com> <20051117132315.GH3981@in.ibm.com> <20051117132437.GI3981@in.ibm.com> <20051117132557.GJ3981@in.ibm.com> <20051117132659.GK3981@in.ibm.com> <20051117132850.GL3981@in.ibm.com> <20051117132944.GM3981@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117132944.GM3981@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o In some cases, the number of segments, on a kexec load, exceeds
  the existing cap of 8. This patch increases the KEXEC_SEGMENT_MAX
  limit from 8 to 16.

Signed-off-by:Rachita Kothiyal <rachita@in.ibm.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.15-rc1-1M-dynamic-root/include/linux/kexec.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/linux/kexec.h~kexec-increase-max-segment-limit include/linux/kexec.h
--- linux-2.6.15-rc1-1M-dynamic/include/linux/kexec.h~kexec-increase-max-segment-limit	2005-11-17 11:11:15.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/include/linux/kexec.h	2005-11-17 11:11:15.000000000 +0530
@@ -41,7 +41,7 @@ typedef unsigned long kimage_entry_t;
 #define IND_DONE         0x4
 #define IND_SOURCE       0x8
 
-#define KEXEC_SEGMENT_MAX 8
+#define KEXEC_SEGMENT_MAX 16
 struct kexec_segment {
 	void __user *buf;
 	size_t bufsz;
_
