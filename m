Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277585AbRJVSj7>; Mon, 22 Oct 2001 14:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277601AbRJVSjx>; Mon, 22 Oct 2001 14:39:53 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:23044 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S277576AbRJVSjG>; Mon, 22 Oct 2001 14:39:06 -0400
Date: Mon, 22 Oct 2001 14:39:40 -0400
Message-Id: <200110221839.f9MIdeJ16069@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Knob turning on mtest01 for 2.4.13-pre5aa1
X-Newsgroups: linux.dev.kernel
In-Reply-To: <20011022141923.K26029@athlon.random>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011022141923.K26029@athlon.random> andrea@suse.de wrote:

>Cool. this just proofs the vm_mapped_ratio logic is not worthwhile (I
>had similar results here so this just confirms).  So I'm killing it
>enterely (Linus was completly right that it wans't worthwhile). I'm also
>changing a bit the semantics of vm_balance_ratio (similar to pre3aa1)
>and I'm lowering it down due the slight change of semantics, plus I'm
>including the PG_launder (that resembles the PG_wait_for_IO logic in
>pre3aa1) and slightly modified BH_wait_IO logic from Linus. Hopefully
>the end result will be positive.
>
>Thanks very much for this great feedback! :)

  If you think that one test under one set of conditions proves that
user tuning is worthless, then remove OOM, as I can prove there are
cases where things work as well without it.

  To be honest I don't think that running a single player process while
running memory tests is representative of typical usage. Someone on a
small memory machine with memory pressure spread over multiple processes
would be better, and sudden program growth is also a reasonable thing to
expect, such as opening large files in an editor, entering a busy
newsgroup for the first time, opening a large image with gimp, etc.
These loads are things which users commonly do, and tuning parameters
for better responsiveness is certainly as valuable as running a test
with a numeric output. Sluggish system is one thing I do notice with
most Linux kernels on memory challenged machines.

  I think it would be worth waiting for a bit of additional feedback on
"feel" would be useful before adopting the Windows "system knows best"
approach.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.

