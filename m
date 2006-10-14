Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752113AbWJNH43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbWJNH43 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 03:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbWJNH43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 03:56:29 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54287 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752113AbWJNH42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 03:56:28 -0400
Date: Sat, 14 Oct 2006 09:56:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Driver model.. expel legacy drivers?
Message-ID: <20061014075625.GA30596@stusta.de>
References: <4530570B.7030500@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4530570B.7030500@comcast.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 11:18:35PM -0400, John Richard Moser wrote:
> 
> Here's a silly thought I had a while ago.  Linux has no static ABI for
> device drivers, I think the general argument was between "it's slower"
> and "different hardware will have different requirements."  Putting
> aside design difficulties, I've come up with an example case of a useful
> hardware driver ABI.
> 
> As kernel development goes on, some infrastructure changes require
> drivers to be updated.  Eventually some drivers become buggy and
> ill-maintained, even when they used to be legitimately working ones; and
> then developers have to take some of their time to fix them, or eject
> them from the tree.

The rule is simple:
If you break an in-kernel API, you have to fix all in-kernel users.

No matter how ill-maintained a driver is, that works quite good.

>...
> This brings up a few potential questions:
> 
>   - Will this eventually be necessary to an absolute?  Will 100M
>     tarballs and hundreds of thousands of drivers be unmanageable in a
>     tight, ABI-unstable monolith 10 years from now?

"hundreds of thousands of drivers" won't happen during my lifetime.

If the kernel size only doubles to 100 MB that's no problem.

>   - Would it ACTUALLY be worthwhile, given such a scenario, to expel
>     drivers out of the tree to glue on by a static, somewhat slower but
>     workable ABI so nobody has to touch the code ever?

Documentation/stable_api_nonsense.txt describes why this is nonsense.

And if you anyway don't want to change the kernel API, it doesn't make 
any difference for you whether the drives are shipped with the kernel.

And external drivers with various interdependencies and dependencies 
would be an insane maintenance nightmare.

>   - Is there actually a benefit -now- to ejecting drivers from the tree,
>     or are the developers pretty much comfortable polishing the stuff
>     nobody normally touches here and there?

The goal is to get drivers into the kernel and shipping a complete 
kernel with all drivers.

> Just curious.

This point comes up every few months on this list, so instead of 
starting the same old disussion on this topic please read the old 
discussions in the list archives.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

