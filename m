Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290125AbSAKVjW>; Fri, 11 Jan 2002 16:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290126AbSAKVjM>; Fri, 11 Jan 2002 16:39:12 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:52743 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S290125AbSAKVi7>; Fri, 11 Jan 2002 16:38:59 -0500
Date: Fri, 11 Jan 2002 15:38:57 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020111153857.E9643@asooo.flowerfire.com>
In-Reply-To: <20020111144117.A1485@asooo.flowerfire.com> <Pine.LNX.4.33.0201111609340.2580-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201111609340.2580-100000@coffee.psychology.mcmaster.ca>; from hahn@physics.mcmaster.ca on Fri, Jan 11, 2002 at 04:13:00PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think I made the claim that this was a benchmark -- I certainly
realize that "make -j bzImage" is not real-world, but it is clearly
indicative of heavy VM/CPU/context load.  Since I don't believe this
patch is currently in the running for inclusion, I'm just giving general
feedback to the patch author rather than making a case.

For instance, "make -j bzImage" reproduced the ext3 bug that Andrew
found where my other VM-intensive apps did not.  I doubt we should keep
the bug in the kernel because the situation isn't real-world enough.

But yes, a bug is worse than a behavior flaw, granted.
-- 
Ken.
brownfld@irridia.com

On Fri, Jan 11, 2002 at 04:13:00PM -0500, Mark Hahn wrote:
| > overall performance seems far lower.  For instance, without the patch
| > the -j build finishes in ~10 minutes (2x933P3/256MB) but with the patch
| 
| please, PLEASE stop using "make -j" 
| for anything except the fork-bomb that it is.
| pretending that it's a benchmark, especially one 
| to guide kernel tuning, is a travesty!
| 
| if you want to simulate VM load, so something sane like
| boot with mem=32M, or a simple "mmap(lots); mlockall" tool.
| 
| regards, mark hahn.
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
