Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131814AbQLVKcA>; Fri, 22 Dec 2000 05:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131925AbQLVKbu>; Fri, 22 Dec 2000 05:31:50 -0500
Received: from [194.213.32.137] ([194.213.32.137]:3588 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131814AbQLVKbh>;
	Fri, 22 Dec 2000 05:31:37 -0500
Message-ID: <20001221210637.C1545@bug.ucw.cz>
Date: Thu, 21 Dec 2000 21:06:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>, Steve Grubb <ddata@gate.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] performance enhancement for simple_strtoul
In-Reply-To: <000e01c06a8e$6945db60$bc1a24cf@master> <20001220100446.A1249@inetnebr.com> <001401c06ab4$ac8615e0$7d1a24cf@master> <20001221010935.A22817@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001221010935.A22817@pcep-jamie.cern.ch>; from Jamie Lokier on Thu, Dec 21, 2000 at 01:09:35AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It seems gcc creates much better code with the variables set to register
> > types.
> 
> Curious.  GCC should be generating the same code regardless; ah well.
> 
> Is strtoul actually used in the kernel other than for the occasional
> (rare) write to /proc/sys and parsing boot options?
> 
> > But this is the kernel and there are people that would reject my patch
> > purely on the basis that it adds precious bytes to the kernel.
> 
> Perhaps I am mistaken but I'd expect it to be called what, ten times at
> boot time, and a couple of times when X loads the MTRRs?

On second thought, ps -auxl maybe stresses simple_strtoul a little
bit. Not sure.

> Sounds like the neatest trick would be reducing bytes used here...

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
