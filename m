Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVALWEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVALWEk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVALWCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:02:38 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39078 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261489AbVALVsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:48:17 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051121347.vxtR3merv690zIQY@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 12 Jan 2005 13:47:49 -0800
Message-Id: <20051121347.Eers4foFN4d7Nfl8@topspin.com>
Mime-Version: 1.0
To: akpm@osdl.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][6/18] InfiniBand/core: remove debug printk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 21:47:50.0626 (UTC) FILETIME=[5CD10C20:01C4F8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove debug printk accidentally included.

Signed-off-by: Tom Duffy <tduffy@sun.com>
Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux/drivers/infiniband/core/sysfs.c	(revision 1455)
+++ linux/drivers/infiniband/core/sysfs.c	(revision 1456)
@@ -188,8 +188,6 @@
 	case 4: speed = " QDR"; break;
 	}
 
-	printk(KERN_ERR "width %d speed %d\n", attr.active_width, attr.active_speed);
-
 	rate = 25 * ib_width_enum_to_int(attr.active_width) * attr.active_speed;
 	if (rate < 0)
 		return -EINVAL;

