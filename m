Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268932AbRG0TX2>; Fri, 27 Jul 2001 15:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268935AbRG0TXT>; Fri, 27 Jul 2001 15:23:19 -0400
Received: from [62.116.8.197] ([62.116.8.197]:20608 "HELO
	ghanima.endorphin.org") by vger.kernel.org with SMTP
	id <S268932AbRG0TWo>; Fri, 27 Jul 2001 15:22:44 -0400
Date: Fri, 27 Jul 2001 21:03:15 +0200
From: clemens <therapy@endorphin.org>
To: linux-kernel@vger.kernel.org
Subject: [patch] include/linux/spinlock.h
Message-ID: <20010727210315.A20213@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

--- spinlock.h~	Fri Jul 27 20:59:19 2001
+++ spinlock.h	Fri Jul 27 21:01:24 2001
@@ -80,6 +80,8 @@
 
 #else /* (DEBUG_SPINLOCKS >= 2) */
 
+#include <asm/system.h>
+
 typedef struct {
 	volatile unsigned long lock;
 	volatile unsigned int babble;
