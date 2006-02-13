Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWBMUBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWBMUBE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWBMUBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:01:04 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:63692 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964841AbWBMUBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:01:03 -0500
Date: Mon, 13 Feb 2006 20:59:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] hrtimer: remove useless const
Message-ID: <20060213195920.GC30679@elte.hu>
References: <Pine.LNX.4.61.0602130209340.23804@scrub.home> <1139830116.2480.464.camel@localhost.localdomain> <Pine.LNX.4.61.0602131235180.30994@scrub.home> <20060213114612.GA30500@elte.hu> <20060213035354.65b04c15.akpm@osdl.org> <Pine.LNX.4.61.0602131315150.30994@scrub.home> <20060213043038.25a49dd0.akpm@osdl.org> <Pine.LNX.4.61.0602131339330.30994@scrub.home> <20060213115248.2f6445f4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213115248.2f6445f4.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Roman Zippel <zippel@linux-m68k.org> wrote:
> >
> > On Mon, 13 Feb 2006, Andrew Morton wrote:
> > 
> >  > const arguments to functions are pretty useful for code readability and
> >  > maintainability too, if you use them consistently.
> > 
> >  I could understand that argument, if gcc would warn about it in any way.
> 
> It does.  If a function tries to modify a formal argument which was 
> marked const you'll get a warning.
> 
> We're talking about different things here.  My point is that it is 
> perverted and evil for a function to modify its own args (unless it's 
> very small and simple), and a const declaration is a useful way for a 
> maintenance programmer to be assured that nobody has done perverted 
> and evil things to a function.

good point. I dont think it's "evil" (or as Roman has put it, "bogus") 
in any way, and it should be up to the authors of the code to decide one 
way or another. [An added bonus for me is that in my editor the 'const' 
keyword is color highlighted, so const args are visually separate from 
non-const arguments]

	Ingo
