Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263611AbTIHVBv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 17:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbTIHVBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 17:01:51 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:33406 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S263611AbTIHVBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 17:01:50 -0400
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: THREAD_GROUP and linux thread
Date: Mon, 8 Sep 2003 14:01:45 -0700
Organization: Cisco Systems
Message-ID: <127101c3764c$6990df80$ca41cb3f@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
 
I am making some kernel changes to keep track of threads. Basically I
want to maintain a linked list of all threads.
 
The linux thread library on my system doesn't make use of the
CLONE_THREAD flag, so the thread_group list is not being used. I can
just add a new field in task_struct and maintain the list in
fork.c/exec.c/exit.c exactly as what the kernel does to the thread_group
list, but I am just wondering if I could just change the kernel to treat
CLONE_VM the same way as CLONE_THREAD which is a much simpler change.
 
So my questions are:
 
1. Is it safe to do so? [ in other word, is it a requirement to use
CLONE_VM together with CLONE_THREAD ]
2. Which version of pthread uses the CLONE_THREAD flag?
 
I couldn't find the documentation about CLONE_THREAD usages, so your
reply is very much appreciated.
 
Hua

