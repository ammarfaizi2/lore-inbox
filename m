Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVBOA5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVBOA5N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 19:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVBOA5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 19:57:13 -0500
Received: from gprs215-140.eurotel.cz ([160.218.215.140]:32966 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261469AbVBOA4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 19:56:10 -0500
Date: Tue, 15 Feb 2005 01:55:57 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, vojtech@suse.cz
Cc: ncunningham@cyclades.com, bernard@blackham.com.au, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Fix u32 vs. pm_message_t in i8042.c
Message-ID: <20050215005557.GH5415@elf.ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au> <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214134658.324076c9.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes u32 vs. pm_message_t in i8042.c. Please apply,
								Pavel

--- clean-mm/drivers/input/serio/i8042.c	2005-02-15 00:46:40.000000000 +0100
+++ linux-mm/drivers/input/serio/i8042.c	2005-02-15 01:04:10.000000000 +0100
@@ -900,7 +900,7 @@
  * Here we try to restore the original BIOS settings
  */
 
-static int i8042_suspend(struct device *dev, u32 state, u32 level)
+static int i8042_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	if (level == SUSPEND_DISABLE) {
 		del_timer_sync(&i8042_timer);

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
