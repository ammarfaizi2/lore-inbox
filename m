Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271433AbRHPEc0>; Thu, 16 Aug 2001 00:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271460AbRHPEcQ>; Thu, 16 Aug 2001 00:32:16 -0400
Received: from trained-monkey.org ([209.217.122.11]:33528 "EHLO
	savage.trained-monkey.org") by vger.kernel.org with ESMTP
	id <S271433AbRHPEb6>; Thu, 16 Aug 2001 00:31:58 -0400
Date: Thu, 16 Aug 2001 00:30:16 -0400
Message-Id: <200108160430.f7G4UGT19451@savage.trained-monkey.org>
From: <jes@trained-monkey.org>
To: torvalds@transmeta.com
CC: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: [patch] dz.c 64 bit locking issues
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Another 64 bit flags bug.

Cheers
Jes

--- drivers/char/n_r3964.c~	Wed Jun 27 17:13:01 2001
+++ drivers/char/n_r3964.c	Thu Aug 16 00:29:13 2001
@@ -1421,7 +1421,7 @@
    int pid=current->pid;
    struct r3964_client_info *pClient;
    struct r3964_message *pMsg=NULL;
-   unsigned int flags;
+   unsigned long flags;
    int result = POLLOUT;
 
    TRACE_L("POLL");
