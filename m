Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129697AbRBHFJX>; Thu, 8 Feb 2001 00:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129753AbRBHFJN>; Thu, 8 Feb 2001 00:09:13 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:59407 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129697AbRBHFIw>; Thu, 8 Feb 2001 00:08:52 -0500
Message-ID: <3A822967.D42D5165@transmeta.com>
Date: Wed, 07 Feb 2001 21:06:47 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: macro@ds2.pg.gda.pl, linux-kernel@vger.kernel.org, mingo@redhat.com,
        vandrove@vc.cvut.cz
Subject: Re: [PATCH] Re: UP APIC reenabling vs. cpu type detection ordering
In-Reply-To: <200102080504.GAA23507@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> 
> H. Peter Anvin wrote:
> 
> >"Maciej W. Rozycki" wrote:
> >...
> >>  It might be viable just to delete the test altogether, though and just
> >> trap #GP(0) on the MSR access.  For the sake of simplicity.  If a problem
> >> with a system ever arizes, we may handle it then.
> >>
> >>  Note that we still have to choose appropriate vendor-specific PeMo
> >> handling and an event for the NMI watchdog anyway.
> >
> >Right... if that is the case then it seems reasonable.
> 
> No, poking into MSRs not explicitly defined on the current CPU is
> inherently unsafe. I have several x86 CPU data sheets here in front
> of me which say the same thing: "Don't write to undocumented MSRs."
> You cannot assume that every single x86 out there stays clear of
> all Intel-defined MSRs. Intel has also expanded this set over time:
> older designs may not even have known about the APIC_BASE MSR.
> 

You misread me.  "In that case it seems reasonable to do vendor-specific
detection."

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
