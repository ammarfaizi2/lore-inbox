Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262713AbREYREJ>; Fri, 25 May 2001 13:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263101AbREYRD7>; Fri, 25 May 2001 13:03:59 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:10256
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S262713AbREYRDt>; Fri, 25 May 2001 13:03:49 -0400
Date: Fri, 25 May 2001 12:58:18 -0400
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Andi Kleen <ak@suse.de>, Andreas Dilger <adilger@turbolinux.com>,
        monkeyiq <monkeyiq@users.sourceforge.net>,
        linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: Dying disk and filesystem choice.
Message-ID: <328640000.990809898@tiny>
In-Reply-To: <3B0E8696.5B1F304@namesys.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, May 25, 2001 09:21:42 AM -0700 Hans Reiser <reiser@namesys.com>
wrote:
> No, our policy is strictly in sync with and reflective of that of the
> rest of the linux-kernel.  Since the ac series has a different policy, we
> can be different in regards to the ac series.  

Not really, our policy has been much more restrictive than the rest of the
kernel.  Look at the patches we didn't send in.

> 
> And I don't begin to comprehend your not sending in the lost disk space
> after crash bug fix (I assume it is what you mean when you refer to lost
> files after a crash, because I know of no lost files after a crash bug,
> please phrase things more carefully), and it really annoys me and the
> users, frankly.  Why you consider that a feature is beyond me.

The patch is a _huge_ change to the way files are deleted and truncated, to
what happens during mount, and to the way transactions work.  It is
effectively a format extension, and must be verified against both 2.2.x
kernels and 2.4.x kernels, in both disk formats.

Before I even consider introducing a change of this size, I want to be as
sure as I can the rest of the code is stable.  It is the only way we can
debug it and stay sane.  Even after I release the code, I won't want it in
an ac series for a while.  It does much more harm than good if it somehow
ruins compatibility with an older kernel, especially in 2.4.x.  

Yes, it is a bug fix.  But, it is a very different kind of bug fix than
something that corrupts files at random, or something that doesn't get
buffers to disk at the right time.  

I won't pretend the fix isn't important, but I won't allow larger changes
to ruin the progress we've made so far.

-chris

