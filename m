Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVBATBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVBATBd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 14:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVBATBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 14:01:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34273 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261908AbVBATBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 14:01:20 -0500
Date: Tue, 1 Feb 2005 19:01:15 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: stripe_width should be sector_t
Message-ID: <20050201190114.GP10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stripe_width should be sector_t to support large devices.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
--- diff/drivers/md/dm-stripe.c	2005-01-28 15:27:58.000000000 +0000
+++ source/drivers/md/dm-stripe.c	2005-01-28 15:28:23.000000000 +0000
@@ -21,7 +21,7 @@
 	uint32_t stripes;
 
 	/* The size of this target / num. stripes */
-	uint32_t stripe_width;
+	sector_t stripe_width;
 
 	/* stripe chunk size */
 	uint32_t chunk_shift;
