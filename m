Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262346AbSJNW0C>; Mon, 14 Oct 2002 18:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262354AbSJNW0C>; Mon, 14 Oct 2002 18:26:02 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:31171 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262346AbSJNW0B>; Mon, 14 Oct 2002 18:26:01 -0400
Date: Mon, 14 Oct 2002 15:27:28 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Summit support for 2.5 - now with subarch! [0/5]
Message-ID: <76800000.1034634448@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I redid this with subarch support. It's now new and shiny and gets
whites whiter. Actually came out smaller and cleaner, so maybe doing
The Right Thing (tm) is good sometimes ;-) Retested.

This set of 5 patches puts in the core support for the Summit chipset
used by IBM x440 machines - this is a major new platform for IBM, and
we'd really like to have it supported in 2.6 ... the changes are actually
pretty small, it keys off a lot of the same stuff as the NUMA-Q.

I've taken James Cleverdon's patches (he did all the hard work on this)
and split it into bite-sized chunks, where each patch is small, confined
and (IMHO) easily readable, and it should be easy to see it won't break
anything else. 

I've dropped some cleanup work that he did - you seem to like that seperate 
from features, and I agree ... it's much easier to read the patches like this.
I will invest some serious effort and time in cleanup after the feature freeze,
including investigating using the subarch support which I know some people
would like to see done.

There is an x86_summit switch variable which is needed because
distributions want the same kernel to boot on Summit as other platforms. For
most people, just leaving CONFIG_X86_SUMMIT turned off will give them
exactly the same code as they had before, with no switching. Alan wanted
it to work this way to make debugging easier, and simplify the common case.

I've also tested these on a standard desktop PC, a standard 4-way SMP box,
and a 16-way NUMA-Q (against 2.5.42). No problems found.

Please apply!

Thanks,

Martin.
