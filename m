Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbQKNR21>; Tue, 14 Nov 2000 12:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129100AbQKNR2R>; Tue, 14 Nov 2000 12:28:17 -0500
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:15114 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S129040AbQKNR2C>; Tue, 14 Nov 2000 12:28:02 -0500
Date: Tue, 14 Nov 2000 09:58:00 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Cc: rth@twiddle.net
Subject: [PATCH] __builtin_expect in 2.4.0-test11pre4
Message-ID: <20001114095800.A2526@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At least on Alpha, and possibly other architectures, the following
minor correction is needed:

--- linux-2.4.0p11p/include/asm-alpha/semaphore.h~	Mon Nov 13 14:01:10 2000
+++ linux-2.4.0p11p/include/asm-alpha/semaphore.h	Mon Nov 13 14:03:44 2000
@@ -11,6 +11,7 @@
 #include <asm/current.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
+#include <asm/compiler.h>
 
 #define DEBUG_SEMAPHORE 0
 #define DEBUG_RW_SEMAPHORE 0

or various version of a compiler are blowing a fuse on a missing
__builtin_expect prototype.

  Michal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
