Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbTIJBuk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 21:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264469AbTIJBuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 21:50:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3460 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264371AbTIJBuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 21:50:39 -0400
Date: Wed, 10 Sep 2003 02:50:38 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>
Subject: [PATCH] interrupt.h needs kernel.h
Message-ID: <20030910015038.GP18654@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<linux/interrupt.h> uses barrier() but does not include <linux/kernel.h>.

--- include/linux/interrupt.h	8 Sep 2003 21:42:49 -0000	1.9
+++ include/linux/interrupt.h	8 Sep 2003 22:00:28 -0000	1.10
@@ -3,6 +3,7 @@
 #define _LINUX_INTERRUPT_H
 
 #include <linux/config.h>
+#include <linux/kernel.h>
 #include <linux/linkage.h>
 #include <linux/bitops.h>
 #include <linux/preempt.h>

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
