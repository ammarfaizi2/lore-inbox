Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266531AbRGGUeZ>; Sat, 7 Jul 2001 16:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266536AbRGGUeP>; Sat, 7 Jul 2001 16:34:15 -0400
Received: from toscano.org ([64.50.191.142]:63680 "HELO bubba.toscano.org")
	by vger.kernel.org with SMTP id <S266531AbRGGUd7>;
	Sat, 7 Jul 2001 16:33:59 -0400
Date: Sat, 7 Jul 2001 16:34:00 -0400
From: Pete Toscano <pete.lkml@toscano.org>
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Hi all, a strange full lock in SMP-kernel 2.4.6 and 2.4.5
Message-ID: <20010707163400.B3983@bubba.toscano.org>
Mail-Followup-To: Pete Toscano <pete.lkml@toscano.org>,
	kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010707021356.A2232@eresmas.net> <20010706235324.A19386@bubba.toscano.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010706235324.A19386@bubba.toscano.org>; from pete.lkml@toscano.org on Fri, Jul 06, 2001 at 11:53:24PM -0400
X-Unexpected: The Spanish Inquisition
X-Uptime: 4:31pm  up  1:02,  2 users,  load average: 0.04, 0.10, 0.20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to follow up to myself, after futher testing, it looks like it's an
SMP-related problem.  I'm not yet sure if it's an SMP-Via chipset
problem or just an SMP problem.  I've heard from two people with this
same problem.  I think one of them has a Via chipset and I'm not sure
about the other one.  

Can anybody look into this or give me a good brain dump on how I can fix
it?

Thanks,
pete

On Fri, 06 Jul 2001, Pete Toscano wrote:

> I think I've seen this same problem, at least with regards to USB
> printing.  Yesterday, I traced the problem down to a patch to usb-uhci.c
> in the transition from 2.4.3 to 2.4.4.  The problem persists today.  A
> work around for this problem is to use the alternate UHCI driver
> (uhci.o).
> 
> What motherboard and chipset are you using.  I use the Tyan Tiger 133
> motherboard with the VIA Apollo Pro 133a chipset.  Someone else who I
> heard from uses another VIA-based chipset (I think, he never replied to
> my question).  Maybe this is a VIA-related problem, like the APIC
> problem is.  (Do you use "noapic" when you boot?  He and I both have SMP
> systems too....)
> 
> I posted something on the linux-usb list yesterday about this problem
> and with all the info I was able to track down, but I have yet to see
> any response.  I've taken this as far as I can by myself.  I don't know
> enough about kernel programming or about USB to check the code in
> usb-uhci.c, but I'm more than happy to help by providing information
> and/or testing potential patches/fixes.
> 
> pete
