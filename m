Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVBCFkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVBCFkZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 00:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVBCFkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 00:40:25 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:219 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262602AbVBCFkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 00:40:17 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH] InfiniBand: add missing break between cases
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Wed, 02 Feb 2005 21:40:16 -0800
Message-ID: <52y8e65hhb.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 03 Feb 2005 05:40:16.0896 (UTC) FILETIME=[D72F5800:01C509B2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Libor Michalek <libor@topspin.com>

Add a missing break statement between RC and UD cases in mthca_post_send().
This fixes a possible oops for protocols that use the RC transport.

Signed-off-by: Libor Michalek <libor@topspin.com>
Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-01-28 11:11:02.000000000 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_qp.c	2005-02-02 21:35:09.683871535 -0800
@@ -1323,6 +1323,8 @@
 				break;
 			}
 
+			break;
+
 		case UD:
 			((struct mthca_ud_seg *) wqe)->lkey =
 				cpu_to_be32(to_mah(wr->wr.ud.ah)->key);
