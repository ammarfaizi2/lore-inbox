Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267074AbRGTQg5>; Fri, 20 Jul 2001 12:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267088AbRGTQgs>; Fri, 20 Jul 2001 12:36:48 -0400
Received: from [24.229.53.66] ([24.229.53.66]:16665 "HELO
	bbserver1.backbonesecurity.com") by vger.kernel.org with SMTP
	id <S267074AbRGTQge> convert rfc822-to-8bit; Fri, 20 Jul 2001 12:36:34 -0400
content-class: urn:content-classes:message
Subject: Simple LKM & copy_from_user question
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Fri, 20 Jul 2001 12:44:56 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Message-ID: <94FD5825A793194CBF039E6673E9AFE0C010@bbserver1.backbonesecurity.com>
Thread-Topic: [PATCH] PPPOE can kfree SKB twice (was Re: kernel panic problem. (smp, iptables?))
Thread-Index: AcERMy0/oD0x/32uQPW6VtNUB8F6cQAABV3g
From: "David CM Weber" <dweber@backbonesecurity.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello all.  I've been lurking for a while, and I have a quick question.
I'm in the process of writing my first LKM to mess with the
sys_socketcall function.  I'm looking at the original one for guidance,
and it makes a call to copy_from_user() to get some socket-related data.

So, to use copy_from_user(), I've gathered that I need to #include
<asm/uaccess.h>, so I do so.  

After including this file, I'm getting the following errors:


.../linux/timer.h:21: field 'vec' has incomplete type

.../asm/uaccess.h::63: dereferencing pointer to incomplete type


(This is not a full list of the error message that it's reporting)

Am I not setting a define correctly? 

I'm using Redhat 7.1, on an Intel P3 system.  It's the latest stable
release (2.4.x ??) of the kernel.



If you need more information, please let me know.  This has been
troubling me for several days now..


Thanks,


Dave Weber
Backbone Security, Inc.
570-422-7900
