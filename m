Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130393AbQLIXKU>; Sat, 9 Dec 2000 18:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131160AbQLIXKK>; Sat, 9 Dec 2000 18:10:10 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:1284 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S130393AbQLIXJ4>;
	Sat, 9 Dec 2000 18:09:56 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200012092238.eB9Mcx4118840@saturn.cs.uml.edu>
Subject: Re: [PATCH] mm->rss is modified without page_table_lock held
To: davem@redhat.com (David S. Miller)
Date: Sat, 9 Dec 2000 17:38:59 -0500 (EST)
Cc: kernel@tekno-soft.it, rasmus@jaquet.dk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <200012091442.GAA20532@pizda.ninka.net> from "David S. Miller" at Dec 09, 2000 06:42:38 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 32-bit Sparc has unsigned long as 32-bit, and the top 8 bits of the
> atomic_t are used for a spinlock, thus a 27-bit atomic_t, there
> is not enough precision.

So the SPARC port is broken. It is just sick to have this "feature"
screw things up for all the ports with a proper atomic_t.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
