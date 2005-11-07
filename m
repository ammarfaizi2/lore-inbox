Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbVKGTe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbVKGTe4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 14:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbVKGTe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 14:34:56 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:3211 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964926AbVKGTez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 14:34:55 -0500
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, mel@csn.ul.ie,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>, kravetz@us.ibm.com,
       arjanv@infradead.org, arjan@infradead.org,
       Andrew Morton <akpm@osdl.org>, mbligh@mbligh.org, andy@thermo.lanl.gov,
       Paul Jackson <pj@sgi.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Linus Torvalds <torvalds@osdl.org>, Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20051107122009.GD3609@elte.hu>
References: <20051104010021.4180A184531@thermo.lanl.gov>
	 <Pine.LNX.4.64.0511032105110.27915@g5.osdl.org>
	 <20051103221037.33ae0f53.pj@sgi.com> <20051104063820.GA19505@elte.hu>
	 <Pine.LNX.4.64.0511040725090.27915@g5.osdl.org>
	 <796B585C-CB1C-4EBA-9EF4-C11996BC9C8B@mac.com>
	 <Pine.LNX.4.64.0511060756010.3316@g5.osdl.org>
	 <Pine.LNX.4.64.0511060848010.3316@g5.osdl.org>
	 <20051107080042.GA29961@elte.hu> <1131361258.5976.53.camel@localhost>
	 <20051107122009.GD3609@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 07 Nov 2005 14:34:30 -0500
Message-Id: <1131392070.14381.133.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 13:20 +0100, Ingo Molnar wrote:

> 
> RAM removal, not RAM replacement. I explained all the variants in an 
> earlier email in this thread. "extending RAM" is relatively easy.  
> "replacing RAM" while doable, is probably undesirable. "removing RAM" 
> impossible.

Hi Ingo,

I'm usually amused when someone says something is impossible, so I'm
wondering exactly "why"?

If the one requirement is that there must be enough free memory
available to remove, then what's the problem for a fully mapped kernel?
Is it the GPT?  Or if there's drivers that physical memory mapped?  

I'm not sure of the best way to solve the GPT being in the RAM that is
to be removed, but there might be a way. Basically stop all activities
and update all the tasks->mm.

As for the drivers, one could have a accounting for all physical memory
mapped, and disable the driver if it is using the memory that is to be
removed.

But other then these, what exactly is the problem with removing RAM?

BTW, I'm not suggesting any of this is a good idea, I just like to
understand why something _cant_ be done.

-- Steve


