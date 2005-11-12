Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbVKLEc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVKLEc0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 23:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVKLEcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 23:32:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64776 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751283AbVKLEcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 23:32:25 -0500
Date: Sat, 12 Nov 2005 05:32:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Rob Landley <rob@landley.net>
Cc: "Mukund JB." <mukundjb@esntechnologies.co.in>,
       linux-kernel@vger.kernel.org
Subject: Re: Which version of 2.6.11 is most stable
Message-ID: <20051112043219.GV5376@stusta.de>
References: <3AEC1E10243A314391FE9C01CD65429B13B280@mail.esn.co.in> <20051107115131.GD3847@stusta.de> <200511112149.08324.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511112149.08324.rob@landley.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 09:49:08PM -0600, Rob Landley wrote:
> 
> One question I've wondered about for a bit...
> 
> The diff between each dot release (ala 2.6.12.0->2.6.12.1) can theoretically 
> be backported to an older kernel.  So in theory, at least some of the new 
> security fixes can be applied to older kernels.  (Yeah, this necessarily 
> complete.  Whether or not the patch makes any sense at all in the older 
> context, and whether or not that's everything they need to do...  That's a 
> seperate issue.  It allows some minimal, relatively straightforward 
> maintenance to be done on systems that are stuck with older kernels by 
> management fiat.
> 
> The gap is the jump to the next major release.  Suppose that 2.6.15 makes it 
> up to 2.6.15.10, and then 2.6.16 comes out.  Are there any security fixes in 
> 2.6.16 that weren't in 2.6.15.10?  Fixes which would have been in a 2.6.15.11 
> if the next big release had been delayed another two weeks?
> 
> From a practical standpoint, somebody stuck on 2.6.15 for another six months 
> is likely to at least try to apply the next security update (the diff between 
> 2.6.16->2.6.16.1) to their old kernel, but are they missing a week or two's 
> worth of security fixes?

They miss a completely undefined amount of fixes.
Consider e.g. the case that 2.6.16 contains fixes that are later 
identified as possible security issues.

The 2.6.16->2.6.16.1 patch fixes bugs in 2.6.16 - trying to apply it to 
a 2.6.15 kernel might both leave security holes and add new breakages.

> I'm trying to clarify what my question is:  When a new stable kernel comes 
> out, do the dot-release guys do one more release of security-only fixes to 
> patch all the known vulnerabilities that the new one addressed before moving 
> on?  Or do they just leave a gap and say "upgrade"?

There is no last dot-release - and it wouldn't help.

If you are running ftp.kernel.org kernels you have to upgrade to the 
latest one or you will definitely miss security fixes.

If this is a problem for you stay with distribution kernels - 
distributions offer exactly the service of security fixes for their 
kernels for a well-defined amount of time.

> Rob

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

