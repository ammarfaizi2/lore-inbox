Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129710AbQLIPoJ>; Sat, 9 Dec 2000 10:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129781AbQLIPoA>; Sat, 9 Dec 2000 10:44:00 -0500
Received: from isolaweb.it ([213.82.132.2]:15626 "EHLO web.isolaweb.it")
	by vger.kernel.org with ESMTP id <S129710AbQLIPnt>;
	Sat, 9 Dec 2000 10:43:49 -0500
Message-Id: <4.3.2.7.2.20001209160215.00c901e0@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 09 Dec 2000 16:07:03 +0100
To: "David S. Miller" <davem@redhat.com>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: [PATCH] mm->rss is modified without page_table_lock held
Cc: rasmus@jaquet.dk, torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <200012091442.GAA20532@pizda.ninka.net>
In-Reply-To: <4.3.2.7.2.20001209152806.00c8e7b0@mail.tekno-soft.it>
 <4.3.2.7.2.20001209111347.00c829f0@mail.tekno-soft.it>
 <4.3.2.7.2.20001209111347.00c829f0@mail.tekno-soft.it>
 <4.3.2.7.2.20001209152806.00c8e7b0@mail.tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06.42 09/12/00 -0800, David S. Miller wrote:

>    Date: Sat, 09 Dec 2000 15:48:05 +0100
>    From: Roberto Fichera <kernel@tekno-soft.it>
>
>    >atomic_t does not guarentee a large enough range necessary for mm->rss
>
>    If we haven't some atomic_t that can be negative we could define atomic_t
>    as unsigned long for all arch,
>    this is sufficient to fitting all the range for the mm->rss.
>
>32-bit Sparc has unsigned long as 32-bit, and the top 8 bits of the
>atomic_t are used for a spinlock, thus a 27-bit atomic_t, there
>is not enough precision.

8 bits for a spinlock ? What kind of use we have here ? All arch except Sparc32
don't have this trick.

Roberto Fichera.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
