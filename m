Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268678AbUHXXrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268678AbUHXXrg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 19:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268506AbUHXXra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 19:47:30 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:6673 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S268678AbUHXXq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 19:46:27 -0400
Message-ID: <412BD377.60601@nvidia.com>
Date: Tue, 24 Aug 2004 16:47:03 -0700
From: achew <achew@nvidia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ak@suse.de
Subject: [PATCH 2.6.9-rc1] mpspec.h (x86_64)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Aug 2004 23:46:21.0125 (UTC) FILETIME=[8EC25750:01C48A34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MAX_MP_BUSSES needs to be increased to support some MP systems.

This patch increases it to the maximum addressable range, given the 8-bit bus ID field of MP table bus entries.
Derived from mpspec.h from the 2.4-series kernel.


--- linux-2.6.9-rc1/include/asm-x86_64/mpspec.h	2004-08-13 22:36:57.000000000 -0700
+++ linux/include/asm-x86_64/mpspec.h	2004-08-24 16:29:37.193956560 -0700
@@ -156,8 +156,8 @@
  *	7	2 CPU MCA+PCI
  */
 
-#define MAX_IRQ_SOURCES 256
-#define MAX_MP_BUSSES 32
+#define MAX_MP_BUSSES 257
+#define MAX_IRQ_SOURCES (MAX_MP_BUSSES*4)
 enum mp_bustype {
 	MP_BUS_ISA = 1,
 	MP_BUS_EISA,


