Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTDDFFj (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 00:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTDDFFb (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 00:05:31 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:24197 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S263369AbTDDE57 (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 23:57:59 -0500
Date: Fri, 4 Apr 2003 00:13:10 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.66
Message-ID: <20030404001310.GK11574@neo.rr.com>
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
--- a/sound/isa/als100.c	Thu Apr  3 23:40:33 2003
+++ b/sound/isa/als100.c	Thu Apr  3 23:40:33 2003
@@ -121,7 +121,7 @@
 					    const struct pnp_card_device_id *id)
 {
 	struct pnp_dev *pdev;
-	struct pnp_resource_table * cfg = kmalloc(GFP_ATOMIC, sizeof(struct pnp_resource_table));
+	struct pnp_resource_table *cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
 	int err;
 	if (!cfg)
 		return -ENOMEM;
