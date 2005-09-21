Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVIURZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVIURZx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVIURZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:25:53 -0400
Received: from nevyn.them.org ([66.93.172.17]:54459 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1751288AbVIURZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:25:52 -0400
Date: Wed, 21 Sep 2005 13:25:50 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Laurent Vivier <LaurentVivier@wanadoo.fr>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: PTRACE_SYSEMU numbering
Message-ID: <20050921172550.GA10332@nevyn.them.org>
Mail-Followup-To: Laurent Vivier <LaurentVivier@wanadoo.fr>,
	linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
	Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>,
	Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a bit of the PTRACE_SYSEMU patch, committed three weeks ago:

--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -20,6 +20,7 @@
 #define PTRACE_DETACH 0x11
 #define PTRACE_SYSCALL 24
+#define PTRACE_SYSEMU 31
 
 /* 0x4200-0x4300 are reserved for architecture-independent additions. */
 #define PTRACE_SETOPTIONS 0x4200

OK, I admit I could have made the comment clearer.  But can we fix this? 
You've added PTRACE_SYSEMU on top of PTRACE_GETFDPIC, which presumably will
mess up either debugging or UML on that architecture (if the latter were
ported).  That's exactly the problem we defined the 0x4200-0x4300 range
to prevent.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
