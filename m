Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129821AbQLINTA>; Sat, 9 Dec 2000 08:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130032AbQLINSv>; Sat, 9 Dec 2000 08:18:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5768 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129821AbQLINSq>;
	Sat, 9 Dec 2000 08:18:46 -0500
Date: Sat, 9 Dec 2000 04:32:21 -0800
Message-Id: <200012091232.EAA17524@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: kernel@tekno-soft.it
CC: rasmus@jaquet.dk, torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20001209111347.00c829f0@mail.tekno-soft.it> (message
	from Roberto Fichera on Sat, 09 Dec 2000 11:25:09 +0100)
Subject: Re: [PATCH] mm->rss is modified without page_table_lock held
In-Reply-To: <4.3.2.7.2.20001209111347.00c829f0@mail.tekno-soft.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Sat, 09 Dec 2000 11:25:09 +0100
   From: Roberto Fichera <kernel@tekno-soft.it>

   Why we couldn't use atomic_inc(&mm->rss) here and below, avoiding to wrap
   the inc with a spin_lock()/spin_unlock() ?

atomic_t does not guarentee a large enough range necessary for mm->rss

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
