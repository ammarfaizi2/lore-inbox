Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263052AbUKTFmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbUKTFmU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 00:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbUKTFkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 00:40:18 -0500
Received: from holomorphy.com ([207.189.100.168]:44162 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261774AbUKTFiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 00:38:18 -0500
Date: Fri, 19 Nov 2004 21:38:02 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
Message-ID: <20041120053802.GL2714@holomorphy.com>
References: <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com> <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411191155180.2222@ppc970.osdl.org> <20041120020306.GA2714@holomorphy.com> <419EBBE0.4010303@yahoo.com.au> <20041120035510.GH2714@holomorphy.com> <419EC205.5030604@yahoo.com.au> <20041120042340.GJ2714@holomorphy.com> <419EC829.4040704@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419EC829.4040704@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Very, very wrong. The tasklist scans hold the read side of the lock
>> and aren't even what's running with interrupts off. The contenders
>> on the write side are what the NMI oopser oopses.

On Sat, Nov 20, 2004 at 03:29:29PM +1100, Nick Piggin wrote:
> *blinks*
> So explain how this is "very very wrong", then?

There isn't anything left to explain. So if there's a question, be
specific about it.


William Lee Irwin III wrote:
>> And supposing the arch reenables interrupts in the write side's
>> spinloop, you just get a box that silently goes out of service for
>> extended periods of time, breaking cluster membership and more. The
>> NMI oopser is just the report of the problem, not the problem itself.
>> It's not a false report. The box is dead for > 5s at a time.

On Sat, Nov 20, 2004 at 03:29:29PM +1100, Nick Piggin wrote:
> The point is, adding a for-each-thread loop or two in /proc isn't
> going to cause a problem that isn't already there.
> If you had zero for-each-thread loops then you might have a valid
> complaint. Seeing as you have more than zero, with slim chances of
> reducing that number, then there is no valid complaint.

This entire line of argument is bogus. A preexisting bug of a similar
nature is not grounds for deliberately introducing any bug.


-- wli
