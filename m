Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278823AbRJZSfl>; Fri, 26 Oct 2001 14:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278828AbRJZSfb>; Fri, 26 Oct 2001 14:35:31 -0400
Received: from [207.188.182.104] ([207.188.182.104]:25964 "EHLO infomesa.com")
	by vger.kernel.org with ESMTP id <S278823AbRJZSfS>;
	Fri, 26 Oct 2001 14:35:18 -0400
Date: Fri, 26 Oct 2001 12:35:43 -0600
Message-Id: <200110261835.MAA14684@infomesa.com>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
From: MikeW@rren.org (Mike Warren)
Subject: [PATCH] sparc64 fix for 2.4.13-ac2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sparc64 compiles of recent ac kernels are failing due to a missing
#define of INIT_MMAP.  This code was removed in patch-2.4.10, but was
also erroneously removed from the ac branch where it is still required.

Mike

*** linux-2.4.13-ac2/include/asm-sparc64/processor.h	Thu Oct 11 06:42:47 2001
--- linux/include/asm-sparc64/processor.h	Fri Oct 26 18:16:14 2001
***************
*** 88,93 ****
--- 88,96 ----
  #define FAULT_CODE_ITLB		0x04	/* Miss happened in I-TLB		*/
  #define FAULT_CODE_WINFIXUP	0x08	/* Miss happened during spill/fill	*/
  
+ #define INIT_MMAP { &init_mm, 0xfffff80000000000, 0xfffff80001000000, \
+ 		    NULL, PAGE_SHARED , VM_READ | VM_WRITE | VM_EXEC, 1, NULL, NULL }
+ 
  #define INIT_THREAD  {					\
  /* ksp, wstate, cwp, flags, current_ds, */ 		\
     0,   0,      0,   0,     KERNEL_DS,			\
