Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbVKXT0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbVKXT0K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 14:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbVKXT0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 14:26:10 -0500
Received: from cantor2.suse.de ([195.135.220.15]:11943 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750955AbVKXT0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 14:26:08 -0500
Date: Thu, 24 Nov 2005 20:26:05 +0100
From: Andi Kleen <ak@suse.de>
To: thockin@hockin.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Gerd Knorr <kraxel@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051124192604.GS20775@brahms.suse.de>
References: <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <20051123165923.GJ20775@brahms.suse.de> <1132783243.13095.17.camel@localhost.localdomain> <20051124131310.GE20775@brahms.suse.de> <m1zmnugom7.fsf@ebiederm.dsl.xmission.com> <20051124133907.GG20775@brahms.suse.de> <m1u0e2gnab.fsf@ebiederm.dsl.xmission.com> <20051124191636.GC2468@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051124191636.GC2468@hockin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 11:16:36AM -0800, thockin@hockin.org wrote:
> On Thu, Nov 24, 2005 at 06:58:52AM -0700, Eric W. Biederman wrote:
> > > That's supposed to be done by hardware, no? 
> > > At least the K8 has a hardware scrubber (although it's not always enabled)
> > 
> > Recent good implementations like the Opteron will do it for you.
> > Older or cheaper memory controllers will not.
> 
> Beware of errata - there's at leats one errata on Opteron which forces you
> to choose between x4 (chipkill) ECC and scrubber.  One or the other, but
> not both.  There are plenty of errata on the scrubber alone.  Worse, if my
> (brain)memory is correct, without the scrubber, correctable errors are
> corrected on the fly, but never written back to DRAM.

All the scrub errata were fixed with E stepping AFAIK.

You have a point that using a sw scrubber might make sense on earlier
steppings though in case someone really wants chipkill.

-Andi
