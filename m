Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273836AbRIXJo6>; Mon, 24 Sep 2001 05:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273842AbRIXJov>; Mon, 24 Sep 2001 05:44:51 -0400
Received: from embolism.psychosis.com ([216.242.103.100]:16146 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S273836AbRIXJof>; Mon, 24 Sep 2001 05:44:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: David Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] PART1: Proposed init & module changes for 2.5
Date: Mon, 24 Sep 2001 05:44:18 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15lOLW-0000SC-00@wagner>
In-Reply-To: <E15lOLW-0000SC-00@wagner>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15lSGp-0000Ul-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 September 2001 1:31, Rusty Russell wrote:

> Convinced yet?

If it's cleaner in operation then the current system, yes.
What we've got now just seems so ugly.

> Why not just put them in the initrd image?  

Because images are not dynamic.  : P 

> Um, how do you get the modules into grub then?  If it can read ext2 at
> boot, then it could create an initrd for me.  Otherwise, how is it
> different from creating an initrd?

Yep you're still using LILO...(that still does that absolute block
offset shit.) GRUB is like syslinux in that it can read FS. But not just
ext2. It also knows reiserfs, fat, bsd, and some more. It also has a complete 
interactive commandline. Is more of a 'boot shell'. I gave you a like. Go try 
it. : >

Only the GRUB loader itself sits on an sbsolute sector.
So via the ominopotent symlink, you would need to do...nothing
after you install a new kernel to boot. With initrd, you would have
to make another initrd. But actually you would need one for every
kernel. (I've kept up to 6 active on my box at one time...)
This sucks...and it's why we all compile everything we really need static.

BTW if your initrd images gets corrupted or lost, you are paddling up fecal 
creek with your hands.  Let's not forget how much fun it is if you get a 
library mismatch on your initrd boot utils. Hope you compiled them all
static.

Loading system critcal kernel modules should be as straight forward
as the feature I'm requesting. The boot loader puts it in memory. The kernel 
loads it from memory. It's all good.

> It'd be easy to implement now.  But it won't gain us anything, since
> we'll all be using initrd-tng in 2.5 anyway.

Oh jesus...what have I missed? (I've been off the list a long time)

> Cheers,
> Rusty.
> PS.  Am big fan of LRP: it rocks.

I hope so...you're still imortalized in the POSIXness script. ; >
LRP is unfortunatly dated to the point it doesn't really rock right
now. : < It's simply cool.  : > If I ever get to work on LRP v5.0... (Hell I 
never got to release V4.0... : P) it will rock like nothing else ever has.

But since you bring up LRP, let's get down into the minimal space issues.
It's a living hell tring to maintain kernels in an OS distibution and a 
primary reason is that you have to play roulette deciding what to make
static. Then when you get it good, you have to fuck it all up to squeeze
it onto a boot disk. Adding what I want fixes this quite well. 

With the work I've done with LRP and embedded systems, I doubt many people
out there have played with the initrd more then me. If you haven't noticed
I'm back on the list because I just posted a new version of initrd dynamic
with tmpfs. It's a lifesaver for initrd, since now the FS 'creatation' is 
100% dynamic the the 'image' can be multiple tar.gz archives.

However as clean as it is, it's still not something I would want
to load critical kernel parts for boot.

Saying one should use only initrd for this is like saying the kernel
should not handle starting MD devices at all. 

As a programming ethic it sounds good but I think few programmer have
actually used some of these ideals in 'real world' system
adminstration. Try finding yourself staring at a mission critical server
that you now can not get to boot at 03:00 and you can't get
out to the net. That sort of experience changes your perspective. Been there.
Many times. No fun.

So just code this feature for me. Please. Make Dave happy.  ; >


Dave

-- 
The time is now 22:19 (Totalitarian)  -  http://www.ccops.org/clock.html
