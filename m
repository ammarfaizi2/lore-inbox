Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVK1XMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVK1XMw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 18:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVK1XMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 18:12:51 -0500
Received: from mx1.suse.de ([195.135.220.2]:51376 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932244AbVK1XMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 18:12:50 -0500
Date: Tue, 29 Nov 2005 00:12:39 +0100
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Bill Davidsen <davidsen@tmr.com>, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051128231239.GC7209@brahms.suse.de>
References: <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214835.GA24044@nevyn.them.org> <Pine.LNX.4.64.0511231416490.13959@g5.osdl.org> <20051123222056.GA25078@nevyn.them.org> <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org> <438B600C.1050604@tmr.com> <438B827A.2090609@wolfmountaingroup.com> <438B8BF8.4020604@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438B8BF8.4020604@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not sure a hardware solution is even the right thing - consider a 
> shared memory database process with a private heap.  You really want 
> locks on the shared memory, and you really don't on the heap.
> 
> You need a way to type the lock semantics by memory region, and a 
> working hardware solution can not perform as well as a careful software 
> solution.  As was pointed out earlier, you can't use memory type 

The problem is that nobody will change all the software.
Your careful software solution will only benefit a small
minority of performance conscious and well tuned programs.

The hardware solution might not be perfect, but has a good chance
to apply to 90% of the "don't care" programs and help them all a bit.
And every bit counts in the quest for more single thread performance.

And if someone wants to fine tune their programs they can
still change the software as much as they want.

-Andi
