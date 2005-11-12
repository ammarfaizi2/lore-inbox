Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVKLDv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVKLDv0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 22:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVKLDv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 22:51:26 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:31411
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751202AbVKLDv0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 22:51:26 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: Which version of 2.6.11 is most stable
Date: Fri, 11 Nov 2005 21:49:08 -0600
User-Agent: KMail/1.8
Cc: "Mukund JB." <mukundjb@esntechnologies.co.in>,
       linux-kernel@vger.kernel.org
References: <3AEC1E10243A314391FE9C01CD65429B13B280@mail.esn.co.in> <20051107115131.GD3847@stusta.de>
In-Reply-To: <20051107115131.GD3847@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200511112149.08324.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 November 2005 05:51, Adrian Bunk wrote:
> On Mon, Nov 07, 2005 at 03:38:13PM +0530, Mukund JB. wrote:
> > Dear All,
> >
> > I am in the phase of development of a Linux BSP for 2.6.11 kernel.
> > Which version of 2.6.11 kernel can be called best stable? In general
> > where do i get this king of info? I serched in the www.lwn.net but i
> > failed to get the required info.
>
> The latest, IOW 2.6.11.12 .
>
> But note that the 2.6.11 branch is no longer maintained since kernel
> 2.6.12 was released 5 months ago, and therefore lacks e.g. current
> security fixes.

One question I've wondered about for a bit...

The diff between each dot release (ala 2.6.12.0->2.6.12.1) can theoretically 
be backported to an older kernel.  So in theory, at least some of the new 
security fixes can be applied to older kernels.  (Yeah, this necessarily 
complete.  Whether or not the patch makes any sense at all in the older 
context, and whether or not that's everything they need to do...  That's a 
seperate issue.  It allows some minimal, relatively straightforward 
maintenance to be done on systems that are stuck with older kernels by 
management fiat.

The gap is the jump to the next major release.  Suppose that 2.6.15 makes it 
up to 2.6.15.10, and then 2.6.16 comes out.  Are there any security fixes in 
2.6.16 that weren't in 2.6.15.10?  Fixes which would have been in a 2.6.15.11 
if the next big release had been delayed another two weeks?

>From a practical standpoint, somebody stuck on 2.6.15 for another six months 
is likely to at least try to apply the next security update (the diff between 
2.6.16->2.6.16.1) to their old kernel, but are they missing a week or two's 
worth of security fixes?

I'm trying to clarify what my question is:  When a new stable kernel comes 
out, do the dot-release guys do one more release of security-only fixes to 
patch all the known vulnerabilities that the new one addressed before moving 
on?  Or do they just leave a gap and say "upgrade"?

Rob
