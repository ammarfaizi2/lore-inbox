Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131468AbQKPUxD>; Thu, 16 Nov 2000 15:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131467AbQKPUwx>; Thu, 16 Nov 2000 15:52:53 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:19302
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S131485AbQKPUwm>; Thu, 16 Nov 2000 15:52:42 -0500
Date: Thu, 16 Nov 2000 21:14:53 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: sailer@ife.ee.ethz.ch
Cc: linux-kernel@vger.kernel.org
Subject: [uPATCH] Compile error in drivers/net/hamradio/soundmodem/sm_sbm.c (240-t11p5)
Message-ID: <20001116211453.C716@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Changes in the kernel has made the patch below necessary for sm.h:

--- linux-240-t11-pre5-clean/drivers/net/hamradio/soundmodem/sm.h	Wed Aug 18 20:38:50 1999
+++ linux/drivers/net/hamradio/soundmodem/sm.h	Thu Nov 16 20:33:17 2000
@@ -299,7 +299,7 @@
 
 #ifdef __i386__
 
-#define HAS_RDTSC (current_cpu_data.x86_capability & X86_FEATURE_TSC)
+#define HAS_RDTSC (test_bit(X86_FEATURE_TSC, &current_cpu_data.x86_capability))
 
 /*
  * only do 32bit cycle counter arithmetic; we hope we won't overflow.

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Genius may have its limitations, but stupidity is not thus handicapped. 
  -- Elbert Hubbard 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
