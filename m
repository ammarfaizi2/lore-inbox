Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUELBOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUELBOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 21:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbUELBJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 21:09:43 -0400
Received: from web14924.mail.yahoo.com ([216.136.225.8]:20645 "HELO
	web14924.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264913AbUELBH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 21:07:29 -0400
Message-ID: <20040512010727.13816.qmail@web14924.mail.yahoo.com>
Date: Tue, 11 May 2004 18:07:27 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: From Eric Anholt:
To: Dave Airlie <airlied@linux.ie>, Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sf.net
In-Reply-To: <Pine.LNX.4.58.0405120018360.3826@skynet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would int16_t and int32_t work? Those int's were in there before I started
working on it. __u16 and __u32 are Linux kernel defines that aren't always there
in user space.

I would much rather have one h file than two. When we had two the variable and
structure names, comments, etc had drifted over the years until they didn't even
look like the same file anymore. drm.h only defines the ioctls, no internal
kernel structures are exposed.

--- Dave Airlie <airlied@linux.ie> wrote:
> >
> > Ick, you can't use "int" as an ioctl structure member, sorry.  Please
> > use the proper "__u16" or "__u32" value instead.
> 
> I just looked at drm.h and nearly all the ioctls use int, this file is
> included in user-space applications also at the moment, I'm worried
> changing all ints to __u32 will break some of these, anyone on DRI list
> care to comment?
> 
> Dave.
> 
>  >
> > And what about kernels running in 64bit mode with 32bit userspace?  Care
> > to provide the proper thunking layer for them too?
> >
> > thanks,
> >
> > greg k-h
> >
> 
> -- 
> David Airlie, Software Engineer
> http://www.skynet.ie/~airlied / airlied at skynet.ie
> pam_smb / Linux DECstation / Linux VAX / ILUG person
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Sleepycat Software
> Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
> deliver higher performing products faster, at low TCO.
> http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel


=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 
