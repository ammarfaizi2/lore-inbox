Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130741AbRBPRhp>; Fri, 16 Feb 2001 12:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130431AbRBPRhf>; Fri, 16 Feb 2001 12:37:35 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:33040 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S130740AbRBPRhV>;
	Fri, 16 Feb 2001 12:37:21 -0500
Date: Fri, 16 Feb 2001 18:37:07 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        bcrl@redhat.com
Subject: Re: x86 ptep_get_and_clear question
Message-ID: <20010216183707.A4821@pcep-jamie.cern.ch>
In-Reply-To: <3A8C499A.E0370F63@colorfullife.com> <Pine.LNX.4.10.10102151702320.12656-100000@penguin.transmeta.com> <20010216151839.A3989@pcep-jamie.cern.ch> <3A8D4045.F8F27782@colorfullife.com> <20010216162741.A4284@pcep-jamie.cern.ch> <3A8D4D43.CF589FA0@colorfullife.com> <20010216170029.A4450@pcep-jamie.cern.ch> <3A8D540C.92C66398@colorfullife.com> <20010216174316.A4500@pcep-jamie.cern.ch> <3A8D5F6C.D81F2F28@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A8D5F6C.D81F2F28@colorfullife.com>; from manfred@colorfullife.com on Fri, Feb 16, 2001 at 06:12:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ben, fancy writing a boot-time test?
> > 
> I'd never rely on such a test - what if the cpu checks in 99% of the
> cases, but doesn't handle some cases ('rep movd, everything unaligned,
> ...'.

A good point.  The test results are inconclusive.

> And check the Pentium III erratas. There is one with the tlb
> that's only triggered if 4 instruction lie in a certain window and all
> access memory in the same way of the tlb (EFLAGS incorrect if 'andl
> mask,<memory_addr>' causes page fault)).

Nasty, but I don't see what an obscure and impossible to work around
processor bug has to do with this thread.  It doesn't actually change
page fault handling, does it?

-- Jamie
