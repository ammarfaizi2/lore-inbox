Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTJSPoa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 11:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbTJSPo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 11:44:29 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:62367 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261309AbTJSPo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 11:44:28 -0400
Date: Sun, 19 Oct 2003 08:40:50 -0700
From: "Martin J. Bligh" <fletch@aracnet.com>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Adrian Bunk <bunk@fs.tum.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-ID: <667400000.1066578050@[10.10.2.4]>
In-Reply-To: <3F929C82.4020904@softhome.net>
References: <H2MN.3cm.7@gated-at.bofh.it> <H366.3IC.9@gated-at.bofh.it> <H3fO.3VO.13@gated-at.bofh.it> <H3IO.4yt.9@gated-at.bofh.it> <HWvz.5PI.9@gated-at.bofh.it> <I1EP.5QO.1@gated-at.bofh.it> <3F9173FE.5080308@softhome.net> <20031019113743.GO12423@fs.tum.de> <3F929C82.4020904@softhome.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Martin was ironically talking about people who are ignorant of machines
>> with _huge_ caches.
>> 
> 
>    Oh. Sorry. Probably I need to work on my English bit more.
> 
>> I the context of this thread he wanted to vote for making -Os 
>> conditionally and not unconditionally enabled by telling that he knows 
>> of situations where -O2 produces faster code.
> 
>    Absolutely.
>    High-end toys, after all, optimized to handle this.
> 
>    IMHO this should be settled on per-target basis: embedded system - -Os; servers - -O2; desktops - -O3 ;) So instead of CONFIG_EMBEDDED better to have CONFIG_TARGET=[desktop|server|embedded].
> 
>    Inroducing one more variable into builds - is really painful. I was hit by gcc miscompiles and internal errors not once (especially with -O[23]). Tracking down this kind of issues would be made more problematic.
> 
> P.S. I'm really sorry for my rude response.

;-) No problem. 

But if someone with a small cache would actually *measure* the damned 
thing, I'd be more impressed ... I've never seen that, but perhaps
I just missed it. 

Point is the same either way though ... we shouldn't unconditionally
optimise for *anyone's* system. If it's faster on all systems that anyone
can be bothered to measure, great. If it's faster on some, and slower on
others, a config option seems more appropriate, defaulting to the majority
of users.

M.

