Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136550AbREDWWo>; Fri, 4 May 2001 18:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136567AbREDWW1>; Fri, 4 May 2001 18:22:27 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:36307 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S136548AbREDWVE>; Fri, 4 May 2001 18:21:04 -0400
Message-ID: <3AF2C8E5.2DF6E777@stanford.edu>
Date: Fri, 04 May 2001 08:21:09 -0700
From: Christopher Kanaan <kanaan@stanford.edu>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kraxel@goldbach.in-berlin.de, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch] sis_main.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry


--- /usr/src/linux/drivers/video/sis/sis_main.c Fri Feb  9 11:30:23 2001
+++ ./sis_main.c        Fri May  4 07:34:47 2001
@@ -1030,6 +1030,10 @@
        if (heap.pohFreeList == NULL) {
                poha = kmalloc(OH_ALLOC_SIZE, GFP_KERNEL);
 
+               if(!poha) {
+                   return(NULL);
+                 }
+
                poha->pohaNext = heap.pohaChain;
                heap.pohaChain = poha;
