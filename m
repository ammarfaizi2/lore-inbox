Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWHAIXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWHAIXk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 04:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWHAIXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 04:23:40 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:37735 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750713AbWHAIXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 04:23:39 -0400
Date: Tue, 1 Aug 2006 10:21:09 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: do { } while (0) question
Message-ID: <20060801082109.GB9589@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

your commit e2c2770096b686b4d2456173f53cb50e01aa635c does this:

---
Always use do {} while (0).  Failing to do so can cause subtle compile
failures or bugs.

-#define hotcpu_notifier(fn, pri)
-#define register_hotcpu_notifier(nb)
-#define unregister_hotcpu_notifier(nb)
+#define hotcpu_notifier(fn, pri)	do { } while (0)
+#define register_hotcpu_notifier(nb)	do { } while (0)
+#define unregister_hotcpu_notifier(nb)	do { } while (0)
---

I'm really wondering what these subtle compile failures or bugs are.
Could you please explain?
