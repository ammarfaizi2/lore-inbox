Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S157560AbPLXRNG>; Fri, 24 Dec 1999 12:13:06 -0500
Received: by vger.rutgers.edu id <S157524AbPLXRMZ>; Fri, 24 Dec 1999 12:12:25 -0500
Received: from [216.208.98.3] ([216.208.98.3]:2313 "EHLO gin.ext.thepuffingroup.com") by vger.rutgers.edu with ESMTP id <S157540AbPLXRMD>; Fri, 24 Dec 1999 12:12:03 -0500
Date: Fri, 24 Dec 1999 12:11:55 -0500
From: Matthew Wilcox <willy@thepuffingroup.com>
To: Brian Gerst <bgerst@quark.vpplus.com>
Cc: Linux kernel mailing list <linux-kernel@vger.rutgers.edu>
Subject: Re: Linux Kernel Floating Point Emulation and CORDIC
Message-ID: <19991224121155.T12629@thepuffingroup.com>
References: <99122316092902.01246@cel2> <3862D177.F1EC9124@quark.vpplus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <3862D177.F1EC9124@quark.vpplus.com>; from Brian Gerst on Thu, Dec 23, 1999 at 08:50:47PM -0500
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, Dec 23, 1999 at 08:50:47PM -0500, Brian Gerst wrote:
> I don't think it's worth the effort to rewrite and retest the FP
> emulation code.  It is only needed on some 386 and 486 machines, as all
> pentiums and later always have built in FPUs.  Nobody should be doing
> any serious number crunching on those old processors.  Just my 2 cents
> though.

But not all the world is intel -- there is FP emulation code for Alpha,
ARM, MIPS, m68k, PPC and Sparc in the tree.  However, I seem to remember
someone analysing the FP emulator (on ARM) and concluding that the
cost of emulating FP instructions was dominated by the trap handler
and instruction decode.  So there's not much point in replacing the
algorithms with more efficient algorithms when it's not going to make
much difference.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
