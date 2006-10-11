Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161400AbWJKVFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161400AbWJKVFx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161404AbWJKVFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:05:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:55710 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161400AbWJKVFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:05:25 -0400
Date: Wed, 11 Oct 2006 14:05:01 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       git-commits-head@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jeff Garzik <jeff@garzik.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 20/67] netdrvr: lp486e: fix typo
Message-ID: <20061011210501.GU16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="netdrvr-lp486e-fix-typo.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jeff Garzik <jeff@garzik.org>

inside #if 0'd code, but it bugged me.

Really, we should probably just delete the driver.

Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/lp486e.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.18.orig/drivers/net/lp486e.c
+++ linux-2.6.18/drivers/net/lp486e.c
@@ -442,16 +442,16 @@ init_rx_bufs(struct net_device *dev, int
 		if (rbd) {
 			rbd->pad = 0;
 			rbd->count = 0;
-			rbd->skb = dev_alloc_skb(RX_SKB_SIZE);
+			rbd->skb = dev_alloc_skb(RX_SKBSIZE);
 			if (!rbd->skb) {
 				printk("dev_alloc_skb failed");
 			}
 			rbd->next = rfd->rbd;
 			if (i) {
 				rfd->rbd->prev = rbd;
-				rbd->size = RX_SKB_SIZE;
+				rbd->size = RX_SKBSIZE;
 			} else {
-				rbd->size = (RX_SKB_SIZE | RBD_EL);
+				rbd->size = (RX_SKBSIZE | RBD_EL);
 				lp->rbd_tail = rbd;
 			}
 

--
