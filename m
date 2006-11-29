Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966116AbWK2TrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966116AbWK2TrN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 14:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967597AbWK2TrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 14:47:13 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:29364 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S966116AbWK2TrM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 14:47:12 -0500
Date: Wed, 29 Nov 2006 11:48:22 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -rt] 2.6.19-4c6-rt9 build problem
Message-ID: <20061129194821.GA2895@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Got a compiler error building 1.6.19-rc6-rt9 on NUMA-Q, admittedly
with unusual config.  The patch below solves it, though I cannot say
that I am an ACPI expert.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

---

 acpi_pmtmr.h |    2 ++
 1 files changed, 2 insertions(+)

diff -urpNa -X dontdiff linux-2.6.19-rc6-rt9/include/linux/acpi_pmtmr.h linux-2.6.19-rc6-rt9.tscbug/include/linux/acpi_pmtmr.h
--- linux-2.6.19-rc6-rt9/include/linux/acpi_pmtmr.h	2006-11-28 17:21:55.000000000 -0800
+++ linux-2.6.19-rc6-rt9.tscbug/include/linux/acpi_pmtmr.h	2006-11-29 08:09:07.000000000 -0800
@@ -27,6 +27,8 @@ static inline u32 acpi_pm_read_early(voi
 
 #else
 
+#define pmtmr_ioport 0
+
 static inline u32 acpi_pm_read_early(void)
 {
 	return 0;
