Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbUDHRSz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 13:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbUDHRSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 13:18:55 -0400
Received: from zero.aec.at ([193.170.194.10]:44554 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262064AbUDHRSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 13:18:54 -0400
To: "Mathieu Giguere" <Mathieu.Giguere@ericsson.ca>
cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: IPv4 and IPv6 stack multi-FIB, scalable in the million of
 entries.
References: <1IJuR-8qH-39@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 08 Apr 2004 19:18:41 +0200
In-Reply-To: <1IJuR-8qH-39@gated-at.bofh.it> (Mathieu Giguere's message of
 "Thu, 08 Apr 2004 17:21:01 +0200")
Message-ID: <m3ptaiwfpq.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mathieu Giguere" <Mathieu.Giguere@ericsson.ca> writes:

[you should probably discuss that on netdev@oss.sgi.com instead, cc'ed]

>     We currently looking for a multi-FIB, scalable routing table in the
> million of entries, no routing cache for IPv4 and IPv6.  We want a IP stack

No routing cache? Doesn't sound like a good idea.

> that can have a log(n) (or better) insertion/deletion and lookup
> performance.  Predictable performance, even in the million of entries.

And even more vast overkill for most linux users than the existing
routing code already is.  Linux has at least the beginnings of a pluggable
FIB interface (fib_table), which has slightly bit rotted, but probably
not too bad. I would suggest you clean that up, make the existing
hash table really optional and then you can just plug in anything you want.

>     I join a patch with the fib_hash in IPv4 replace with a patricia tree
> ready for multi-FIB base on a 2.4.22 kernel.  This is the beginning of a
> long cleanup.

What do you consider dirty in the current stack? 

-Andi

