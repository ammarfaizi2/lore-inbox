Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbUKCVY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbUKCVY2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUKCVXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:23:46 -0500
Received: from main.gmane.org ([80.91.229.2]:49551 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261890AbUKCVVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:21:41 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Brett Russ <russb@emc.com>
Subject: [PATCH 2.6.10-rc1] kobject_uevent: fix compile error for send_uevent()
 stub
Date: Wed, 03 Nov 2004 16:11:47 -0500
Message-ID: <cmbhir$kng$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 168.159.32.130
User-Agent: Mozilla Thunderbird 0.8 (X11/20041025)
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found when attempting compile of fresh linux-2.5 bk with CONFIG_HOTPLUG 
on but CONFIG_KOBJECT_UEVENT off.  Stub declaration didn't match 
implementation of send_uevent().

Signed-off-by: Brett Russ <russb@emc.com>


--- linux-2.5/lib/kobject_uevent.c  2004-11-03 14:32:49.000000000 -0500
+++ linux/lib/kobject_uevent.c  2004-11-03 15:59:06.000000000 -0500
@@ -168,7 +168,7 @@

  #else
  static inline int send_uevent(const char *signal, const char *obj,
-                             const void *buf, int buflen, int gfp_mask)
+                             char **envp, int gfp_mask)
  {
         return 0;
  }

