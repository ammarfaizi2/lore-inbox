Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265324AbSJRVjp>; Fri, 18 Oct 2002 17:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbSJRVjp>; Fri, 18 Oct 2002 17:39:45 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:238 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265324AbSJRVjn>;
	Fri, 18 Oct 2002 17:39:43 -0400
Subject: Re: x86 timer clean ups
From: john stultz <johnstul@us.ibm.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200210182133.g9ILX0F15855@eng2.beaverton.ibm.com>
References: <200210182133.g9ILX0F15855@eng2.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Oct 2002 14:37:25 -0700
Message-Id: <1034977045.4047.27.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I need a flag for the TSC stuff that allows me to turn it off completely 
> (the 
>  voyagers run CPUs from physically different clocks, and TSC drift causes 
> huge 
>  jitters in this case).
>  
>  How about two compile options:
>  
>  CONFIG_X86_TSC meaning check for TSC and use it if it's OK
>  CONFIG_X86_PIT meaning use the PIT timer if the TSC isn't OK (or isn't 
> wanted)

Hmmm. I was thinking of possibly doing something similar to the 2.4
CONFIG_X86_HAS_TSC and CONFGI_X86_TSC_DISABLE, but I believe Linus
wasn't super happy about negative config options. You're usage sounds
reasonable, but since this is a cleanup item, do you mind if we both
look at the issue a bit more next week?

>  P.S. what about this CONFIG_X86_CYCLONE thing?  It doesn't seem to be 
> hooked 
>  into the timer infrastructure, should it be?

Not right this second. I'm waiting for the summit subarch code to
stabilize, then I'll hook it in correctly.

thanks
-john

