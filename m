Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbRGGD7I>; Fri, 6 Jul 2001 23:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266008AbRGGD66>; Fri, 6 Jul 2001 23:58:58 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:645 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S266004AbRGGD6y>; Fri, 6 Jul 2001 23:58:54 -0400
Date: Fri, 6 Jul 2001 23:58:10 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: "David S. Miller" <davem@redhat.com>
cc: Jes Sorensen <jes@sunsite.dk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
 achi ne
In-Reply-To: <15174.19941.681583.314691@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0107062355070.26274-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2001, David S. Miller wrote:

> What about for drivers of SAC-only devices, they eat the overhead
> when highmem is enabled too?

Yes.  It's not an unreasonable overhead considering that it's configured
out for all the non-highmem kernels that will be shipped.  Keep in mind
that the expected lifespan for 32 bit systems is now less than 3 years, so
elaborate planning that delays implementation buys us nothing more than a
smaller window of usefulness.


> This says nothing about the real reason the IA64 solution is
> unacceptable, the inputs to the mapping functions which must
> be "page+offset+len" triplets as there is no logical "virtual
> address" to pass into the mapping routines on 32-bit systems.

On x86 a 64 bit DMA address cookie is fine.  If you've got concerns, tell
us what you have in mind for a design.


> Face it, the ia64 stuff is not what we can use across the board.  It
> simply doesn't deal with all the necessary issues.  Therefore,
> encouraging driver author's to use this ia64 hacked up scheme is
> not such a hot idea until we have a real API implemented.

So what's the API?

		-ben

