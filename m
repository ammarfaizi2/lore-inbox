Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVBOBFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVBOBFE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 20:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVBOBD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 20:03:58 -0500
Received: from gprs215-140.eurotel.cz ([160.218.215.140]:42400 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261562AbVBOBBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 20:01:01 -0500
Date: Tue, 15 Feb 2005 02:00:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, kraxel@bytesex.org
Cc: ncunningham@cyclades.com, bernard@blackham.com.au, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Fix u32 vs. pm_message_t confusion in bttv
Message-ID: <20050215010047.GL5415@elf.ucw.cz>
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

This fixes u32 vs. pm_message_t confusion in bttv. Please apply,

							Pavel
--- clean-mm/drivers/media/video/bttv-driver.c	2005-02-15 00:34:38.000000000 +0100
+++ linux-mm/drivers/media/video/bttv-driver.c	2005-02-15 01:04:10.000000000 +0100
@@ -3921,7 +3921,7 @@
         return;
 }
 
-static int bttv_suspend(struct pci_dev *pci_dev, u32 state)
+static int bttv_suspend(struct pci_dev *pci_dev, pm_message_t state)
 {
         struct bttv *btv = pci_get_drvdata(pci_dev);
 	struct bttv_buffer_set idle;


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
