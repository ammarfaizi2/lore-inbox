Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131063AbRCQCve>; Fri, 16 Mar 2001 21:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131531AbRCQCvY>; Fri, 16 Mar 2001 21:51:24 -0500
Received: from linuxcare.com.au ([203.29.91.49]:1042 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S131063AbRCQCvM>; Fri, 16 Mar 2001 21:51:12 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Sat, 17 Mar 2001 13:45:51 +1100
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Only one memory zone for sparc64
Message-ID: <20010317134551.A3403@linuxcare.com>
In-Reply-To: <20010315191352.D1598@linuxcare.com> <20010316121654.C1771@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010316121654.C1771@redhat.com>; from sct@redhat.com on Fri, Mar 16, 2001 at 12:16:54PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I'd be surprised if dbench was anything other than disk-bound on most
> systems.  On any of my machines, the standard error of a single dbench
> run is *way* larger than 1%, and I'd expect to have to run the
> benchmark a dozen times to get a confidence interval small enough to
> detect a 1% performance change: are your runs repeatable enough to be
> this sensitive to the effect of the allocator?

With 2G RAM and:

kill -STOP <kupdated>
echo "90 64 64 256 5120 30720 95 0 0" > /proc/sys/vm/bdflush

I dont do one single disk interrupt for a dbench 60 :)
At this stage dbench runs become more repeatable.

Anton
