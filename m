Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267376AbUBSVOq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbUBSVOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:14:46 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:60426
	"EHLO muru.com") by vger.kernel.org with ESMTP id S267376AbUBSVN0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:13:26 -0500
Date: Thu, 19 Feb 2004 13:14:25 -0800
From: Tony Lindgren <tony@atomide.com>
To: Andi Kleen <ak@suse.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Intel x86-64 support patch breaks amd64
Message-ID: <20040219211425.GA8282@atomide.com>
References: <9AB83E4717F13F419BD880F5254709E5011EB8BD@scsmsx402.sc.intel.com> <20040220202914.40ef613b.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220202914.40ef613b.ak@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen <ak@suse.de> [040219 13:02]:
> On Thu, 19 Feb 2004 12:45:19 -0800
> "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
> >
> > Andi, Appended patch should fix the problem reported by Tony.
> 
> Which change exactly is supposed to fix it? And why? 
> 
> For me the UP kernel boots just fine.

Thanks Suresh, that did it. I bet it's the GDT_ENTRIES change in segment.h
that was the real cause of my system not booting.

That's what I meant with having all parts of the original cset undone,
except for the *.h file changes. Even with only the *.h parts of the cset
included in my tree would cause the system _not_ boot.

Let me know if you need more patches tested, gotta do some work now that the
system runs again :)

Anybody got any information why the ioapic interrupt programming fails on VIA
based K8 boards, BTW?

Regards,

Tony
