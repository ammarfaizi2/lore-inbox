Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <156235-27243>; Fri, 28 Aug 1998 05:54:22 -0400
Received: from portofix.ida.liu.se ([130.236.177.25]:55970 "EHLO portofix.ida.liu.se" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <156448-27243>; Fri, 28 Aug 1998 03:16:47 -0400
Message-Id: <199808280906.LAA13808@portofix.ida.liu.se>
To: davem@dm.cobaltmicro.com
cc: linux-kernel@vger.rutgers.edu
Subject: "fuzzy hashing" = skiplists in a different shape
Date: Fri, 28 Aug 1998 11:06:33 +0200
From: Patrik Hagglund <patha@ida.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux-kernel@vger.rutgers.edu

I saw your "fuzzy hashing" implementation on Linux Weekly News
yesterday, and to me it looks much like randomized skip list. The
neigbour_next list is the first level pointer chain and hash_next is
the second level. But, there is a notable exception. Your code
contians 16 second-level lists, that is, 15 redundant ones.

> it will be as fast or cheaper _even_ in the common case than what we
> have now

? What is this common case. I can't see how your implementation would
be faster than a good implementation of a balanced search tree.

Regards,
Patrik Hägglund,
intrested in data structures and algorithms,
but not a kernel hacker (yet)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
