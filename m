Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290646AbSA3WKX>; Wed, 30 Jan 2002 17:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290645AbSA3WJc>; Wed, 30 Jan 2002 17:09:32 -0500
Received: from h152-148-10-6.outland.lucent.com ([152.148.10.6]:50369 "EHLO
	alpo.casc.com") by vger.kernel.org with ESMTP id <S290656AbSA3WJS>;
	Wed, 30 Jan 2002 17:09:18 -0500
From: John Stoffel <stoffel@casc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15448.28224.481925.430169@gargle.gargle.HOWL>
Date: Wed, 30 Jan 2002 17:05:52 -0500
To: Momchil Velikov <velco@fadata.bg>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <87d6zrlefa.fsf@fadata.bg>
In-Reply-To: <Pine.LNX.4.33.0201291515480.1747-100000@penguin.transmeta.com>
	<87d6zrlefa.fsf@fadata.bg>
X-Mailer: VM 6.95 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Momchil> Memory overhead due to allocator overhead is of no concern with the
Momchil> slab allocator. What matters most is probably the overhead of the
Momchil> radix tree nodes themselves, compared to the two pointers in struct
Momchil> page with the hash table approach. rat-4 variant ought to have less
Momchil> overhead compared to rat-7 at the expense of deeper/higher tree. I
Momchil> have no figures for the actual memory usage though. For small files it
Momchil> should be negligible, i.e. one radix tree node, 68 or 516 bytes for
Momchil> rat-4 or rat-7, for a file of size up to 65536 or 524288 bytes.  The
Momchil> worst case would be very large file with a few cached pages with
Momchil> offsets uniformly distributed across the whole file, that is having
Momchil> deep tree with only one page hanging off each leaf node.

Isn't this a good place to use AVL trees then, since they balance
automatically?  Admittedly, it may be more overhead than we want in
the case where the tree is balanced by default anyway.  

Again, benchmarks would be the good thing to see either way.

John

