Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129933AbRAOHPK>; Mon, 15 Jan 2001 02:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130187AbRAOHOw>; Mon, 15 Jan 2001 02:14:52 -0500
Received: from slc111.modem.xmission.com ([166.70.9.111]:62732 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129933AbRAOHOq>; Mon, 15 Jan 2001 02:14:46 -0500
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: Russell King <rmk@arm.linux.org.uk>, riel@nl.linux.org,
        andrea@suse.de (Andrea Arcangeli), linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <m17l40hhtd.fsf@frodo.biederman.org> <200101122111.f0CLBhL10716@flint.arm.linux.org.uk> <20010115005610.E1656@bacchus.dhis.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Jan 2001 23:59:23 -0700
In-Reply-To: Ralf Baechle's message of "Mon, 15 Jan 2001 00:56:10 -0200"
Message-ID: <m1zogtfghg.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle <ralf@uni-koblenz.de> writes:

> On Fri, Jan 12, 2001 at 09:11:43PM +0000, Russell King wrote:
> 
> > Eric W. Biederman writes:
> > > Hmm.  I would think that increasing the logical page size in the kernel
> > > would be the trivial way to handle virtual aliases.  (i.e.) with a large
> > > enough page size you can't actually have a virtual alias.
> > 
> > There are types of caches out there that no matter how large the page size,
> > you will always have alias issues.  These are ones where the cache lines
> > are indexed independent of virtual address (and therefore can have funny
> > cache line replacement algorithms).
> > 
> > And yes, you guessed which processor has it. ;)

Odd.  Does this affect correctness?

> I recently spoke with some CPU architecture researcher at some university
> about cache architectures; I suspect in the near future we'll see more
> funny cache indexing and replacment algorithems ...

But I doubt many of those will run incorrectly if just less efficiently if
the OS doesn't help you avoid aliases.  


Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
