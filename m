Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265075AbSJWQwH>; Wed, 23 Oct 2002 12:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbSJWQwH>; Wed, 23 Oct 2002 12:52:07 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:50056 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265075AbSJWQwG>;
	Wed, 23 Oct 2002 12:52:06 -0400
Subject: Re: [PATCH] linux-2.5.44_vsyscall_A1
From: john stultz <johnstul@us.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: lkml <linux-kernel@vger.kernel.org>, andrea <andrea@suse.de>, ak@muc.de,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       george anzinger <george@mvista.com>, Jeff Dike <jdike@karaya.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
In-Reply-To: <3DB60363.8040104@pobox.com>
References: <1035336629.954.90.camel@cog>  <3DB60363.8040104@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 23 Oct 2002 09:56:55 -0700
Message-Id: <1035392218.2484.9.camel@laptop.cornchips.homelinux.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 19:03, Jeff Garzik wrote:
> > Please let me know your thoughts about 2.5 integration. 
> 
> In terms of implementation, I think it's way too x86-specific...  some 
> of the vsyscall infrastructure can be more generic, making it easier for 
> other arches to implement the same functionality.  Also use of TSC isn't 
> a terribly good idea...

I'd actually be very interested in making this more generic, although
I'm unsure how. You have a very platform specific change to the linker
scripts, then a userspace implementation of that platforms gettimeofday.
Any suggestions as to what part could be generalized?  

As for the TSC, while its very true that the TSC can cause problems on
some systems, most systems still use it as a valid time source in
do_gettimeoffset(). Alternative time sources (cyclone, HPET) could be
mapped in and used as well on those systems that cannot use the TSC
reliably.  

thanks for the feedback!
-john

