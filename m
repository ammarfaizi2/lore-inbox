Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVACVCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVACVCx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVACVBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:01:02 -0500
Received: from av2-2-sn3.vrr.skanova.net ([81.228.9.108]:7823 "EHLO
	av2-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261867AbVACU77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 15:59:59 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pktcdvd: grep-friendly function prototypes
References: <20050103011113.6f6c8f44.akpm@osdl.org> <m3acrqutwe.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Jan 2005 21:45:27 +0100
In-Reply-To: <m3acrqutwe.fsf@telia.com>
Message-ID: <m3652eutqw.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Put function prototypes on a single source line to make them more
grep-friendly.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/block/pktcdvd.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/block/pktcdvd.c~pktcdvd-whitespace drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~pktcdvd-whitespace	2005-01-02 22:27:28.636331528 +0100
+++ linux-petero/drivers/block/pktcdvd.c	2005-01-02 22:27:28.641330768 +0100
@@ -607,8 +607,7 @@ static int pkt_set_segment_merging(struc
 /*
  * Copy CD_FRAMESIZE bytes from src_bio into a destination page
  */
-static void pkt_copy_bio_data(struct bio *src_bio, int seg, int offs,
-			      struct page *dst_page, int dst_offs)
+static void pkt_copy_bio_data(struct bio *src_bio, int seg, int offs, struct page *dst_page, int dst_offs)
 {
 	unsigned int copy_size = CD_FRAMESIZE;
 
@@ -1301,8 +1300,7 @@ static void pkt_print_settings(struct pk
 	printk("Mode-%c disc\n", pd->settings.block_mode == 8 ? '1' : '2');
 }
 
-static int pkt_mode_sense(struct pktcdvd_device *pd, struct packet_command *cgc,
-			  int page_code, int page_control)
+static int pkt_mode_sense(struct pktcdvd_device *pd, struct packet_command *cgc, int page_code, int page_control)
 {
 	memset(cgc->cmd, 0, sizeof(cgc->cmd));
 
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
