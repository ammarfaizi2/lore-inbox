Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315695AbSETCJe>; Sun, 19 May 2002 22:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315708AbSETCJd>; Sun, 19 May 2002 22:09:33 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:8951 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S315695AbSETCJc>; Sun, 19 May 2002 22:09:32 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15592.23251.419179.408509@wombat.chubb.wattle.id.au>
Date: Mon, 20 May 2002 12:09:23 +1000
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Andrew Morton <akpm@zip.com.au>, Andreas Dilger <adilger@clusterfs.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/15] larger b_size, and misc fixlets
In-Reply-To: <368842013@toto.iv>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Anton" == Anton Altaparmakov <aia21@cantab.net> writes:

>> > Not that I'm a 64-bit system user/developer, but it is my
>> understanding > that u64 == long on a 64-bit platform, so your cast
>> to u64 does not > actually change the type of b_blocknr as far as
>> printk is concerned.  > You would need to cast it to unsigned long
>> long instead.
>> 
>> Yes, I suppose so.  That more closely matches what "%L" does.

Anton> /me can't help it: Didn't I say earlier on that one has to use
Anton> (unsigned) long long and not u64? (-; But noone would listen...

The current C standard guarantees that long long is *at least* 64
bits.

So you're right.  Can we introduce a new pair of types, ull_t and ll_t
to reduce typing?  (unsigned long long) tends to make lines overflow
the 80-char boundary bit much, but (ull_t) is a lot shorter.

Peter C

