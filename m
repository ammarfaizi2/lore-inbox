Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbTIOVA3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbTIOVA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:00:29 -0400
Received: from fmr06.intel.com ([134.134.136.7]:16856 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261618AbTIOU7l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:59:41 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: Mon, 15 Sep 2003 13:20:04 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AF57@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Thread-Index: AcN7w2s3M1xhPkVdQhyzXKmL1CkEzgAANx4w
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: <richard.brunner@amd.com>, <davidsen@tmr.com>
Cc: <alan@lxorguk.ukuu.org.uk>, <zwane@linuxpower.ca>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Sep 2003 20:20:05.0780 (UTC) FILETIME=[C0608D40:01C37BC6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd prefer that some set of options "take away"
> rather than "add" features/work-arounds. In the case below,
> I'd prefer a "don't support Athlon Prefetch Errata".

So the best way would be "make it configurable, and set it on by
default."? I don't think forcing everyone to have workarounds for
particular errata is desirable, but I agree that preventing mistakes is
a good thing. 

Thanks,
Jun

> -----Original Message-----
> From: richard.brunner@amd.com [mailto:richard.brunner@amd.com]
> Sent: Monday, September 15, 2003 12:51 PM
> To: davidsen@tmr.com
> Cc: alan@lxorguk.ukuu.org.uk; zwane@linuxpower.ca; linux-
> kernel@vger.kernel.org
> Subject: RE: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
> 
> My concern is trying to prevent
> the flood of emails where someone thinks they built
> a "standard" kernel only to  discover that they forgot
> to select the various suboptions
> and it doesn't work on their processor. I'd like
> to simplfy what the majority of folks need to do
> to get a broadly working kernel.
> 
> I'd prefer that some set of options "take away"
> rather than "add" features/work-arounds. In the case below,
> I'd prefer a "don't support Athlon Prefetch Errata".
> 
> I think you can argue that some features are going to
> be common enough for the majority of users that they
> should be in the "take-away" category.
> 
> Others are uncommon enough that they fall into
> the "add" category.
> 
> If you stick with consistent nomenclature
> (e.g. add_feature_TBD & sub_default_feature_TBD)
> and put these options in one common config file,
> I think the embedded folks and the
> "optimize every last bit" folks get
> what they want.
> 
> ] -Rich ...
> ] AMD Fellow
> ] richard.brunner at amd com
> 
> > -----Original Message-----
> > From: Bill Davidsen [mailto:davidsen@tmr.com]
> > Sent: Monday, September 15, 2003 12:16 PM
> > To: Brunner, Richard
> > Cc: alan@lxorguk.ukuu.org.uk; zwane@linuxpower.ca;
> > linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH] 2.6 workaround for Athlon/Opteron prefetch
errata
> >
> >
> > On Mon, 15 Sep 2003 richard.brunner@amd.com wrote:
> >
> > > I think Alan brought up a very good point. Even if you
> > > use a generic kernel that avoids prefetch use on Athlon
> > > (which I am opposed to), it doesn't solve the problem
> > > of user space programs detecting that the ISA supports
> > > prefetch and using prefetch instructions and hitting the
> > > errata on Athlon.
> > >
> > > The user space problem worries me more, because the expectation
> > > is that if CPUID says the program can use perfetch, it could
> > > and should regardless of what the kernel decided to do here.
> > >
> > > Andi's patch solves both the kernel space and the user space
> > > issues in a pretty small footprint.
> >
> > Clearly AMD would like to avoid having PIV and Athlon
> > optimized kernels,
> > and to default to adding unnecessary size to the PIV kernel to
support
> > errata in the Athlon. But fighting against having a config
> > which produces
> > a smaller and faster kernel for all non-Athlon users and all
> > embedded or
> > otherwise size limited users seems to be just a marketing
> > thing so P4 code
> > will seem to work correctly on Athlon.
> >
> > Vendors will build a kernel which runs as well as possible on
> > as many CPUs
> > as possible, but users who build their own kernel want to
> > build a kernel
> > for a particular config in most cases and should have the
> > option. There
> > should be a "support Athlon prefetch" option as well, which turns on
> > the fix only when it's needed, just as there is for P4
> > thermal throttling,
> > F.P. emulation, etc. Why shouldn't this be treated the same
> > way as other
> > features already in the config menu?
> >
> > --
> > bill davidsen <davidsen@tmr.com>
> >   CTO, TMR Associates, Inc
> > Doing interesting things with little computers since 1979.
> >
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
