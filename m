Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKPBce>; Wed, 15 Nov 2000 20:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129060AbQKPBcZ>; Wed, 15 Nov 2000 20:32:25 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:65286 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129045AbQKPBcM>; Wed, 15 Nov 2000 20:32:12 -0500
Message-ID: <3A13320B.E5B47EF8@transmeta.com>
Date: Wed, 15 Nov 2000 17:02:03 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: New bluesmoke patch available, implements MCE-without-MCA support
In-Reply-To: <200011160056.BAA20778@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> 
> On 15 Nov 2000, H. Peter Anvin wrote:
> 
> >This implements support for MCE on chips which don't support MCA (in
> >addition to enabling MCA for non-Intel chips, like Athlon, which
> >supports MCA.)
> >
> >I would appreciate it if people who have chips with MCE but no MCA --
> >this includes older AMD chips and some Cyrix chips at the very least
> >-- would please be so kind and try this out.
> 
> I have a K6-III which announces MCE but not MCA, so I was going to
> test this on that machine.
> 
> However, both the K6-III manual and the K6 BIOS guide state quite
> clearly that the K6 family only has a "stub" MCE implementation.
> The MCE capability is announced, there are two MCE-related MSRs,
> and there is a CR4.MCE flag, but none of it actually _does_ anything.
> 
> The new CPU detection code should probably clear FEATURE_MCE for K6 CPUs.
> (We might consider it an AMD bug, but in their defense, they do state
> that the stub implementation was done for "compatibility" reasons.)
> 

Actually, that's just fine.  It won't cause any harm; all that will mean
is that it will never raise #MC.  Remember that a CPU should, in proper
operation, never raise #MC anyway!

Their implementation is a legal (albeit useless) implementation of MCE. 
No need to special-case it.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
