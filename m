Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbUKVQa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbUKVQa1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbUKVQ3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:29:40 -0500
Received: from [213.85.13.118] ([213.85.13.118]:3202 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S262154AbUKVPvV (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:51:21 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16802.2779.846726.814048@gargle.gargle.HOWL>
Date: Mon, 22 Nov 2004 18:50:51 +0300
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, <Linux-Kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [PATCH]: 2/4 mm/swap.c cleanup
In-Reply-To: <Pine.LNX.4.44.0411221419100.2867-100000@localhost.localdomain>
References: <16801.6313.996546.52706@gargle.gargle.HOWL>
	<Pine.LNX.4.44.0411221419100.2867-100000@localhost.localdomain>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins writes:
 > On Mon, 22 Nov 2004, Nikita Danilov wrote:
 > > Andrew Morton writes:
 > >  > 
 > >  > Sorry, this looks more like a dirtyup to me ;)
 > > 
 > > Don't tell me you are not great fan on comma operator abuse. :)
 > > 
 > > Anyway, idea is that by hiding complexity it loop macro, we get rid of a
 > > maze of pvec-loops in swap.c all alike.
 > > 
 > > Attached is next, more typeful variant. Compilebootentested.
 > 
 > You're scaring me, Nikita.  Those loops in mm/swap.c are easy to follow,
 > whyever do you want to obfuscate them with your own macro maze?

Because my intellectual capacity is limited, and it has little room left
for analyzing _multiple_ zone-lock-tracking sequences. It seems cleaner
to do this once, but as you put is elsewhere "it is a matter of personal
taste".

Besides, after I was recently subjected to looking at BSD kernel code, I
have morbid fear or any kind of mostly similar chunks of code
cut-n-pasted and then modified independently.

 > 
 > Ingenious for_each macros make sense where it's an idiom which is going
 > to be useful to many across the tree; but these are just a few instances
 > in a single source file.

Yes, this makes sense.

 > 
 > Please find a better outlet for your talents!

Heh, you know, from a few VM patches I have in the queue, I started
submitting least controversial ones. :)

 > 
 > Hugh

Nikita.
