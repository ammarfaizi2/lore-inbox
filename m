Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265601AbRFWCrm>; Fri, 22 Jun 2001 22:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265602AbRFWCrd>; Fri, 22 Jun 2001 22:47:33 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:14346 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S265601AbRFWCrR>; Fri, 22 Jun 2001 22:47:17 -0400
Message-Id: <200106230246.f5N2kfU82578@aslan.scsiguy.com>
To: David Ford <david@blue-labs.org>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx 
In-Reply-To: Your message of "Fri, 22 Jun 2001 18:32:28 PDT."
             <3B33F1AC.6020603@blue-labs.org> 
Date: Fri, 22 Jun 2001 20:46:41 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Well let me put it this way, I have in no way selected 'rebuild 
>firmware' and several of my freshly untarred/patched to kernels are 
>broken in that they won't compile, why?  lex not found.

Prior to Linus' 2.4.5 release, aic7xxx version 6.1.5 was embedded
in the kernel.  Although corrected almost immediately after its release,
this version attempted to build the firmware at all times.  Although
a lofty goal from an aesthetic standpoint (why should you have generated
files when you have all the source to build them?), it simply doesn't
work on the miriad of distributions out there.   It took a while
for Linus to pick up the change that added the "rebuild firmware"
config option, so you may have a kernel that still has this broken
behavior.  Updates to most recent kernels to the latest aic7xxx driver
can be found here:

http://people.FreeBSD.org/~gibbs/linux/

>Currently I'm pretty bothered because for any of numerous reasons now, I 
>can't get the blasted aic7xxx support in any 2.4 kernel to work.  I'm a 
>little tweaked because my distro is based on 2.4 functionality and I'm 
>stuck on square 0 just trying to boot.

You could always choose to use the older aic7xxx driver.  To this day,
it is still available in the 2.4.X kernels.  I don't have enough details
about your particular problems to know if this will help your situation.

>Several people have made reports about 2.4 and aic7xxx wrt to OOPSes, 
>failure to boot, and hanging and there's very little response to this. 

Perhaps I've missed the reports then.  I've made every effort to repond
to the reports that I've seen, have worked to correct those issues,
and expect to release 6.1.14 early next week.  Unfortunately even
working for Adaptec, our testing resources (number/type of machines)
are limited, so there will always be some bugs left for the userbase
to find.

> To this point I have two machines stuck in 2.2 which desperately need 
>upgraded but I can't upgrade the kernel because the aic code is tragic.
>
>Pardon my frustration,
>David

Can you provide information about your system and how it fails?  I will
need to know driver revision, type of card, and any messages you can
copy down during a failure with "aic7xxx=verbose" set either in LILO
for a statically compiled driver or used when loading the module.  A
dmesg from a system booted with the 2.2 kernel should give me most of
the system information I need.

--
Justin
