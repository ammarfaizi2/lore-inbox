Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbTIOTxS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 15:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbTIOTxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 15:53:18 -0400
Received: from amdext2.amd.com ([163.181.251.1]:30680 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id S261488AbTIOTxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 15:53:16 -0400
Message-ID: <99F2150714F93F448942F9A9F112634C0638B1E3@txexmtae.amd.com>
From: richard.brunner@amd.com
To: davidsen@tmr.com
cc: alan@lxorguk.ukuu.org.uk, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: RE: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: Mon, 15 Sep 2003 14:51:28 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 1378C7CC402879-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My concern is trying to prevent 
the flood of emails where someone thinks they built 
a "standard" kernel only to  discover that they forgot 
to select the various suboptions
and it doesn't work on their processor. I'd like
to simplfy what the majority of folks need to do
to get a broadly working kernel.

I'd prefer that some set of options "take away"
rather than "add" features/work-arounds. In the case below,
I'd prefer a "don't support Athlon Prefetch Errata".

I think you can argue that some features are going to 
be common enough for the majority of users that they
should be in the "take-away" category.

Others are uncommon enough that they fall into
the "add" category.

If you stick with consistent nomenclature 
(e.g. add_feature_TBD & sub_default_feature_TBD) 
and put these options in one common config file, 
I think the embedded folks and the 
"optimize every last bit" folks get 
what they want.

] -Rich ...
] AMD Fellow
] richard.brunner at amd com 

> -----Original Message-----
> From: Bill Davidsen [mailto:davidsen@tmr.com] 
> Sent: Monday, September 15, 2003 12:16 PM
> To: Brunner, Richard
> Cc: alan@lxorguk.ukuu.org.uk; zwane@linuxpower.ca; 
> linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
> 
> 
> On Mon, 15 Sep 2003 richard.brunner@amd.com wrote:
> 
> > I think Alan brought up a very good point. Even if you
> > use a generic kernel that avoids prefetch use on Athlon
> > (which I am opposed to), it doesn't solve the problem
> > of user space programs detecting that the ISA supports
> > prefetch and using prefetch instructions and hitting the
> > errata on Athlon.
> > 
> > The user space problem worries me more, because the expectation
> > is that if CPUID says the program can use perfetch, it could
> > and should regardless of what the kernel decided to do here.
> > 
> > Andi's patch solves both the kernel space and the user space
> > issues in a pretty small footprint.
> 
> Clearly AMD would like to avoid having PIV and Athlon 
> optimized kernels,
> and to default to adding unnecessary size to the PIV kernel to support
> errata in the Athlon. But fighting against having a config 
> which produces
> a smaller and faster kernel for all non-Athlon users and all 
> embedded or
> otherwise size limited users seems to be just a marketing 
> thing so P4 code
> will seem to work correctly on Athlon.
> 
> Vendors will build a kernel which runs as well as possible on 
> as many CPUs
> as possible, but users who build their own kernel want to 
> build a kernel
> for a particular config in most cases and should have the 
> option. There
> should be a "support Athlon prefetch" option as well, which turns on
> the fix only when it's needed, just as there is for P4 
> thermal throttling,
> F.P. emulation, etc. Why shouldn't this be treated the same 
> way as other
> features already in the config menu?
> 
> -- 
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
> 
> 

