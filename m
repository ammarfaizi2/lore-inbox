Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267081AbUBRXVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267144AbUBRXVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:21:47 -0500
Received: from linux.us.dell.com ([143.166.224.162]:59057 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S266817AbUBRXTf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:19:35 -0500
Date: Wed, 18 Feb 2004 17:18:27 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Matt Mackall <mpm@selenic.com>, akpm@osdl.org,
       marcelo.tosatti@cyclades.com
Cc: Clay Haapala <chaapala@cisco.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.1 -- take two] Add CRC32C chksums to crypto and lib routines
Message-ID: <20040218171827.A4407@lists.us.dell.com>
References: <yquj4qu8je1m.fsf@chaapala-lnx2.cisco.com> <Xine.LNX.4.44.0402031213120.939-100000@thoron.boston.redhat.com> <20040203175006.GA19751@chaapala-lnx2.cisco.com> <20040203185111.GA31138@waste.org> <yqujad40j7rn.fsf@chaapala-lnx2.cisco.com> <20040203172508.B26222@lists.us.dell.com> <20040203233737.GD31138@waste.org> <yquj4qu6g6ui.fsf@chaapala-lnx2.cisco.com> <20040204172116.GF31138@waste.org> <20040218152403.A30333@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040218152403.A30333@lists.us.dell.com>; from Matt_Domsch@dell.com on Wed, Feb 18, 2004 at 03:24:03PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After seeking advice from Dell's lawyers, they recommend simply adding
> the GPL license text to the top of the file and be done with it.
> It's public domain, we're free to include (and relicense) it as we
> wish.  If someone else wants to use it in a non-GPL fashion, they'll
> need to start from the original public domain submission, not this one
> which clearly has been modified somewhat since we first received it,
> with faster algorithms, creation of the table at compile time, etc.

Patch below applies to both 2.4.25 and 2.6.3, and replaces the public
domain statement and non-warranty with the GPL, as is permitted by the
code being in the public domain, and is done with legal advice.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


===== lib/crc32.c 1.11 vs edited =====
--- 1.11/lib/crc32.c	Tue Feb  3 23:29:15 2004
+++ edited/lib/crc32.c	Wed Feb 18 17:00:27 2004
@@ -1,6 +1,9 @@
-/* 
+/*
  * Oct 15, 2000 Matt Domsch <Matt_Domsch@dell.com>
  * Nicer crc32 functions/docs submitted by linux@horizon.com.  Thanks!
+ * Code was from the public domain, copyright abandoned.  Code was
+ * subsequently included in the kernel, thus was re-licensed under the
+ * GNU GPL v2.
  *
  * Oct 12, 2000 Matt Domsch <Matt_Domsch@dell.com>
  * Same crc32 function was used in 5 other places in the kernel.
@@ -12,7 +15,9 @@
  *   drivers/net/smc9194.c uses seed ~0, doesn't xor with ~0.
  *   fs/jffs2 uses seed 0, doesn't xor with ~0.
  *   fs/partitions/efi.c uses seed ~0, xor's with ~0.
- * 
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
  */
 
 #include <linux/crc32.h>
@@ -38,16 +43,10 @@
 #define attribute(x)
 #endif
 
-/*
- * This code is in the public domain; copyright abandoned.
- * Liability for non-performance of this code is limited to the amount
- * you paid for it.  Since it is distributed for free, your refund will
- * be very very small.  If it breaks, you get to keep both pieces.
- */
 
 MODULE_AUTHOR("Matt Domsch <Matt_Domsch@dell.com>");
 MODULE_DESCRIPTION("Ethernet CRC32 calculations");
-MODULE_LICENSE("GPL and additional rights");
+MODULE_LICENSE("GPL");
 
 #if CRC_LE_BITS == 1
 /*
