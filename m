Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <153887-27243>; Fri, 28 Aug 1998 17:53:31 -0400
Received: from dm.cobaltmicro.com ([209.133.34.35]:1235 "EHLO dm.cobaltmicro.com" ident: "IDENT-NONSENSE") by vger.rutgers.edu with ESMTP id <157339-27243>; Fri, 28 Aug 1998 15:37:00 -0400
Date: Fri, 28 Aug 1998 14:06:33 -0700
Message-Id: <199808282106.OAA06177@dm.cobaltmicro.com>
From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: patha@ida.liu.se
CC: linux-kernel@vger.rutgers.edu
In-reply-to: <199808280906.LAA13808@portofix.ida.liu.se> (message from Patrik Hagglund on Fri, 28 Aug 1998 11:06:33 +0200)
Subject: Re: "fuzzy hashing" = skiplists in a different shape
References: <199808280906.LAA13808@portofix.ida.liu.se>
Sender: owner-linux-kernel@vger.rutgers.edu

   Date: Fri, 28 Aug 1998 11:06:33 +0200
   From: Patrik Hagglund <patha@ida.liu.se>

   ? What is this common case. I can't see how your implementation would
   be faster than a good implementation of a balanced search tree.

You said the answer, I don't have to balance anything, so
insert/delete don't cost so much like trees requiring balancing do.

I would suggest that people run through some examples, ie. take
/proc/{pid}/maps for some large process with many attachments, like
emacs or something, have a little test program setup the data
structures as if vma_insert was called in sequence for each vma, and
then pick arbitrary addresses and see what find_vma() does and how
quickly it finds the answer.

Or just print little ascii visualiziations from your test program and
try to figure out for yourself with the picture it outputs why it is
so impressive an algorithm and why it kicks the shit out of any tree
based solution for this class of problems.

Later,
David S. Miller
davem@dm.cobaltmicro.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
