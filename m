Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVCNR3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVCNR3h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 12:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVCNR20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:28:26 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14306 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261637AbVCNR2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:28:07 -0500
Date: Mon, 14 Mar 2005 18:27:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       David Lang <david.lang@digitalinsight.com>,
       Dave Jones <davej@redhat.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
Message-ID: <20050314172744.GF5461@elf.ucw.cz>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz> <20050314083717.GA19337@elf.ucw.cz> <200503140855.18446.jbarnes@engr.sgi.com> <Pine.LNX.4.58.0503140907380.6119@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503140907380.6119@ppc970.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > We already have the 'quiet' option, but even so, I think the kernel is *way* 
> > too verbose.  Someone needs to make a personal crusade out of removing 
> > unneeded and unjustified printks from the kernel before it really gets better 
> > though...
> 
> The thing is, this comes up every once in a while (pretty often,
> actually), but the bulk of those messages _do_ end up being useful. For
> certain classes of bugs, I almost invariably ask for the bootup messages:  
> the PCI interrupt routing printou stuff is absolutely invaluable.
> 
> In fact, even the ones that have no "information" end up often being a big
> clue about where the hang happened.

Problem is that by now we have so much information that valuable
scrolls up. Users start to missing trace dumps in bootup phase because
it just scrolls away too quickly.

I know that "no information" messages can be valuable, but they make
messages with usefull information less likely to be noticed. And
people start doing ugly stuff like

*** This is really
*** important message

when they want their messages to be actually seen. Perhaps we should
reduce ammount of that "no information" messages? I particulary hate
"XXX driver registered" even when that driver has no hardware. Kernel
is quite unlikely to hang at that point.

> And those occasional people are often not going to eb very good at
> reporting bugs. If they don't see anything happening, they'll just give up
> rather than bother to report it. So I do think we want the fairly verbose
> thing enabled by default. You can then hide it with the graphical bootup 
> for "most people".

Does it mean that fbsplash done right would be ok for mainline? ;-).

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
