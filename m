Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBGSGi>; Wed, 7 Feb 2001 13:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbRBGSG2>; Wed, 7 Feb 2001 13:06:28 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4356 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129027AbRBGSGS>; Wed, 7 Feb 2001 13:06:18 -0500
Message-ID: <3A818D21.6619FE3C@transmeta.com>
Date: Wed, 07 Feb 2001 10:00:01 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Petr Vandrovec <vandrove@vc.cvut.cz>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mikpe@csd.uu.se
Subject: Re: UP APIC reenabling vs. cpu type detection ordering
In-Reply-To: <Pine.GSO.3.96.1010207184159.1418E-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" wrote:
> 
> > In other words, I'd like to see a reason for making any vendor-specific
> > determinations, and if so, they should ideally be centralized to the CPU
> > feature-determination code.
> 
>  It would be hard to decide how to classify it.  It's something like "the
> CPU has a local APIC that we know how to handle in the non-MPS system".
> 
>  It might be viable just to delete the test altogether, though and just
> trap #GP(0) on the MSR access.  For the sake of simplicity.  If a problem
> with a system ever arizes, we may handle it then.
> 
>  Note that we still have to choose appropriate vendor-specific PeMo
> handling and an event for the NMI watchdog anyway.
> 

Right... if that is the case then it seems reasonable.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
