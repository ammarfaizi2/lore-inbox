Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbTDDFaQ (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 00:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbTDDE7H (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 23:59:07 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:18821 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261511AbTDDExk (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 23:53:40 -0500
Date: Fri, 4 Apr 2003 00:08:54 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.66
Message-ID: <20030404000854.GD11574@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030404000731.GB11574@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404000731.GB11574@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/sound/isa/als100.c b/sound/isa/als100.c
--- a/sound/isa/als100.c	Thu Apr  3 23:41:11 2003
+++ b/sound/isa/als100.c	Thu Apr  3 23:41:11 2003
@@ -151,6 +151,7 @@
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
 		printk(KERN_ERR PFX "AUDIO pnp configure failure\n");
+		kfree(cfg);
 		return err;
 	}
 	port[dev] = pnp_port_start(pdev, 0);
