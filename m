Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129083AbQJaURw>; Tue, 31 Oct 2000 15:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129074AbQJaURn>; Tue, 31 Oct 2000 15:17:43 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:40458 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129050AbQJaURc>; Tue, 31 Oct 2000 15:17:32 -0500
Message-ID: <39FF27F9.8DE77CFA@timpanogas.org>
Date: Tue, 31 Oct 2000 13:13:45 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030022024.B20023@vger.timpanogas.org> <Pine.LNX.4.21.0010301142040.3186-100000@elte.hu> <20001030023814.B20102@vger.timpanogas.org> <20001031195012.A138@bug.ucw.cz> <39FF2663.816B8E92@timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"Jeff V. Merkey" wrote:
> 
> Pavel Machek wrote:
> >
> > Hi!
> >
> > > > > This is putrid. NetWare does 353,00,000/second on a Xenon, pumping out
> > > > > gobs of packets in between them. MANOS does 857,000,000/second. This
> > > > > is terrible. No wonder it's so f_cking slow!!!
> > >
> > > And please check your numbers, 857 million
> > > > context switches per second means that on a 1 GHZ CPU you do one context
> > > > switch per 1.16 clock cycles. Wow!
> > >
> > > Excuse me, 857,000,000 instructions executed and 460,000,000 context
> > > switches
> > > a second -- on a PII system at 350 Mhz.  It's due to AGI
> > > optimization.
> >
> > That's more than one context switch per clock. I do not think
> > so. Really go and check those numbers.
> 
> Pavel,  The optimization exploits the multiple piplines in Intel's
> processors,
> and yes, it does execute more than one instruction per clock, it's
> optimized
> to execute in the processors parallel pipelines.  The EMON numbers are
> accurate,
> and you can download the kernel and verify for yourself.  These types of
> optimizations
> are possible when people have acccess to Intel Red Cover documents, then
> you
> get to know just how Intel's internal architectures are affected by
> different coding optimizations.
> 
> Jeff

There's also another optimization in this kernel that allows it to
achieve greater than
100% scaling per processor by using a strong affinity algorithm (I hold
the patent 
on this algorithimn, and by posting code based on it under the GPL, I
have released
it to the general public).  

It relies on an anomoly in the design of Intel's cache controllers, and
with memory based
applications, I can get 120% scaling per procesoor by jugling the
working set of 
executable code cached accros each processor.  There's sample code with
this kernel 
you can use to verify....

:-)

Jeff


> >                                                                 Pavel
> > --
> > I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
> > Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
