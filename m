Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274191AbRISVOP>; Wed, 19 Sep 2001 17:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274193AbRISVN4>; Wed, 19 Sep 2001 17:13:56 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:7930 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S274191AbRISVNk>; Wed, 19 Sep 2001 17:13:40 -0400
Date: Wed, 19 Sep 2001 17:14:04 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Manfred Spraul <manfred@colorfullife.com>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem
Message-ID: <20010919171404.A5932@redhat.com>
In-Reply-To: <torvalds@transmeta.com> <5079.1000911203@warthog.cambridge.redhat.com> <20010919200357.Z720@athlon.random> <20010919141656.A5021@redhat.com> <20010919204546.K720@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010919204546.K720@athlon.random>; from andrea@suse.de on Wed, Sep 19, 2001 at 08:45:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 08:45:46PM +0200, Andrea Arcangeli wrote:
> To be pedantic the only idea I shared with the old code (but that's just
> the idea, not the implementation, so AFIK only a patent on such idea
> could protect it from its free usage usage) is to return the rwsem again
> from rwsem_wake and friends to avoid saving it in the asm slow path, and
> I written that:

Your patch moved a bunch of code into asm-i386/rwsem_xchgadd.h.  That 
code was derived from the spinlock code by me into the first rwsems, 
then David reworked bits of it, as wel as you.  But there is no 
copyright on that file indicating this heritage.  If you look at 
how strict commercial copyright control can be, even copying a 
single line of code mentally by retyping it can still mandate the 
copyright legacy.  I'm sure it's just an oversight, but it's 
probably one we *all* need to be reminded of every now and again.

		-ben
