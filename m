Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbTL0QeT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 11:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbTL0QeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 11:34:19 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:7378 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264500AbTL0QeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 11:34:18 -0500
Date: Sat, 27 Dec 2003 08:34:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: Rik van Riel <riel@surriel.com>, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: Page aging broken in 2.6
Message-ID: <5530000.1072542846@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.58.0312261951420.14874@home.osdl.org>
References: <1072423739.15458.62.camel@gaston> <Pine.LNX.4.58.0312260957100.14874@home.osdl.org><1072482941.15458.90.camel@gaston> <Pine.LNX.4.58.0312261626260.14874@home.osdl.org><1072485899.15456.96.camel@gaston> <Pine.LNX.4.58.0312261649070.14874@home.osdl.org><Pine.LNX.4.55L.0312262147030.7686@imladris.surriel.com><20031226190045.0f4651f3.akpm@osdl.org> <Pine.LNX.4.58.0312261951420.14874@home.osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The current behaviour seems better from a theoretical point of view. 
> 
> I disagree. It's at least not obvious.
> 
>>							 All
>> we want to know is the reference pattern - whether it is one process
>> referencing the page frequently or 100 processes referencing it
>> infrequently shouldn't matter.
> 
> I agree that those two cases should be the same. And in fact, those two
> cases _will_ be the same by my suggested change ("break out of
> 'page_referenced()' early")
> 
> However, you ignore the third case: a page that is frequently used by 100 
> processes.
> 
> Such a page behaves differently with the 'break early' behaviour, by 
> pinnong the page more tightly. 
> 
> And I think that's the right behaviour. At least that's not "obviously 
> wrong".
> 
> It's not something to do in 2.6.x, but I disagree that it's clear-cut.

Could we at least stick a big fat comment explaining the current behaviour
in there? The current behaviour is not at all obvious from reading the code.
I'll try to write something if you like, but no doubt someone could do a
better job than I.

M.

