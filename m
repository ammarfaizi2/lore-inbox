Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270446AbRHHKyE>; Wed, 8 Aug 2001 06:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270448AbRHHKxz>; Wed, 8 Aug 2001 06:53:55 -0400
Received: from [216.6.80.34] ([216.6.80.34]:62475 "EHLO
	dcmtechdom.dcmtech.co.in") by vger.kernel.org with ESMTP
	id <S270447AbRHHKxm>; Wed, 8 Aug 2001 06:53:42 -0400
Message-ID: <7FADCB99FC82D41199F9000629A85D1A01C650D5@dcmtechdom.dcmtech.co.in>
From: Nitin Dhingra <nitin.dhingra@dcmtech.co.in>
To: "'Hai Xu'" <xhai@CLEMSON.EDU>, linux-kernel@vger.kernel.org
Subject: RE: Question about mm.h and mmzone.h
Date: Wed, 8 Aug 2001 16:24:46 +0530 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The void *virtual entry is used in the page structure
to provide its virtual address of that page

 -----Original Message-----
From: 	Hai Xu [mailto:xhai@CLEMSON.EDU] 
Sent:	Wednesday, July 25, 2001 9:30 AM
To:	linux-kernel@vger.kernel.org
Subject:	Question about mm.h and mmzone.h

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
