Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318851AbSICQTN>; Tue, 3 Sep 2002 12:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318853AbSICQTN>; Tue, 3 Sep 2002 12:19:13 -0400
Received: from ns.suse.de ([213.95.15.193]:14355 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318851AbSICQTL>;
	Tue, 3 Sep 2002 12:19:11 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large block device patch, part 1 of 9
References: <15732.34929.657481.777572@notabene.cse.unsw.edu.au.suse.lists.linux.kernel> <Pine.LNX.4.44.0209030900410.1997-100000@home.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Sep 2002 18:23:43 +0200
In-Reply-To: Linus Torvalds's message of "3 Sep 2002 18:07:05 +0200"
Message-ID: <p73u1l7qbxs.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Tue, 3 Sep 2002, Neil Brown wrote:
> > 
> > Effectively, this is a type-safe cast.  You still get the warning, but
> > it looks more like the C that we are used to.
> 
> I wonder if the right answer isn't to just make things like "__u64" be
> "long long" even on 64-bit architectures (at least those on which it is 64
> bit, of course. I _think_ that's true of all of them). And then just use 
> "llu" for it all.

x86-64 does that already. I did it originally to fix some printk warnings.
But it caused even more. I didn't bother then to change it back. Doesn't
seem to have too many bad side effects at least.

-Andi
