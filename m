Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRBPOTN>; Fri, 16 Feb 2001 09:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129180AbRBPOTE>; Fri, 16 Feb 2001 09:19:04 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:44550 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129156AbRBPOSw>;
	Fri, 16 Feb 2001 09:18:52 -0500
Date: Fri, 16 Feb 2001 15:18:39 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: x86 ptep_get_and_clear question
Message-ID: <20010216151839.A3989@pcep-jamie.cern.ch>
In-Reply-To: <3A8C499A.E0370F63@colorfullife.com> <Pine.LNX.4.10.10102151702320.12656-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10102151702320.12656-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Feb 15, 2001 at 05:21:28PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> So the only case that ends up being fairly heavy may be a case that is
> very uncommon in practice (only for unmapping shared mappings in
> threaded programs or the lazy TLB case).

I can think of one case where performance is considered quite important:
mprotect() is used by several garbage collectors, including threaded
ones.  Maybe mprotect() isn't the best primitive for those anyway, but
it's what they have to work with atm.

-- Jamie
