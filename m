Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266579AbRGJP1B>; Tue, 10 Jul 2001 11:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266583AbRGJP0v>; Tue, 10 Jul 2001 11:26:51 -0400
Received: from fire.osdlab.org ([65.201.151.4]:3734 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S266579AbRGJP0l>;
	Tue, 10 Jul 2001 11:26:41 -0400
Message-ID: <3B4B1E91.A7D75608@osdlab.org>
Date: Tue, 10 Jul 2001 08:26:09 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Christoph Hellwig <hch@ns.caldera.de>, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Subject: Re: How many pentium-3 processors does SMP support?
In-Reply-To: <20010711022509.C31966@weta.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Tue, Jul 10, 2001 at 04:19:43PM +0200, Christoph Hellwig wrote:
> 
>     The number of CPUs is currently globally limited to 32 by NR_CPUS in
>     include/linux/threads.h.
> 
> Really?
> 
> <pause>
> 
> Ah, so it is... yes, making this architecture dependant might be a
> good idea. Large PPC and MIPS boxen need to adjust this already. Also,
> someone did a starfire port, I think that had 64 processors, not sure.
> 
>     You can.  But you cannot buy 32-processor PII (-Xeon) systems that are
>     supported by Linux.
> 
> What is the limit here? The 8/16 way SE chipsets?
> 
>     > In anyone from Compaq is reading this, you should send me a 32-way
>     > Xeon ASAP just to prove they really work :)
> 
>     It doesn't.
> 
> Oh, then they definately need to send me one.
> 
> Are these not MP1.4 based? Something different?
> 
>   --cw

For IA32/i386/x86:

The Linus-kernel only supports a maximum of 15 Pentium IIIs
due to APIC addressing (4 bits, with 0xf meaning "broadcast").

Pentium 4 uses 0xff for broadcast, so lots more of them can
be supported (when you can find a P-4 MP server).

I have heard of some IBM/Sequent patches that modify the
logical vs. physical APIC addressing scheme to make 16-way
systems work.

-- 
~Randy
