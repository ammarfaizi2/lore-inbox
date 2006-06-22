Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWFVSbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWFVSbq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWFVSbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:31:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4822 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932628AbWFVSbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:31:25 -0400
Date: Thu, 22 Jun 2006 14:30:50 -0400
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: fix console suspend compile failure.
Message-ID: <20060622183050.GA5604@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/power/main.c: In function 'suspend_prepare':
kernel/power/main.c:89: error: implicit declaration of function 'suspend_console'
kernel/power/main.c: In function 'suspend_finish':
kernel/power/main.c:137: error: implicit declaration of function 'resume_console'

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.17.noarch/kernel/power/main.c~	2006-06-22 13:45:57.827853000 -0400
+++ linux-2.6.17.noarch/kernel/power/main.c	2006-06-22 13:46:09.894764000 -0400
@@ -15,7 +15,7 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/pm.h>
-
+#include <linux/console.h>
 
 #include "power.h"
 

-- 
http://www.codemonkey.org.uk
