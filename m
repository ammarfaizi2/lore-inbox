Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264427AbSIQRgC>; Tue, 17 Sep 2002 13:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264440AbSIQRgC>; Tue, 17 Sep 2002 13:36:02 -0400
Received: from [195.223.140.120] ([195.223.140.120]:26432 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S264427AbSIQRgB>; Tue, 17 Sep 2002 13:36:01 -0400
Date: Tue, 17 Sep 2002 19:41:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Peter Waechtler <pwaechtler@mac.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Oops in sched.c on PPro SMP
Message-ID: <20020917174123.GU11605@dualathlon.random>
References: <20020916154233.GH11605@dualathlon.random> <8F7381E4-CA60-11D6-8873-00039387C942@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8F7381E4-CA60-11D6-8873-00039387C942@mac.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 07:11:52PM +0200, Peter Waechtler wrote:
> Once I had a machine check exception - sine then I lowered the CPU clock.
> After the box was running fine with 180MHz I switched to 200MHz
> (yes, I overclocked the CPUs with 233MHz 2 or 3 years - without problems)

I guess this explain the corruption. Please make sure the cpu are not
overclocked at all and then try to reproduce. You cannot choose 180mhz
or 200mhz randomly based on which kernel crashes or not, if the cpu are
180mhz ppro you should use 180mhz only, 200mhz will break.  It won't
break so easily as 233mhz, but it will, the timings are strict on smp.
So please try to reproduce at 180mhz if the cpu should run at 180mhz.

I don't want to sound boring but please next times try if you can
reproduce on non overclocked hardware before reporting anything to l-k.

Andrea
