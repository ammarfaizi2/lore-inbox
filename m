Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136288AbRAJUDE>; Wed, 10 Jan 2001 15:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136309AbRAJUCz>; Wed, 10 Jan 2001 15:02:55 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:15365 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136288AbRAJUCh>; Wed, 10 Jan 2001 15:02:37 -0500
Message-ID: <3A5CBFC5.7E11E5A@transmeta.com>
Date: Wed, 10 Jan 2001 12:02:13 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: rdunlap <randy.dunlap@intel.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kai Germaschewski <kai@thphy.uni-duesseldorf.de>,
        Alan Cox <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Re: That horrible hack from hell called A20
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F06E2EC5F@orsmsx31.jf.intel.com> <3A5CBAE3.ACDD2494@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rdunlap wrote:
> 
> Alan-
> 
> Here's a patch to 2.2.19-pre7 that is essentially a backport of the
> 2.4.0 gate-A20 code.
> 
> This speeds up booting on my fast-A20 board (Celeron 500 MHz, no KBC)
> from 2 min:15 seconds to <too small to measure by my wrist watch>.
> 
> Kai, you reported that your system was OK with 2.4.0-test12-pre6.
> Does that mean that it's OK with 2.4.0-final also?
> 
> Comments?  Should we be merging Peter's int 0x15-first patch with this?
> And test for A20-gated after each step, before going to the next
> method?  Get that working and then backport it to 2.2.19?
> Have their been any test reports on Peter's last patch?  I didn't see
> any, but if that should be the goal, I'll give it a whirl.
> 
> I'd like to see this applied to 2.2.19.  At least changing the long
> delay so that it doesn't appear that Linux isn't going to boot...
> 

I certainly would appreciate feedback.  I'm probably going to have to
release a new version of SYSLINUX which will use that method, too.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
