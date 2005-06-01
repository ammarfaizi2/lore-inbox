Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVFADf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVFADf5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 23:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVFADf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 23:35:57 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:33672 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261214AbVFADfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 23:35:51 -0400
Subject: Re: [PATCH] Abstracted Priority Inheritance for RT
From: Steven Rostedt <rostedt@goodmis.org>
To: dwalker@mvista.com
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, sdietrich@mvista.com,
       inaky.perez-gonzalez@intel.com
In-Reply-To: <1117594659.3798.18.camel@dhcp153.mvista.com>
References: <1117594659.3798.18.camel@dhcp153.mvista.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 31 May 2005 23:35:29 -0400
Message-Id: <1117596929.4719.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel, 

I'll start taking a closer look at it tomorrow, but on first working
with it, you might want to change the following config on
PRIORITY_INHERITANCE.  At least for me on a "make oldconfig" the default
is usually "No" so I made the following change. It may even be wise to
just force it. I haven't taking a look yet, but would PREEMPT_RT work
without the inheritance?

-- Steve

--- lib/Kconfig.RT.orig	2005-05-31 23:29:41.000000000 -0400
+++ lib/Kconfig.RT	2005-05-31 23:29:56.000000000 -0400
@@ -88,7 +88,7 @@
 
 config PRIORITY_INHERITANCE
 	bool "Priority Inheritance"
-	default n if !PREEMPT_RT 
+	default y if PREEMPT_RT 
 	help
 	  This option enables system wide priority inheritance. It will
 	  enable a high priority waiting task to transfer it's priority




