Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132592AbRADMeI>; Thu, 4 Jan 2001 07:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132676AbRADMd7>; Thu, 4 Jan 2001 07:33:59 -0500
Received: from linuxcare.com.au ([203.29.91.49]:56580 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S132592AbRADMdn>; Thu, 4 Jan 2001 07:33:43 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Thu, 4 Jan 2001 23:32:11 +1100
To: Andi Kleen <ak@suse.de>
Cc: Daniel Phillips <phillips@innominate.de>,
        ludovic fernandez <ludovic.fernandez@sun.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
Message-ID: <20010104233211.A20942@linuxcare.com>
In-Reply-To: <3A53D863.53203DF4@sun.com> <3A5427A6.26F25A8A@innominate.de> <20010104091118.A18973@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010104091118.A18973@gruyere.muc.suse.de>; from ak@suse.de on Thu, Jan 04, 2001 at 09:11:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I think a better way to proceed would be to make semaphores a bit more 
> intelligent and turn them into something like adaptive spinlocks and use
> them more where appropiate (currently using semaphores usually causes
> lots of context switches where some could probably be avoided). Problem
> is that for some cases like your producer-consumer pattern (which has been
> used previously in unreleased kernel code BTW) it would be a pessimization
> to spin, so such adaptive locks would probably need a different name.

Like solaris adaptive mutexes? It would be interesting to test,
however considering read/write semaphores are hardly ever used these
days we want to be sure they are worth it before adding yet another
synchronisation primitive.

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
