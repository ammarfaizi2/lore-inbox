Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131155AbRAMScT>; Sat, 13 Jan 2001 13:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131115AbRAMSZO>; Sat, 13 Jan 2001 13:25:14 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59872 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131063AbRAMSZC>;
	Sat, 13 Jan 2001 13:25:02 -0500
Date: Sat, 13 Jan 2001 17:06:16 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: linux-lvm@sistina.com
Cc: Anton Blanchard <anton@linuxcare.com.au>, Mauelshagen@sistina.com,
        linux-kernel@vger.kernel.org, lvm@sistina.com
Subject: Re: [linux-lvm] Re: *** ANNOUNCEMENT *** LVM 0.9.1 beta1 available at www.sistina.com
Message-ID: <20010113170616.B22699@caldera.de>
Mail-Followup-To: linux-lvm@sistina.com,
	Anton Blanchard <anton@linuxcare.com.au>, Mauelshagen@sistina.com,
	linux-kernel@vger.kernel.org, lvm@sistina.com
In-Reply-To: <20010113114507.D15915@linuxcare.com> <200101130143.f0D1hNF19829@webber.adilger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200101130143.f0D1hNF19829@webber.adilger.net>; from adilger@turbolinux.com on Fri, Jan 12, 2001 at 06:43:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 06:43:23PM -0700, Andreas Dilger wrote:
> Anton, you write:
> > Have a look at 2.4, arch/sparc64/kernel/ioctl32.c
> 
> Yuk.
> 
> > Would it be possible to clean up the ioctl interface so we dont need
> > such large hacks for LVM support? I can do the work but I want to be
> > sure you guys will agree to it.
> 
> What is the reason for all this?  Alignment/wordsize/other?  If you look
> at the IOP10 code, much of the in-core data structs were changed to int
> or long, so this sparc code may not be necessary.

The longs are the biggest problem AFAICS.
long is 64bit on sparc64 and 32bit on sparc32...

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
