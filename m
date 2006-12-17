Return-Path: <linux-kernel-owner+w=401wt.eu-S1752573AbWLQNKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbWLQNKf (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 08:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752575AbWLQNKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 08:10:35 -0500
Received: from ari.tomodachi.de ([217.160.215.119]:3297 "EHLO ari.tomodachi.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573AbWLQNKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 08:10:35 -0500
Date: Sun, 17 Dec 2006 14:10:33 +0100
From: Tobias Diedrich <ranma+kernel@tdiedrich.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tobias Diedrich <ranma+kernel@tdiedrich.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Yinghai Lu <yinghai.lu@amd.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: IO-APIC + timer doesn't work
Message-ID: <20061217131033.GA25999@tomodachi.de>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <20061216174536.GA2753@melchior.yamamaya.is-a-geek.org> <Pine.LNX.4.64.0612160955370.3557@woody.osdl.org> <20061216225338.GA2616@melchior.yamamaya.is-a-geek.org> <20061216230605.GA2789@melchior.yamamaya.is-a-geek.org> <Pine.LNX.4.64.0612161518080.3479@woody.osdl.org> <20061216235513.GA2424@melchior.yamamaya.is-a-geek.org> <Pine.LNX.4.64.0612161603070.3479@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612161603070.3479@woody.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Sun, 17 Dec 2006, Tobias Diedrich wrote:
> > 
> > No such luck, it still panics and the APIC error is also unchanged.
> 
> Ok. I don't see anything wrong off-hand, but I'll keep the patch in the 
> tree in the hopes that Andi and/or Eric can see what's wrong and solve it.
> 
> If we don't find a solution, I'll have to revert it, but let's give it a 
> few more days. 
> 
> Tobias, can you please make sure to remind me about this if nothing seems 
> to happen? 

Sure.

BTW, I'm also wondering if this secondary Oops is supposed to happen:
http://www.tdiedrich.de/~ranma/2.6.20-rc1-oops2.jpg
I guess the NMI watchdog is never disabled after the test failed?

|[68.908000] Kernel panic - not syncing: IO-APIC + timer doesn't work! Try using the 'noapic' kernel parameter
|[68.908002]
[~4 seconds later]
|[68.908300] NMI Watchdog detected LOCKUP on CPU 0
  ^^^^^^^^^ wrong timestamp?
|[73.637325] CPU 0
|[73.637451] Modules linked in:
|[73.637579] Pid: 1, comm: swapper Not tainted 2.6.20-rc1-amd64 #27
[...]
