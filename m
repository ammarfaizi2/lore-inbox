Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267904AbUJLVwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267904AbUJLVwf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 17:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUJLVwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 17:52:35 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9225 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S267930AbUJLVrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 17:47:41 -0400
Date: Tue, 12 Oct 2004 23:47:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, mochel@digitalimplant.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] make CONFIG_PM_DEBUG depend on CONFIG_PM
Message-ID: <20041012214704.GE18579@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The trivial patch by Chris Wright below still applies against
both 2.6.9-rc4 and 2.6.9-rc4-mm1.


make CONFIG_PM_DEBUG depend on CONFIG_PM


Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

===== kernel/power/Kconfig 1.11 vs edited =====
--- 1.11/kernel/power/Kconfig	2004-08-01 20:36:39 -07:00
+++ edited/kernel/power/Kconfig	2004-09-29 16:01:40 -07:00
@@ -20,6 +20,7 @@
 
 config PM_DEBUG
 	bool "Power Management Debug Support"
+	depends on PM
 	---help---
 	This option enables verbose debugging support in the Power Management
 	code. This is helpful when debugging and reporting various PM bugs, 
