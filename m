Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbVAKKqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVAKKqP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 05:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVAKKqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 05:46:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61320 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262698AbVAKKpy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 05:45:54 -0500
Date: Tue, 11 Jan 2005 05:42:30 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Edjard Souza Mota <edjard@gmail.com>, Mauricio Lin <mauriciolin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: User space out of memory approach
Message-ID: <20050111074230.GB18796@logos.cnet>
References: <3f250c71050110134337c08ef0@mail.gmail.com> <20050110192012.GA18531@logos.cnet> <4d6522b9050110144017d0c075@mail.gmail.com> <20050110200514.GA18796@logos.cnet> <1105403747.17853.48.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105403747.17853.48.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 01:35:47AM +0100, Thomas Gleixner wrote:
> On Mon, 2005-01-10 at 18:05 -0200, Marcelo Tosatti wrote:
> > The feature is interesting - several similar patches have been around with similar
> > functionality (people who need usually write their own, I've seen a few), but none 
> > has ever been merged, even though it is an important requirement for many users.
> 
> It's not a requirement for users. The current implementation in the
> kernel it's just broken, ugly code.
> 
> > This is simple, an ordered list of candidate PIDs. IMO something similar to this 
> > should be merged. Andrew ?
> 
> I have no objections against the userspace provided candidate list
> option, but as long as the main sources of trouble 
> 
> 	- invocation
> 	- reentrancy
> 	- timed, counted, blah ugly protection
> 	- selection problem
> 
> are not fixed properly, we don't need to discuss the inclusion of a
> userspace provided candidate list.
> 
> Postpone this until the main problem is fixed. There is a proper
> confirmed fix for this available. It was posted more than once.

Agreed - haven't you and Andrea fixed those recently ?

> Merging a fix which helps only 0,001 % of the users to hide the mess
> instead of fixing the real problem is a real interesting engineering
> aproach.
> 
> I don't deny, that after the source of trouble is fixed it is worth to
> think about the merging of this addon to allow interested users to
> define the culprits instead of relying on an always imperfect selection
> algorithm.

Yep.
