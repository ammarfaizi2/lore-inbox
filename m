Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVADTZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVADTZY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVADTZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:25:23 -0500
Received: from mail243.megamailservers.com ([216.251.41.63]:24514 "EHLO
	mail243.megamailservers.com") by vger.kernel.org with ESMTP
	id S261819AbVADTD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:03:26 -0500
X-Authenticated-User: jiri.gaisler.com
Message-ID: <41DAE8AB.1020002@gaisler.com>
Date: Tue, 04 Jan 2005 20:04:11 +0100
From: Jiri Gaisler <jiri@gaisler.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: sparclinux@vger.kernel.org
CC: linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: [3/7] LEON SPARC V8 processor support for linux-2.6.10
Content-Type: multipart/mixed;
 boundary="------------040002060508040502040601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040002060508040502040601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

linux-2.6.10: Kernel patches:

[3/7] diff2.6.10_drivers_sbus.diff:       diff for drivers/sbus

--------------040002060508040502040601
Content-Type: text/plain;
 name="diff2.6.10_drivers_sbus.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff2.6.10_drivers_sbus.diff"

diff -Naur ../linux-2.6.10/drivers/sbus/sbus.c linux-2.6.10/drivers/sbus/sbus.c
--- ../linux-2.6.10/drivers/sbus/sbus.c	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.10/drivers/sbus/sbus.c	2005-01-03 11:36:33.000000000 +0100
@@ -358,6 +358,8 @@
 		   (nd = prom_searchsiblings(nd, "sbi")) == 0) {
 		   	panic("sbi not found");
 		}
+	} else if(sparc_cpu_model == sparc_leon) {
+		return 0;
 	} else if((nd = prom_searchsiblings(topnd, "sbus")) == 0) {
 		if((iommund = prom_searchsiblings(topnd, "iommu")) == 0 ||
 		   (nd = prom_getchild(iommund)) == 0 ||

--------------040002060508040502040601--
