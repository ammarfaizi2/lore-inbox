Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936928AbWLDOvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936928AbWLDOvO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936925AbWLDOvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:51:14 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:1600 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S936928AbWLDOvM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:51:12 -0500
Date: Mon, 4 Dec 2006 15:50:58 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, rwuerthn@de.ibm.com
Subject: [S390] update interface notes in zcrypt.h
Message-ID: <20061204145058.GF32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Wuerthner <rwuerthn@de.ibm.com>

[S390] update interface notes in zcrypt.h

Signed-off-by: Ralph Wuerthner <rwuerthn@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/zcrypt.h |   91 ++++++++++++++++++++--------------------------
 1 files changed, 41 insertions(+), 50 deletions(-)

diff -urpN linux-2.6/include/asm-s390/zcrypt.h linux-2.6-patched/include/asm-s390/zcrypt.h
--- linux-2.6/include/asm-s390/zcrypt.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/zcrypt.h	2006-12-04 14:50:35.000000000 +0100
@@ -180,40 +180,8 @@ struct ica_xcRB {
  *	     for the implementation details for the contents of the
  *	     block
  *
- *   Z90STAT_TOTALCOUNT
- *     Return an integer count of all device types together.
- *
- *   Z90STAT_PCICACOUNT
- *     Return an integer count of all PCICAs.
- *
- *   Z90STAT_PCICCCOUNT
- *     Return an integer count of all PCICCs.
- *
- *   Z90STAT_PCIXCCMCL2COUNT
- *     Return an integer count of all MCL2 PCIXCCs.
- *
- *   Z90STAT_PCIXCCMCL3COUNT
- *     Return an integer count of all MCL3 PCIXCCs.
- *
- *   Z90STAT_CEX2CCOUNT
- *     Return an integer count of all CEX2Cs.
- *
- *   Z90STAT_CEX2ACOUNT
- *     Return an integer count of all CEX2As.
- *
- *   Z90STAT_REQUESTQ_COUNT
- *     Return an integer count of the number of entries waiting to be
- *     sent to a device.
- *
- *   Z90STAT_PENDINGQ_COUNT
- *     Return an integer count of the number of entries sent to a
- *     device awaiting the reply.
- *
- *   Z90STAT_TOTALOPEN_COUNT
- *     Return an integer count of the number of open file handles.
- *
- *   Z90STAT_DOMAIN_INDEX
- *     Return the integer value of the Cryptographic Domain.
+ *   ZSECSENDCPRB
+ *     Send an arbitrary CPRB to a crypto card.
  *
  *   Z90STAT_STATUS_MASK
  *     Return an 64 element array of unsigned chars for the status of
@@ -235,28 +203,51 @@ struct ica_xcRB {
  *     of successfully completed requests per device since the device
  *     was detected and made available.
  *
- *   ICAZ90STATUS (deprecated)
+ *   Z90STAT_REQUESTQ_COUNT
+ *     Return an integer count of the number of entries waiting to be
+ *     sent to a device.
+ *
+ *   Z90STAT_PENDINGQ_COUNT
+ *     Return an integer count of the number of entries sent to all
+ *     devices awaiting the reply.
+ *
+ *   Z90STAT_TOTALOPEN_COUNT
+ *     Return an integer count of the number of open file handles.
+ *
+ *   Z90STAT_DOMAIN_INDEX
+ *     Return the integer value of the Cryptographic Domain.
+ *
+ *   The following ioctls are deprecated and should be no longer used:
+ *
+ *   Z90STAT_TOTALCOUNT
+ *     Return an integer count of all device types together.
+ *
+ *   Z90STAT_PCICACOUNT
+ *     Return an integer count of all PCICAs.
+ *
+ *   Z90STAT_PCICCCOUNT
+ *     Return an integer count of all PCICCs.
+ *
+ *   Z90STAT_PCIXCCMCL2COUNT
+ *     Return an integer count of all MCL2 PCIXCCs.
+ *
+ *   Z90STAT_PCIXCCMCL3COUNT
+ *     Return an integer count of all MCL3 PCIXCCs.
+ *
+ *   Z90STAT_CEX2CCOUNT
+ *     Return an integer count of all CEX2Cs.
+ *
+ *   Z90STAT_CEX2ACOUNT
+ *     Return an integer count of all CEX2As.
+ *
+ *   ICAZ90STATUS
  *     Return some device driver status in a ica_z90_status struct
  *     This takes an ica_z90_status struct as its arg.
  *
- *     NOTE: this ioctl() is deprecated, and has been replaced with
- *	     single ioctl()s for each type of status being requested
- *
- *   Z90STAT_PCIXCCCOUNT (deprecated)
+ *   Z90STAT_PCIXCCCOUNT
  *     Return an integer count of all PCIXCCs (MCL2 + MCL3).
  *     This is DEPRECATED now that MCL3 PCIXCCs are treated differently from
  *     MCL2 PCIXCCs.
- *
- *   Z90QUIESCE (not recommended)
- *     Quiesce the driver.  This is intended to stop all new
- *     requests from being processed.  Its use is NOT recommended,
- *     except in circumstances where there is no other way to stop
- *     callers from accessing the driver.  Its original use was to
- *     allow the driver to be "drained" of work in preparation for
- *     a system shutdown.
- *
- *     NOTE: once issued, this ban on new work cannot be undone
- *	     except by unloading and reloading the driver.
  */
 
 /**
