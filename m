Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265443AbRGGVzU>; Sat, 7 Jul 2001 17:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266595AbRGGVzK>; Sat, 7 Jul 2001 17:55:10 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:5392 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S265443AbRGGVzA>;
	Sat, 7 Jul 2001 17:55:00 -0400
Date: Sat, 7 Jul 2001 23:54:54 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Mike Touloumtzis <miket@bluemug.com>, linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
Message-ID: <20010707235329.A10256@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.33.0107040956310.1668-100000@penguin.transmeta.com> <9i6oga$jk1$1@pccross.average.org> <3B46F3CE.9002ABAB@mandrakesoft.com> <20010707144032.C19529@mayotte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010707144032.C19529@mayotte>; from miket@bluemug.com on Sat, Jul 07, 2001 at 02:40:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Touloumtzis wrote:
> > > Doesn't the approach "treat a chunk of data built into bzImage as
> > > populated ramfs" look cleaner?  No need to fiddle with tar format,
> > > no copying data from place to place.
> > 
> > So tell me, how do you populate ramfs without a format which tells you
> > what path and which permissions to assign each file?  That's exactly
> > what tar is.
> 
> Would it be possible to use a cramfs image in vmlinux (i.e. real
> filesystem image, not an in-kernel-structures fs like ramfs), and map
> it directly from the kernel image (it would have to be suitably aligned,
> of course)?
> 
> This would allow demand paging of files in the image (not too important
> for a minimal boot fs, admittedly), and would allow text pages to be
> dropped under VM pressure (nice for a fs which holds substantial amounts
> of boot-time-only code).

Yes that would work, and it would work on machines with less RAM too.
You would want to remove the cramfs filesystem code when you're done though.

-- Jamie
