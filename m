Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267713AbSLGDr5>; Fri, 6 Dec 2002 22:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267714AbSLGDr5>; Fri, 6 Dec 2002 22:47:57 -0500
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:25355 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S267713AbSLGDr4>; Fri, 6 Dec 2002 22:47:56 -0500
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'Linux Kernel Development List'" <linux-kernel@vger.kernel.org>
Subject: POSSIBLE BUG: Debugging Not Automatically Activated in Slab.c
Date: Fri, 6 Dec 2002 21:55:38 -0600
Message-ID: <000a01c29da4$8235b370$8c43d03f@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before I submit this as an actually bug, I'd like the input of some people
who know a little more about the Slab Allocator and Kernel Debugging.

The Slab Allocator includes this line:

#ifdef CONFIG_DEBUG_SLAB

in slab.c (line 89) to activate debugging.

However, I couldn't find anywhere in the code where CONFIG_DEBUG_SLAB is
linked to CONFIG_DEBUG_KERNEL.  In other words, setting the kernel as a
debug kernel doesn't automatically set the Slab Allocator to debug too.

1) Am I missing something?

2) Is this intentional or by design?

If this is an actually bug, it can be fixed by inserting the following code
in slab.h immediately following the #include statements:

#ifdef CONFIG_DEBUG_KERNEL
#define CONFIG_DEBUG_SLAB
#endif

Joseph Wagner

