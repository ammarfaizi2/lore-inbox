Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268337AbTBYV2H>; Tue, 25 Feb 2003 16:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268368AbTBYV2H>; Tue, 25 Feb 2003 16:28:07 -0500
Received: from ms-smtp-01.tampabay.rr.com ([65.32.1.43]:8066 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S268337AbTBYV07>; Tue, 25 Feb 2003 16:26:59 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: "Chris Wedgwood" <cw@f00f.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Larry McVoy" <lm@bitmover.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Minutes from Feb 21 LSE Call
Date: Tue, 25 Feb 2003 16:38:38 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJGEPLEPAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20030225211933.GA21870@f00f.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
SRL>HT is not the same thing as SMP; while the chip may appear to be
SRL>two processors, it is actually equivalent 1.1 to 1.3 processors,
SRL>depending on the application.
>
CW> You can't have non-integer numbers of processors.  HT is a hack
CW> that makes what appears to be two processors using common
CW> silicon.

I'm aware of that. ;) I'm well aware of the architecture needed to support
HT.

> The fact it's slower than a really dual CPU box is irrelevant in some
> sense, you still need SMP smart to deal with it; it's only important
> when you want to know why performance increases aren't apparent or you
> loose performance in some cases... (ie. other virtual CPU thrashing
> the cache).

Performance differences *are* quite relevant when it comes to thread
scheduling; the two virtual CPUS are not necessarily equivalent in
performnace.

> As Alan pointed out, since the 'Walmart' class hardware is 'whatever
> is cheapest' then perhaps HT/SMT/whatever won't be common place for
> super-low end boxes in two years --- but I would be surprised if it
> didn't gain considerable market share elsewhere.

I suspect HT/SMT be common for people who have multimedia systems, for video
editing and high-end gaming.

I doubt we'll see SMT toasters, though.

> UP != HT

An HT system is still a single, phsyical processor; HT is not equivalent to
a multicore chip, either. Much depends on memory and connection models; a
dual-core chip may be faster or slower than two similar physical SMP
processors. depending on the architecture.

I was speaking in terms of Intel's push to add HT to all of their P4s.
Systems with a single CPU will likely have HT; that still doesn't make them
as powerful as a true dual processor (or dual core CPU) system.

> HT is SMP with magic requirements.  For multiple physical CPUs the
> requirements become even more complex; you want to try to group tasks
> to physical CPUs, not logical ones lest you thrash the cache.

Eaxctly. This is why HT is not the same thing as two physical CPUs. The OS
must be aware of this the effectively schedule jobs. So I think we generally
agree.

> If HT does become more common and similar things abound, I'm not sure
> if it even makes sense to have a UP kernel for certain platforms
> and/or CPUs --- since a mere BIOS change will affect what is
> 'virtually' apparent to the OS.

A good point.

..Scott

