Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVAXGW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVAXGW5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVAXGWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:22:46 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:19986 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261457AbVAXGO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:14:29 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][9/12] InfiniBand/ipoib: remove uses of yield()
In-Reply-To: <20051232214.WfzWlq9JcWt0oefR@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Sun, 23 Jan 2005 22:14:24 -0800
Message-Id: <20051232214.j7TLAr2Uqj9NHnIa@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jan 2005 06:14:25.0450 (UTC) FILETIME=[F41660A0:01C501DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace uses of yield() with msleep(1) as suggested by kernel janitors.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-bk.orig/drivers/infiniband/ulp/ipoib/ipoib_ib.c	2005-01-23 08:31:58.000000000 -0800
+++ linux-bk/drivers/infiniband/ulp/ipoib/ipoib_ib.c	2005-01-23 20:52:46.294255560 -0800
@@ -509,7 +509,7 @@
 			goto timeout;
 		}
 
-		yield();
+		msleep(1);
 	}
 
 	ipoib_dbg(priv, "All sends and receives done.\n");
@@ -535,7 +535,7 @@
 			break;
 		}
 
-		yield();
+		msleep(1);
 	}
 
 	return 0;

