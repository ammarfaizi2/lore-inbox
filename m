Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312955AbSC0CNl>; Tue, 26 Mar 2002 21:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312956AbSC0CNV>; Tue, 26 Mar 2002 21:13:21 -0500
Received: from holomorphy.com ([66.224.33.161]:8864 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S312955AbSC0CNQ>;
	Tue, 26 Mar 2002 21:13:16 -0500
Date: Tue, 26 Mar 2002 18:12:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [patch] remove dead comment
Message-ID: <20020327021242.GE10457@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hate to remove a comment from the kernel, but...


Cheers,
Bill

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.537   -> 1.538  
#	        mm/filemap.c	1.69    -> 1.70   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/03/26	wli@tisifone.holomorphy.com	1.538
# filemap.c:
#   Remove comments already present in hash.h and not corresponding to any code in filemap.c
# --------------------------------------------
#
diff --minimal -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Tue Mar 26 18:08:13 2002
+++ b/mm/filemap.c	Tue Mar 26 18:08:13 2002
@@ -742,26 +742,6 @@
 }
 
 /*
- * Knuth recommends primes in approximately golden ratio to the maximum
- * integer representable by a machine word for multiplicative hashing.
- * Chuck Lever verified the effectiveness of this technique:
- * http://www.citi.umich.edu/techreports/reports/citi-tr-00-1.pdf
- *
- * These primes are chosen to be bit-sparse, that is operations on
- * them can use shifts and additions instead of multiplications for
- * machines where multiplications are slow.
- */
-#if BITS_PER_LONG == 32
-/* 2^31 + 2^29 - 2^25 + 2^22 - 2^19 - 2^16 + 1 */
-#define GOLDEN_RATIO_PRIME 0x9e370001UL
-#elif BITS_PER_LONG == 64
-/*  2^63 + 2^61 - 2^57 + 2^54 - 2^51 - 2^18 + 1 */
-#define GOLDEN_RATIO_PRIME 0x9e37fffffffc0001UL
-#else
-#error Define GOLDEN_RATIO_PRIME for your wordsize.
-#endif
-
-/*
  * In order to wait for pages to become available there must be
  * waitqueues associated with pages. By using a hash table of
  * waitqueues where the bucket discipline is to maintain all
