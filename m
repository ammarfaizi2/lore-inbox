Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbVAKAgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVAKAgx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbVAKAgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:36:35 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:18322
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262599AbVAKAfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:35:53 -0500
Subject: Re: User space out of memory approach
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Edjard Souza Mota <edjard@gmail.com>, Mauricio Lin <mauriciolin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <20050110200514.GA18796@logos.cnet>
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 01:35:47 +0100
Message-Id: <1105403747.17853.48.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-10 at 18:05 -0200, Marcelo Tosatti wrote:
> The feature is interesting - several similar patches have been around with similar
> functionality (people who need usually write their own, I've seen a few), but none 
> has ever been merged, even though it is an important requirement for many users.

It's not a requirement for users. The current implementation in the
kernel it's just broken, ugly code.

> This is simple, an ordered list of candidate PIDs. IMO something similar to this 
> should be merged. Andrew ?

I have no objections against the userspace provided candidate list
option, but as long as the main sources of trouble 

	- invocation
	- reentrancy
	- timed, counted, blah ugly protection
	- selection problem

are not fixed properly, we don't need to discuss the inclusion of a
userspace provided candidate list.

Postpone this until the main problem is fixed. There is a proper
confirmed fix for this available. It was posted more than once.

Merging a fix which helps only 0,001 % of the users to hide the mess
instead of fixing the real problem is a real interesting engineering
aproach.

I don't deny, that after the source of trouble is fixed it is worth to
think about the merging of this addon to allow interested users to
define the culprits instead of relying on an always imperfect selection
algorithm.

tglx


