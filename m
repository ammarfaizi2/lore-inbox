Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbRBPRUz>; Fri, 16 Feb 2001 12:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129580AbRBPRUo>; Fri, 16 Feb 2001 12:20:44 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:61958 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S130227AbRBPRUf>;
	Fri, 16 Feb 2001 12:20:35 -0500
Date: Fri, 16 Feb 2001 18:20:20 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        bcrl@redhat.com
Subject: Re: x86 ptep_get_and_clear question
Message-ID: <20010216182020.B4494@pcep-jamie.cern.ch>
In-Reply-To: <3A8C499A.E0370F63@colorfullife.com> <Pine.LNX.4.10.10102151702320.12656-100000@penguin.transmeta.com> <20010216151839.A3989@pcep-jamie.cern.ch> <3A8D4045.F8F27782@colorfullife.com> <20010216162741.A4284@pcep-jamie.cern.ch> <3A8D4D43.CF589FA0@colorfullife.com> <20010216170029.A4450@pcep-jamie.cern.ch> <3A8D540C.92C66398@colorfullife.com> <20010216174316.A4500@pcep-jamie.cern.ch> <3A8D5F6C.D81F2F28@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A8D5F6C.D81F2F28@colorfullife.com>; from manfred@colorfullife.com on Fri, Feb 16, 2001 at 06:12:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> Ok, Is there one case were your pragmatic solutions is vastly faster?

> * mprotect: No. The difference is at most one additional locked
> instruction for each pte.

Oh, what instruction is that?

> * munmap(anon): No. We must handle delayed accessed anyway (don't call
> free_pages_ok() until flush_tlb_ipi returned). The difference is that we
> might have to perform a second pass to clear any spurious 0x40 bits.

That second pass is what I had in mind.

> * munmap(file): No. Second pass required for correct msync behaviour.

It is?

-- Jamie


