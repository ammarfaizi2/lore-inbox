Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129261AbRBEJ04>; Mon, 5 Feb 2001 04:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129638AbRBEJ0r>; Mon, 5 Feb 2001 04:26:47 -0500
Received: from fungus.teststation.com ([212.32.186.211]:57337 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129261AbRBEJ0j>; Mon, 5 Feb 2001 04:26:39 -0500
Date: Mon, 5 Feb 2001 10:26:28 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Thomas Stewart <T.Stewart@student.umist.ac.uk>,
        Jonathan Morton <chromi@cyberspace.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: d-link dfe-530 tx (bug-report)
In-Reply-To: <3A7E6670.4AD21D20@colorfullife.com>
Message-ID: <Pine.LNX.4.30.0102051007210.28179-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2001, Manfred Spraul wrote:

> 6 ms is quite long:
> I added a reset into tx_timeout, and that function should not take more
> than 1 ms or so.
> Did you find something about the delay in the documentation? Is it
> possible to poll for reset completion?

I don't know how long. For testing I figured it might be nice with a long
delay, and I was hoping 6ms is long enough. If it changes anything, then
you can start working on getting it right. :)

There is a flag that may indicate reset complete (that's why the while
loop is there). It is supposed to do that for normal "CmdReset" so maybe
it does the same for "forced reset". I have no idea if it does.


But the reset doesn't seem to change much anyway.

The MII PHY (miffy?) is not responding but there are a few registers to
play with there. One clear difference is the PHY address, 8 vs 31 (and 31
has some special meaning for some other register).

The new register dumps needs to be examined for any vt6102 specifics that
are disabled.

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
