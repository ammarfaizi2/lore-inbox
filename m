Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261328AbTCOI1e>; Sat, 15 Mar 2003 03:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261329AbTCOI1e>; Sat, 15 Mar 2003 03:27:34 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:46720 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S261328AbTCOI1d>;
	Sat, 15 Mar 2003 03:27:33 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.64-mm6
References: <20030313032615.7ca491d6.akpm@digeo.com>
	<87bs0eqors.fsf@lapper.ihatent.com>
	<20030314035532.3fb6e351.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 15 Mar 2003 09:38:23 +0100
In-Reply-To: <20030314035532.3fb6e351.akpm@digeo.com>
Message-ID: <8765qlnhxc.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> Alexander Hoogerhuis <alexh@ihatent.com> wrote:
> >
> > I've used tried the -mm-kernels since they've actually made
> > 2.5-kernels usable on my laptop lately (Compaq Evo800c), but
> > 2.5.64-mm2 and onwards doesnt work with X anymore. I run 4.3.0-r1 from
> > the Gentoo unstable "branch".
> > 
> > with -mm1 I X coming up just nicely, and now the screen just goes
> > black after trying to start X, and it seems related to DRM.
> 
> I have a radeon card here.  Just tried it.  The X server starts up OK but as
> soon as I run tuxracer, some ioctl down in the radeon driver keeps on timing
> out waiting for the FIFO, spins for ten milliseconds in-kernel and the X
> server immediately calls the ioctl again.  The whole thing is bust.  I went
> all the way back to 2.5.39, where it is still bust.  2.4.21-pre5 is OK
> though.
> 
> So it looks like my breakage is different from yours.
> 
> Could you please try just 2.5.64 plus
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.64/2.5.64-mm6/broken-out/linus.patch
> 
> That will tell us if it is a -mm bug or a -linus bug.
> 

Vanilla 2.5.64 is b0rken, too. Tried it, and went back and tries -mm6
with and without ACPI as well, no difference. So instead of trudging
through that liste of change sets, I'll back out one and one patch
from -mm1 back to plain .64 to see where the thing goes belly
up. Seems reasonable?

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
