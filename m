Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264383AbUBHXLt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 18:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbUBHXLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 18:11:49 -0500
Received: from mail2.scram.de ([195.226.127.112]:27655 "EHLO mail2.scram.de")
	by vger.kernel.org with ESMTP id S264383AbUBHXLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 18:11:47 -0500
Date: Mon, 9 Feb 2004 00:11:30 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@localhost
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: tms380tr patch 2a/3 (queue fix in header)
Message-ID: <Pine.LNX.4.58.0402090009110.1327@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

this patch belongs to the queue fix tms380tr patch 2/3. It deletes the
no longer needed stuff from the header file.

--jochen

diff -u -p -r1.7 tms380tr.h
--- drivers/net/tokenring/tms380tr.h	25 Apr 2003 05:59:05 -0000	1.7
+++ drivers/net/tokenring/tms380tr.h	25 Jan 2004 18:40:36 -0000
@@ -598,7 +598,6 @@ typedef struct {
 				 * in one RPL/TPL. (depending on TI firmware
 				 * version)
 				 */
-#define MAX_TX_QUEUE	    10	/* Maximal number of skb's queued in driver. */

 /*
  * AC (1), FC (1), Dst (6), Src (6), RIF (18), Data (4472) = 4504
@@ -1114,9 +1113,6 @@ typedef struct net_local {
 	unsigned long StartTime;
 	unsigned long LastSendTime;

-	struct sk_buff_head SendSkbQueue;
-	unsigned short QueueSkb;
-
 	struct tr_statistics MacStat;	/* MAC statistics structure */

 	unsigned long dmalimit; /* the max DMA address (ie, ISA) */
