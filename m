Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279144AbRKMVIp>; Tue, 13 Nov 2001 16:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279156AbRKMVIf>; Tue, 13 Nov 2001 16:08:35 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:15503 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S279144AbRKMVIZ> convert rfc822-to-8bit;
	Tue, 13 Nov 2001 16:08:25 -0500
Date: Tue, 13 Nov 2001 16:08:24 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Martin Eriksson <nitrax@giron.wox.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: What Athlon chipset is most stable in Linux?
In-Reply-To: <001201c16c45$dc2b6820$0201a8c0@HOMER>
Message-ID: <Pine.LNX.4.30.0111131559580.8219-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001, Martin Eriksson wrote:

> I'm hearing rumours about my University wanting to set up a cluster with AMD
> Athlon XP+DDR computers, so I wonder what chipset is most stable under
> Linux?
>
> I assume it's the AMD DDR chipset, but I want to be pretty sure.
>
> Btw, do compilators currently optimize for the third floating-point unit in
> Athlon XP processors?

Well, here's my little anecdote:

We bought 33 1.4 GHz AMD Athlons (non-XP) with the slightly deprecated VIA
KT266 Chipset (Spacewalker AK31 motherboards.. not exactly the Lexus of
the M/B world but oh well)..

Anyway, after trying various (2.4) kernel versions, both with and without
the new VM, both with and without Alan's magik, I can say that the only
way we got 99% uptime on these systems (as opposed to like the 70% uptime
I was getting from random kernel oopses) was to turn any Athlon and/or
Pentium optimizations off when compiling the kernel.  With any form of
compilation for a CPU >386, the kernel would crash on at least 2 of the
boxes per day.  The oops stack trace seemed to always indicate a crash
when in the paging code.. so it was a virtual memory problem? (I can only
speculate and I haven't bothered to investigate much further).  I am not
sure if I encountered some unknown bug in my motherboard that needs some
yet undiscovered workaround or what.  All I can say is stay away from the
KT266 chipset (however the newer KT266A seems to work fine based on what I
have seen and am told) if you can.  But then again I may be crazy and/or
there may be workarounds or bios fixes for my problem, if it was really
kernel-related. (I suspect it was, but haven't bothered to figure out
exactly how to reproduce it so as to submit a patch.. the systems would
crash randomly and invesitigating it futher seemed onerous).

-Calin

>
> _____________________________________________________
> |  Martin Eriksson <nitrax@giron.wox.org>
> |  MSc CSE student, department of Computing Science
> |  Umeå University, Sweden
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

