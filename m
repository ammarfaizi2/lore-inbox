Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281797AbRK0WwM>; Tue, 27 Nov 2001 17:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281807AbRK0WwE>; Tue, 27 Nov 2001 17:52:04 -0500
Received: from waste.org ([209.173.204.2]:31898 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S281783AbRK0Wv4>;
	Tue, 27 Nov 2001 17:51:56 -0500
Date: Tue, 27 Nov 2001 16:51:50 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Peter Svensson <petersv@psv.nu>
cc: Bill Davidsen <davidsen@tmr.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Default outgoing IP address?
In-Reply-To: <Pine.LNX.4.33.0111272336290.1086-100000@cheetah.psv.nu>
Message-ID: <Pine.LNX.4.40.0111271650550.10341-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001, Peter Svensson wrote:

> On Tue, 27 Nov 2001, Oliver Xymoron wrote:
>
> > I have a host which has canonical address foo, which also happens to be a
> > gateway. Foo happens to be on the local side of the gateway, so when
> > initiating connections, they appear to be from the gateway interface
> > address, bar. This is inconvenient because bar is an address on a network
> > I don't have DNS authority over, etc., so it'd be nice if outgoing
> > connections by default would appear to come from foo.
>
> This should do the trick, or something similar. It changes the default
> route to prefer another source address if none is set through a bind(2)
> call.
>
>   ip route chg default via $DEF_GW dev $OUTSIDE_DEV src $MY_CANOICAL_SRC
>
> A variation of this (for a slightly different purpose) is used by me.

Figured that out myself about 10 minutes ago. Thanks.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

