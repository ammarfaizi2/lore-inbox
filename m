Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131728AbQLIP31>; Sat, 9 Dec 2000 10:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131751AbQLIP3R>; Sat, 9 Dec 2000 10:29:17 -0500
Received: from pizda.ninka.net ([216.101.162.242]:22153 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131728AbQLIP3A>;
	Sat, 9 Dec 2000 10:29:00 -0500
Date: Sat, 9 Dec 2000 06:42:38 -0800
Message-Id: <200012091442.GAA20532@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: kernel@tekno-soft.it
CC: rasmus@jaquet.dk, torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20001209152806.00c8e7b0@mail.tekno-soft.it> (message
	from Roberto Fichera on Sat, 09 Dec 2000 15:48:05 +0100)
Subject: Re: [PATCH] mm->rss is modified without page_table_lock held
In-Reply-To: <4.3.2.7.2.20001209111347.00c829f0@mail.tekno-soft.it>
 <4.3.2.7.2.20001209111347.00c829f0@mail.tekno-soft.it> <4.3.2.7.2.20001209152806.00c8e7b0@mail.tekno-soft.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Sat, 09 Dec 2000 15:48:05 +0100
   From: Roberto Fichera <kernel@tekno-soft.it>

   >atomic_t does not guarentee a large enough range necessary for mm->rss

   If we haven't some atomic_t that can be negative we could define atomic_t 
   as unsigned long for all arch,
   this is sufficient to fitting all the range for the mm->rss.

32-bit Sparc has unsigned long as 32-bit, and the top 8 bits of the
atomic_t are used for a spinlock, thus a 27-bit atomic_t, there
is not enough precision.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
