Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266921AbRGYMDN>; Wed, 25 Jul 2001 08:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266251AbRGYMDD>; Wed, 25 Jul 2001 08:03:03 -0400
Received: from juicer39.bigpond.com ([139.134.6.96]:53451 "EHLO
	mailin8.bigpond.com") by vger.kernel.org with ESMTP
	id <S266921AbRGYMCr>; Wed, 25 Jul 2001 08:02:47 -0400
Message-Id: <m15PLVv-000CDBC@localhost>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Matt Bernstein <matt@theBachChoir.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 crash with ipchains/netfilter as modules 
In-Reply-To: Your message of "Wed, 25 Jul 2001 11:04:04 +0100."
             <Pine.LNX.4.33.0107251054420.1834-100000@nick.dcs.qmw.ac.uk> 
Date: Wed, 25 Jul 2001 20:03:34 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In message <Pine.LNX.4.33.0107251054420.1834-100000@nick.dcs.qmw.ac.uk> you wri
te:
> ipchains               37568   0  (unused)
> unix                   16992  27  (autoclean)
> 
> ..but "ipchains -L" does produce some output (though it takes many
> minutes), and the kernel has logged some DENY packets. Attempting
> "modprobe -r ipchains" gives the following (possibly meaningless) oops.

Known issue (usage count stays at 0, independent of usage).

Try ipchains -L -n to get your output.

I'll look into the removal code (Al found some loading problems before
which I want to fix anyway)...

Thanks,
Rusty.
--
Premature optmztion is rt of all evl. --DK
