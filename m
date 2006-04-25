Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWDYA7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWDYA7o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 20:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWDYA7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 20:59:44 -0400
Received: from mx19.sac.fedex.com ([199.81.217.126]:19181 "EHLO
	mx19.sac.fedex.com") by vger.kernel.org with ESMTP id S1751318AbWDYA7n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 20:59:43 -0400
Date: Tue, 25 Apr 2006 08:59:42 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] enable X86_PC for HOTPLUG_CPU
Message-ID: <Pine.LNX.4.64.0604250854260.5533@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 04/25/2006
 08:59:39 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 04/25/2006
 08:59:41 AM,
	Serialize complete at 04/25/2006 08:59:41 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Here's a little 1 line patch to enable HOTPLUG_CPU for X86_PC. This is 
necessary to enable SUSPEND_SMP and SOFTWARE_SUSPEND under SMP. Need to 
put system in UP mode before suspend.


Thanks,
Jeff
[ jchua@fedex.com ]


--- linux/arch/i386/Kconfig.org	2006-04-25 00:57:23 +0800
+++ linux/arch/i386/Kconfig	2006-04-25 00:58:31 +0800
@@ -756,7 +756,7 @@
  config HOTPLUG_CPU
  	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
-	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER && !X86_PC
+	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER
  	---help---
  	  Say Y here to experiment with turning CPUs off and on.  CPUs
  	  can be controlled through /sys/devices/system/cpu.


