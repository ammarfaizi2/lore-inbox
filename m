Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281743AbRK0WnC>; Tue, 27 Nov 2001 17:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281788AbRK0Wmw>; Tue, 27 Nov 2001 17:42:52 -0500
Received: from k7g317-2.kam.afb.lu.se ([130.235.57.218]:45061 "EHLO
	cheetah.psv.nu") by vger.kernel.org with ESMTP id <S281743AbRK0Wml>;
	Tue, 27 Nov 2001 17:42:41 -0500
Date: Tue, 27 Nov 2001 23:41:28 +0100 (CET)
From: Peter Svensson <petersv@psv.nu>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Bill Davidsen <davidsen@tmr.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Default outgoing IP address?
In-Reply-To: <Pine.LNX.4.40.0111271435500.10341-100000@waste.org>
Message-ID: <Pine.LNX.4.33.0111272336290.1086-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001, Oliver Xymoron wrote:

> I have a host which has canonical address foo, which also happens to be a
> gateway. Foo happens to be on the local side of the gateway, so when
> initiating connections, they appear to be from the gateway interface
> address, bar. This is inconvenient because bar is an address on a network
> I don't have DNS authority over, etc., so it'd be nice if outgoing
> connections by default would appear to come from foo.

This should do the trick, or something similar. It changes the default 
route to prefer another source address if none is set through a bind(2) 
call.

  ip route chg default via $DEF_GW dev $OUTSIDE_DEV src $MY_CANOICAL_SRC

A variation of this (for a slightly different purpose) is used by me. 

Peter
--
Peter Svensson      ! Pgp key available by finger, fingerprint:
<petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
------------------------------------------------------------------------
Remember, Luke, your source will be with you... always...


