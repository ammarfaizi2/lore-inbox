Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268581AbRGYQcY>; Wed, 25 Jul 2001 12:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268583AbRGYQcO>; Wed, 25 Jul 2001 12:32:14 -0400
Received: from mail.clemson.edu ([130.127.28.87]:25251 "EHLO CLEMSON.EDU")
	by vger.kernel.org with ESMTP id <S268581AbRGYQcF>;
	Wed, 25 Jul 2001 12:32:05 -0400
Message-ID: <000701c11527$1d4c44d0$3cac7f82@crb50>
From: "Hai Xu" <xhai@CLEMSON.EDU>
To: <linux-kernel@vger.kernel.org>
Subject: Question about mm.h and mmzone.h
Date: Wed, 25 Jul 2001 12:30:27 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2479.0006
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Dear all,

What I am using is RH7.1+Linux Kernel 2.4.4.

When I compile my code under the 2.4.4 Linux Kernel, I will meet error as
follows:

In file included from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from ../../../include/builtins++.h:42,
                 from example.cpp:12:
/usr/src/linux/include/linux/mm.h:461: conflicting types for `struct zone_t'
/usr/src/linux/include/linux/mmzone.h:61: previous declaration as `typedef
struct zone_struct zone_t'
In file included from /usr/rtlinux-3.1/include/rtl_sync.h:47,
                 from /usr/rtlinux-3.1/include/rtl_spinlock.h:13,
                 from /usr/rtlinux-3.1/include/rtl_time.h:46,
                 from example.cpp:20:
/usr/rtlinux-3.1/include/rtl_tracer.h:79: confused by earlier errors,
bailing out
make: *** [_example.o] Error 1

Any idea about it?

I have another question about the stucture -- page in the mm.h. What is
function of void *virtual in this struct? I can not understand this
definition.

typedef struct page {
 struct list_head list;
 struct address_space *mapping;
 unsigned long index;
 struct page *next_hash;
 atomic_t count;
 unsigned long flags; /* atomic flags, some possibly updated asynchronously
*/
 struct list_head lru;
 unsigned long age;
 wait_queue_head_t wait;
 struct page **pprev_hash;
 struct buffer_head * buffers;
 void *virtual; /* non-NULL if kmapped */
 struct zone_struct *zone;
} mem_map_t;

thanks in advance
Hai Xu

