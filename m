Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132057AbRDYU4r>; Wed, 25 Apr 2001 16:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132399AbRDYU4h>; Wed, 25 Apr 2001 16:56:37 -0400
Received: from mercury.ultramaster.com ([208.222.81.163]:47245 "EHLO
	mercury.ultramaster.com") by vger.kernel.org with ESMTP
	id <S132057AbRDYU4X>; Wed, 25 Apr 2001 16:56:23 -0400
Message-ID: <3AE739F3.EA8AB340@dm.ultramaster.com>
Date: Wed, 25 Apr 2001 16:56:19 -0400
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kapish@ureach.com
CC: linux-kernel@vger.kernel.org
Subject: Re: nfs performance at high loads
In-Reply-To: <200104251905.PAA05417@www20.ureach.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kapish K wrote:
> 
> Hello,
>         I had sent in a note on nfs performance issues some time back,
> and Mark Hemment had been kind enough to point out to the
> zerocopy networking patch. Well, we tried with it, and it does
> seem to have some improvement, but it seems to have screwed up
> nfs performance a bit, because we see a LOT of rpc failures for
> all kinds of calls, starting from lookup, to read and writes.
> Could this possibly be triggered by this patch ( picked up from
> davem's site for 2.4.0 ).
>         On the other hand, we do plan to migrate to 2.4.2. Can somebody
> update me or provide pointers to info. as to whether we can
> expect some of these problems have been resolved in 2.4.2? We
> should soon be testing on 2.4.2
> Thanks
> 

While I'm not an expert hacker or anything, I can tell you for sure,
that even 2.4.2 is full of really system crippling bugs.  You need to
track the current kernels.  All of the 2.4.x series should be
compatible, in other words, you should upgrade as soon as possible to
the latest stable kernel.  Currently, that's 2.4.3 (not 2.4.2).  And
even 2.4.3 has many known bugs that are capable of 1) destroying
performance and 2) destroying filesystems.  

At the very least, you should upgrade to 2.4.3, but better yet would be
to upgrade to the 2.4.4 when it comes out (soon?), or even the 2.4.4-pre
patch since it has the zero copy networking patch already included, as
well as fixes for bugs that could corrupt your filesystems.  The zero
copy patch as it existed for 2.4.0 was also buggy in itself, so that
would explain some of your extended problems.

Really, 2.4.0 is a 'horrible' kernel to be running, as it is missing an
enormous amount of performance fixes, and bug fixes.

David

-- 
David Mansfield                                           (718) 963-2020
david@ultramaster.com
Ultramaster Group, LLC                               www.ultramaster.com
