Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292187AbSBBCOm>; Fri, 1 Feb 2002 21:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292188AbSBBCOc>; Fri, 1 Feb 2002 21:14:32 -0500
Received: from tapu.f00f.org ([63.108.153.39]:46269 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S292187AbSBBCOU>;
	Fri, 1 Feb 2002 21:14:20 -0500
Date: Fri, 1 Feb 2002 18:12:59 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, vandrove@vc.cvut.cz,
        torvalds@transmeta.com, garzik@havoc.gtf.org,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
        ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020202021242.GA6770@tapu.f00f.org>
In-Reply-To: <20020131.145904.41634460.davem@redhat.com> <E16WQYs-0003Ux-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16WQYs-0003Ux-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 11:24:10PM +0000, Alan Cox wrote:

    Because 100 4K drivers suddenly becomes 0.5Mb. There are those of
    us trying to stuff Linux into embedded devices who if anything
    want more configuration options not people taking stuff out.

Well, I'm more or less in agreement here, especially when working with
small embedded devices which have a few (say 16 or 32) MB of RAM for
EVERYTHING, kernel, userspace AND filesystems.

However, I wonder if we can't have the linker remove unnecessary and
unreferences objects, functions and variables?

    What I'd much rather see if this is an issue is:

    bool	'Do you want to customise for a very small system'

_IF_ the linker can remove things, it would simplify this too --- we
could if a few important places produce code slightly differently to
favour speed over size and not reference various things.  Also, the
above option would turn-off inlining as that seems to makie quite a
difference at times (BTW, I'm not sure about this, but it seems gcc
and C99 don't agree with static/extern inline semantics?)



  --cw
