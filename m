Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262640AbRE3Hgv>; Wed, 30 May 2001 03:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262641AbRE3Hgl>; Wed, 30 May 2001 03:36:41 -0400
Received: from t2.redhat.com ([199.183.24.243]:753 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S262640AbRE3Hgi>; Wed, 30 May 2001 03:36:38 -0400
To: Feng Xian <fxian@fxian.jukie.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.3-ac14 spinlock problem? 
In-Reply-To: Message from Feng Xian <fxian@fxian.jukie.net> 
   of "Tue, 29 May 2001 15:52:47 EDT." <Pine.LNX.4.33.0105291550400.28008-100000@tiger> 
Date: Wed, 30 May 2001 08:36:36 +0100
Message-ID: <12317.991208196@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I was running something on my Dell dual p3 box (optiplex gx300). my kernel
> is linux-2.4.3-ac14. I got the following message:

How often did this message occur?

> __rwsem_do_wake(): wait_list unexpectedly empty
> [4191] c5966f60 = { 00000001 })
> kenel BUG at rwsem.c:99!
> invalid operand: 0000
> CPU:            1
> EIP:            0010:[<c0236b99>]
> EFLAGS: 00010282
> kenel BUG at /usr/src/2.4.3-ac14/include/asm/spinlock.h:104!
> 
> 
> I upgrade the kernel to 2.4.5, no such problem any more.

I suspect something else corrupted the rw-semaphore structure, but that's very
hard to prove unless you catch it in the act. If it happens again with any
frequency, you might want to try turning on rwsem debugging.

David
