Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278414AbRJMVYR>; Sat, 13 Oct 2001 17:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278415AbRJMVYI>; Sat, 13 Oct 2001 17:24:08 -0400
Received: from [202.135.142.194] ([202.135.142.194]:36365 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S278414AbRJMVYC>; Sat, 13 Oct 2001 17:24:02 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: dipankar@beaverton.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion 
In-Reply-To: Your message of "Sat, 13 Oct 2001 10:23:23 PDT."
             <Pine.LNX.4.33.0110131015410.8707-100000@penguin.transmeta.com> 
Date: Sun, 14 Oct 2001 07:19:54 +1000
Message-Id: <E15sWCI-0005tP-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33.0110131015410.8707-100000@penguin.transmeta.com> you 
write:
> 
>  (b) the whole notiong of "scheduling point" is a lot too fragile to be
>      acceptable for important data structures. It breaks with the
>      pre-emption patches on UP, and we've seen many times how hard it is
>      for developers to notice even when there _is_ an explicit "end
>      critical region now"  kind of thing

Yeah, if you can't get locking right, you can't get RCU right.  I've
shown you that using it in place of standard locking is simple: the
ONLY added issue is being careful not to screw readers while doing the
actual insert/delete.

Where, if anywhere, is this worth it?  Good question: 3% on 4-way
dbench doesn't cut it in my book...

Rusty.
--
Premature optmztion is rt of all evl. --DK
