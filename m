Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265605AbRFWDHS>; Fri, 22 Jun 2001 23:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265606AbRFWDHJ>; Fri, 22 Jun 2001 23:07:09 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:17162 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S265605AbRFWDHE>; Fri, 22 Jun 2001 23:07:04 -0400
Message-Id: <200106230307.f5N370U83109@aslan.scsiguy.com>
To: David Ford <david@blue-labs.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx 
In-Reply-To: Your message of "Fri, 22 Jun 2001 19:57:01 PDT."
             <3B34057D.1020409@blue-labs.org> 
Date: Fri, 22 Jun 2001 21:07:00 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I am mixed between packing to move to the east coast right now but I 
>will definitely be providing you some information.  I have to get this 
>system up and running inside the next four days.  I realize this is a 
>bit rude/forward of me, but I would greatly appreciate your help and 
>please tolerate my rushedness :)

Everyone gets frustrated when their system doesn't work.  I even
get frustrated when those using my driver have systems that don't
work. 8-)

>>Prior to Linus' 2.4.5 release, aic7xxx version 6.1.5 was embedded
>>in the kernel.  Although corrected almost immediately after its release,
>>this version attempted to build the firmware at all times.  Although
>>a lofty goal from an aesthetic standpoint (why should you have generated
>>files when you have all the source to build them?), it simply doesn't
>>work on the miriad of distributions out there.   It took a while
>>for Linus to pick up the change that added the "rebuild firmware"
>>config option, so you may have a kernel that still has this broken
>>behavior.  Updates to most recent kernels to the latest aic7xxx driver
>>can be found here:
>>
>>http://people.FreeBSD.org/~gibbs/linux/
>>
>
>I agree with the above except for the usage of external library headers 
>such as db.h.  I tried numerous sleepycat builds but they all returned 
>errors with the particular db.h.

The assembler is a userland utility, so it relies on userland headers.
In systems where the kernel and userland are maintained by the same
people, this isn't much of a problem.  However, Linux doesn't work this
way.

Hopefully you will never have to rebuild the firmware manually.

>>You could always choose to use the older aic7xxx driver.  To this day,
>>it is still available in the 2.4.X kernels.  I don't have enough details
>>about your particular problems to know if this will help your situation.
>>
>
>How does one go about choosing the older driver?  I didn't see a config 
>option for it.

In the SCSI driver's section, there should be two drivers listed.  Perhaps
your distro chose to change that, but at least SuSE and Red Hat have kept
to this policy.

>>Can you provide information about your system and how it fails?  I will
>>need to know driver revision, type of card, and any messages you can
>>copy down during a failure with "aic7xxx=verbose" set either in LILO
>>for a statically compiled driver or used when loading the module.  A
>>dmesg from a system booted with the 2.2 kernel should give me most of
>>the system information I need.
>>
>
>I will dig out a serial cable and update the boot floppy I'm using.  Do 
>you suggest I start these proceedings again with a 2.4.5+ kernel?  What 
>is your recommendation on this, -preN or -acN etc?  I'll build a 2.2 and 
>log the info.

I don't usually keep up with the various "pre" or "ac" kernels, so I
can't give you pointers about which ones are more stable, etc.  As
far as the aic7xxx driver is concerned, they should all work the same.
I primarally provide patches for release kernels, so that may limit
what kernels you can use to get up to the latest aic7xxx driver.

--
Justin
