Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262761AbTCSALX>; Tue, 18 Mar 2003 19:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262776AbTCSALX>; Tue, 18 Mar 2003 19:11:23 -0500
Received: from 12-225-92-115.client.attbi.com ([12.225.92.115]:8065 "EHLO
	p3.coop.hom") by vger.kernel.org with ESMTP id <S262761AbTCSALW>;
	Tue, 18 Mar 2003 19:11:22 -0500
Date: Tue, 18 Mar 2003 16:21:19 -0800
From: Jerry Cooperstein <coop@axian.com>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, hemminger@osdl.org
Subject: Re: seqlock/unlock(&xtime_lock) problems cause keyboard, time skew problems
Message-ID: <20030319002119.GA5351@p3.attbi.com>
References: <20030318190557.GA14447@p3.attbi.com> <1048019543.6294.3.camel@dell_ss3.pdx.osdl.net> <20030318205907.GB4081@p3.attbi.com> <200303182340.h2INeE4r098586@northrelay04.pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303182340.h2INeE4r098586@northrelay04.pok.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 03:34:32PM -0800, john stultz wrote:
... 
> Check the boot msgs. You're kernel is compiled w/ CONFIG_X86_TSC, so it
> should print a warning as such stating it is ignoring the notsc option.

yep, I missed it, the experiment was never performed.

> 
> Try compiling the kernel for i386 and the kernel then boot w/ notsc. Do be
> warned, if you're running w/ an i686 compiled glibc your box will hang
> after the "Freeing unused kernel memory: " msg. 

I compiled for no TSC using Stephen Hemminger's patch -- that worked.

> 
> Another thing to check is if the lost-tick compensation code is biting you.
> Try commenting out the "detect_lost_tick()" call from timer_interrupt() in
> arch/i386/kernel/time.c

I will try that out too, even though problem now seems 'solved.'

> 
> Let me know if that changes anything.
> 
> thanks
> -john

thanks

coop


