Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267558AbTBRCGP>; Mon, 17 Feb 2003 21:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbTBRCGP>; Mon, 17 Feb 2003 21:06:15 -0500
Received: from tapu.f00f.org ([202.49.232.129]:31630 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S267558AbTBRCGN>;
	Mon, 17 Feb 2003 21:06:13 -0500
Date: Mon, 17 Feb 2003 18:16:14 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Linux v2.5.62 --- spontaneous reboots
Message-ID: <20030218021614.GA7924@f00f.org>
References: <20030218015353.GA7844@f00f.org> <Pine.LNX.4.44.0302171752560.1754-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302171752560.1754-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 06:02:03PM -0800, Linus Torvalds wrote:

> Can you check mjb 1-3 too? The better it gets pinpointed, the easier
> it's going to be to find.

Sure... I'll test them later on.

> Also, if you can figure out _which_ part of the patch makes a
> difference, that would obviously be even better.

I'll try to narrow this down.

> Part of the stuff in mjb is already merged in later kernels (ie
> things like using sequence locks for xtime is already there in
> 2.5.60, so clearly that doesn't seem to be the thing that helps your
> situation).

I don't think it's anything really obvious.  If the problem I'm seeing
is the same as the one showing up on *some* IBM NUMA-Q (or whatever
they are) boxen then it's probably not a driver or fs thing --- as we
have nothing in common.

Now... it could be two different problems, except the same kernel
which the IBM people found works for them also works for me.

Oddly, wli has not seen this problem and he's using similar hardware
(I think) to the other IBM people and the same compiler as me.

> Do you use the starfire driver?

Nope.

A stripped down kernel, compile for a 486 with no IO-APIC support (in
an attempt to slow things down and hopefully avoid possible hardware
problems such as overheating) still reboots on me.

The only thing I can think of is a triple-fault...  I'm wondering
about using gcc-3.2 instead of 2.95.4 (Debian blah blort blem) on the
off chance it's a weird compiler problem.



  --cw
