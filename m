Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290125AbSBSVFW>; Tue, 19 Feb 2002 16:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290184AbSBSVFL>; Tue, 19 Feb 2002 16:05:11 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:19212 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290125AbSBSVEv>; Tue, 19 Feb 2002 16:04:51 -0500
Date: Tue, 19 Feb 2002 16:03:41 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Michael Cohen <me@ohdarn.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18-pre9-mjc2 compile errors
In-Reply-To: <1014081580.21495.3.camel@ohdarn.net>
Message-ID: <Pine.LNX.3.96.1020219155511.19281A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Feb 2002, Michael Cohen wrote:

> Sorry, I wasn't in too great of a mood.  Didn't mean to sound *that*
> rough.  Anyways, I had just started using bitkeeper, and the change
> didn't get committed properly, so it fell out of my bk tree when I made
> the patch.  It had been tested mostly though.  I started using a much
> more inclusive test .config though; and I'll have a working next
> release.  Take a look at how well 2.5 currently compiles though =)
> 
> Fix is to remove the function __find_page_nolock from mm/filemap.c.

And after it compiles and depmod lists all the symbols which aren't
exported you rewite ksyms.c with:
/* all the crap missing from mjc2 */
EXPORT_SYMBOL(blkdev_varyio);
EXPORT_SYMBOL(pidhash_bits);
EXPORT_SYMBOL(pidhash_size);

Some of which is cruft you inhereted which will be fixed in 2.4.28-rc77, I
think one you created yourself.

Since the test machine take ~100min to build a kernel, I have just
finished the build and will boot Friday, assuming that rc3-mjc1 or so
isn't out.

for the record, 2.4.18-pre9-mjc1 did not run as well on the small machine
test as just rmap-12e+K3. I was hoping the preempt in mjc1 would make it
more responsive. I have a new test for thread handling, I want to run
that, and maybe Thursday I'll get to try all of these on SMP and large
memory systems.

Soon I have to write all this stuff up...

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

