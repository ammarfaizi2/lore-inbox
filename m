Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRAPI77>; Tue, 16 Jan 2001 03:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRAPI7t>; Tue, 16 Jan 2001 03:59:49 -0500
Received: from sulphur.cix.co.uk ([212.35.225.149]:60292 "EHLO
	sulphur.cix.co.uk") by vger.kernel.org with ESMTP
	id <S129436AbRAPI7b>; Tue, 16 Jan 2001 03:59:31 -0500
X-Envelope-From: patrick@tykepenguin.cix.co.uk
Date: Tue, 16 Jan 2001 08:51:18 +0000
From: Patrick Caulfield <caulfield@sistina.com>
To: linux-lvm@sistina.com, Anton Blanchard <anton@linuxcare.com.au>,
        Mauelshagen@sistina.com, linux-kernel@vger.kernel.org, lvm@sistina.com
Subject: Re: [linux-lvm] Re: *** ANNOUNCEMENT *** LVM 0.9.1 beta1 available at www.sistina.com
Message-ID: <20010116085117.A696@tykepenguin.com>
Mail-Followup-To: linux-lvm@sistina.com,
	Anton Blanchard <anton@linuxcare.com.au>, Mauelshagen@sistina.com,
	linux-kernel@vger.kernel.org, lvm@sistina.com
In-Reply-To: <20010113114507.D15915@linuxcare.com> <200101130143.f0D1hNF19829@webber.adilger.net> <20010113170616.B22699@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010113170616.B22699@caldera.de>; from hch@ns.caldera.de on Sat, Jan 13, 2001 at 05:06:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2001 at 05:06:16PM +0100, Christoph Hellwig wrote:
> On Fri, Jan 12, 2001 at 06:43:23PM -0700, Andreas Dilger wrote:
> > Anton, you write:
> > > Have a look at 2.4, arch/sparc64/kernel/ioctl32.c
> > 
> > Yuk.
> > 
> > > Would it be possible to clean up the ioctl interface so we dont need
> > > such large hacks for LVM support? I can do the work but I want to be
> > > sure you guys will agree to it.

If you're prepared to do the work we'd be glad to accept the patch - please send
it to me or the list so I can check over it before committing it. As we don't
have an UltraSPARC available for testing it's probably better done by someone
who does !
 
> > What is the reason for all this?  Alignment/wordsize/other?  If you look
> > at the IOP10 code, much of the in-core data structs were changed to int
> > or long, so this sparc code may not be necessary.
> 
> The longs are the biggest problem AFAICS.
> long is 64bit on sparc64 and 32bit on sparc32...

There are still a few ulong members in lvm.h, they should be uint32_t 

patrick

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
