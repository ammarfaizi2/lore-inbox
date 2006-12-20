Return-Path: <linux-kernel-owner+w=401wt.eu-S1030359AbWLTVKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWLTVKU (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbWLTVKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:10:20 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:38705 "EHLO
	clueserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030359AbWLTVKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:10:19 -0500
Date: Wed, 20 Dec 2006 13:10:18 -0800 (PST)
From: alan <alan@clueserver.org>
X-X-Sender: alan@blackbox.fnordora.org
To: Valdis.Kletnieks@vt.edu
cc: davids@webmaster.com, Marek Wawrzyczny <marekw1977@yahoo.com.au>,
       valdis.kletnietks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
In-Reply-To: <200612202052.kBKKqCYr023771@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.64.0612201259010.23352@blackbox.fnordora.org>
References: <MDEHLPKNGKAHNMBLJOLKMEOHAHAC.davids@webmaster.com>
 <200612202052.kBKKqCYr023771@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006, Valdis.Kletnieks@vt.edu wrote:

> On Wed, 20 Dec 2006 11:29:00 PST, David Schwartz said:
>
>> Let's not let the perfect be the enemy of the good. Remember, the goal is to
>> allow consumers to know whether or not their system's hardware
>> specifications are available. It's not about driver availability -- if the
>> hardware specifications are available and a driver is not, that's not the
>> hardware manufacturer's fault.
>
> My point was "their system's hardware specifications" is, for some popular
> vendors, a *very* fuzzy notion. You can't (for instance) say "specs are
> available for a Dell Latitude D820" - there are configurations that specs are
> available for, and configs that aren't.  My D820 has an NVidia card in it - we
> know the answer there.  Do you give a different answer for a D820 that has the
> Intel i950 graphics chipset instead?
>
> Even more annoying, Dell often *changes* the vendor - the line item for the DVD
> drive says "8X DVD+/-RW" (other choices include 24X CD-ROM and 24X CD-RW/DVD).
> Mine showed up with a Philips SDVD8820 - but it's possible that some other D820
> will get some other vendor's DVD (I've seen 2 C820's ordered at the same time,
> they showed up with 2 different vendor's "24X CD-RW/DVD").  It's possible that
> some poor guy is going to get a D820 that has a DVD that we have a known
> buggy driver for - what do we tell *them*?
>
> It's *easy* to do a "semi-good" that tells you if there's drivers for the
> hardware config you're running the program on. But there's 2 problems:
>
> a) You probably already know the answer
> b) By the time you can run the program, it's often too late....
>
> So given those 2 points, what actual value-added info does this *give*, over
> and above 'lspci' and friends?  I suppose maybe for a install CD, it gives
> a quick way to cleanly abort the install with a "Don't bother continuing
> unless it's OK that your graphics/wireless/whatever won't work".  On the
> other hand, the installer should have a grasp on this *already*....
>
> Perfect may be the enemy of the good, but the good is also the enemy of
> stuff claiming to be good but misses on an important design goal...

Valid points, but they are almost more for the distribution than they are 
for the kernel.

I have considered designing a routine for use in Annaconda or some other 
installer that lists all the known hardware and how much of it will 
actually work with that particular distro.  I know some people will not 
care, but many will.  (Especially the people who ask "Will my machine work 
with Linux".)

Many people do not know what they have in the way of hardware.  They 
bought a machine.  What they were sold (or requested) and what they got 
are usually two different things.  They may know a few specifics, but they 
are probably missing important details.  (How many people know the model 
of PCI chip in their machine?  Or who made the IDE chipset?  Or the 
ethernet chipset on the motherboard?)  For those of us that deal with 
hardware every day, this is not as big of an issue as those who bought 
something from Dell or HP and it arrived in a big box pre-assembled.

Is there some way to look at a kernel and determine what drivers are 
"good" and those that are "less good"?  (Other than ordering Alan Cox's 
brain in a jar...)  What needs to be known is the state of the driver for 
kernel X where X maybe something current or woefully out of date.

Maybe instead of an EXPORT_GPL symbol we need a 
EXPORT_THIS_DRIVER_IS_CRAP symbol.

-- 
Q: Why do programmers confuse Halloween and Christmas?
A: Because OCT 31 == DEC 25
