Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314613AbSEBPlF>; Thu, 2 May 2002 11:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314614AbSEBPlE>; Thu, 2 May 2002 11:41:04 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:10697 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314613AbSEBPlD>; Thu, 2 May 2002 11:41:03 -0400
Date: Thu, 2 May 2002 10:40:49 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: David Woodhouse <dwmw2@infradead.org>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: <27186.1020352722@redhat.com>
Message-ID: <Pine.LNX.4.44.0205021027340.32217-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002, David Woodhouse wrote:

> > I would like to object here. Getting dependencies right for
> > modversions is very much possible in principle, after all modversions
> > are generated in a deterministic process. (It's also possible in
> > practise, though it's quite a bit of work).
> 
> To what are you objecting? You aren't disagreeing with Keith here. He 
> merely said that there's no chance of him working on modversions until
> the newer build system that's sane w.r.t. dependencies is incorporated.

Well Keith's statement (as I read it) is: modversions are broken, I don't 
support them. My statement is: modversions work 95% of the time, why throw 
them out?

That doesn't mean the could be replaced by something which works more than 
95% of the time later (though 100% will be impossible to achieve anyway 
IMO).

> > Modversions is really essential for distributions, where it's badly
> > needed to keep users from causing hard to track down crashes by
> > inserting self-compiled or obtained from whereever else modules into a
> > kernel which was compiled with a different config.
> 
> Distributions are unlikely to be shipping 2.5 kernels. As long as 
> modversions can be reimplemented properly by the time 2.6 is released, 
> what's the harm in disabling it for a while?
> 
> It's hard enough to keep kbuild-2.5 up to date with recent kernels as it 
> is; let's not keep moving the goalposts by adding new requirements for the 
> initial adoption -- once it's in and the makefiles are maintaining 
> themselves, we can concentrate on reimplementing the niche features.

I merely disagree with the way how things are done here. Al Viro doesn't 
go like: here's a new VFS, everything is handled differently now - oh, and 
for the time being symlinks don't work, I'll fix that until 2.6 (I know 
this is a a bit extreme, but you get the point).

If Keith went like fixing issues one at a time, he wouldn't have that huge 
patch now, which replaces everything and is hard to keep up-to-date. 
There's a lot of orthogonal issues with kbuild which can be solved one at 
a time, e.g. correct dependency generation, cleaning up Makefiles (like 
getting rid of the explicit list-multi link rules), spurious rebuilds, 
building built-in and modular objects in one pass, non-recursive make, ...

My understanding is that the Linux way would have been the latter, going 
one step at a time, as Al Viro demonstrates perfectly with the VFS layer.

This way it would also have been possible to select which features are 
considered worthwhile and which aren't - not "you have to take it all or 
nothing"

Anyway, just my opinion, and yes, I'm admittedly preoccupied.

--Kai
 

