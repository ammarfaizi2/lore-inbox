Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVACVDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVACVDA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVACVAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:00:49 -0500
Received: from av3-1-sn4.m-sp.skanova.net ([81.228.10.114]:50059 "EHLO
	av3-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261859AbVACU75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 15:59:57 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] synaptics: Remove unused struct member variable
References: <20050103011113.6f6c8f44.akpm@osdl.org> <m3acrqutwe.fsf@telia.com>
	<m3652eutqw.fsf_-_@telia.com> <m31xd2utno.fsf_-_@telia.com>
	<m3wtuutesu.fsf_-_@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Jan 2005 21:58:46 +0100
In-Reply-To: <m3wtuutesu.fsf_-_@telia.com>
Message-ID: <m3sm5itek9.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an unused variable in the synaptics_data struct and
deletes a no longer helpful comment. I don't think this has been used
since the very first synaptics kernel patch I submitted that did all
processing in kernel space instead of delegating most of it to the X
server.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/input/mouse/synaptics.h |    2 --
 1 files changed, 2 deletions(-)

diff -puN drivers/input/mouse/synaptics.h~synaptics-unused-var drivers/input/mouse/synaptics.h
--- linux/drivers/input/mouse/synaptics.h~synaptics-unused-var	2005-01-03 21:14:50.995952160 +0100
+++ linux-petero/drivers/input/mouse/synaptics.h	2005-01-03 21:14:51.011949728 +0100
@@ -101,8 +101,6 @@ struct synaptics_data {
 	unsigned long int ext_cap; 		/* Extended Capabilities */
 	unsigned long int identity;		/* Identification */
 
-	/* Data for normal processing */
-	int old_w;				/* Previous w value */
 	unsigned char pkt_type;			/* packet type - old, new, etc */
 	unsigned char mode;			/* current mode byte */
 };
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
