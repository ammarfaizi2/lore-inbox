Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268175AbTBXGcS>; Mon, 24 Feb 2003 01:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268177AbTBXGcS>; Mon, 24 Feb 2003 01:32:18 -0500
Received: from holomorphy.com ([66.224.33.161]:22191 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268175AbTBXGcR>;
	Mon, 24 Feb 2003 01:32:17 -0500
Date: Sun, 23 Feb 2003 22:41:28 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Val Henson <val@nmt.edu>
Cc: Bill Davidsen <davidsen@tmr.com>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224064128.GM10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Val Henson <val@nmt.edu>, Bill Davidsen <davidsen@tmr.com>,
	Larry McVoy <lm@bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030222231552.GA31268@work.bitmover.com> <Pine.LNX.3.96.1030223183404.999F-100000@gatekeeper.tmr.com> <20030224062230.GD16803@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224062230.GD16803@boardwalk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 06:57:09PM -0500, Bill Davidsen wrote:
>> Clearly. And things which require more locking will pay some penalty for
>> this. But a quick scan of this list on keyword "lockless' will show that
>> people are thinking about this.

On Sun, Feb 23, 2003 at 11:22:30PM -0700, Val Henson wrote:
> Lockless algorithms still generate bus traffic when you do the atomic
> compare-and-swap or load-linked or whatever hardware instruction you
> use to implement your lockless algorithm.  Caches still have to stay
> coherent, lock or no lock.

Not all lockless algorithms operate on the "access everything with
atomic operations" principle. RCU, for example, uses no atomic
operations on the read side, which is actually fewer atomic operations
than standard rwlocks use for the read side.


-- wli
