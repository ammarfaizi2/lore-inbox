Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131305AbRACWGt>; Wed, 3 Jan 2001 17:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129518AbRACWGb>; Wed, 3 Jan 2001 17:06:31 -0500
Received: from dialin41.pg3-nt.dusseldorf.nikoma.de ([213.54.98.41]:18926 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131353AbRACWGY>; Wed, 3 Jan 2001 17:06:24 -0500
Date: Wed, 3 Jan 2001 23:07:14 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Andrea Baldoni <abaldoni@xcal.net>
cc: <linux-kernel@vger.kernel.org>, <i4ldeveloper@listserv.isdn4linux.de>
Subject: Re: [PATCH] isdn iprofd hang ttyI1...
In-Reply-To: <20010103205834.A9742@xcal.net>
Message-ID: <Pine.LNX.4.30.0101032257340.8073-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Andrea Baldoni wrote:

> The iprofd contained in isdnutils 3.0 use the same buffer and buffer size
> in GETting and SETting via IOCTL IIOC[GS]ETPRF the virtual modem profiles.
>
> The kernel use different sizes, so iprofd set incorrect data, resulting in a
> hang of the ttyI from 1 to last. I suppose the right way to implement profile
> save & restore will be kernel-version independent and maybe I will work on
> that, but at the moment I made the IIOCGETPRF and IIOCSETPRF IOCTLs symmetric:

You're right, that reminds me of one of the rather low priority problems
on my list. iprofd in 2.2 has the same problem, so I suppose there's
nobody using it at all. Your patch looks fine, however I'ld prefer to rip
out support for these ioctls completely. If one really needs it, one can
achieve the same effect entirely from user space anyway. Even with your
patch the current solution is not portable across 2.2 / 2.4 and therefore
not acceptable as-is.

--Kai






-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
