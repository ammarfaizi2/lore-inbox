Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130600AbRCPUrb>; Fri, 16 Mar 2001 15:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131052AbRCPUrW>; Fri, 16 Mar 2001 15:47:22 -0500
Received: from zeus.kernel.org ([209.10.41.242]:2278 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130600AbRCPUrM>;
	Fri, 16 Mar 2001 15:47:12 -0500
Date: Fri, 16 Mar 2001 12:16:54 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Anton Blanchard <anton@linuxcare.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH]: Only one memory zone for sparc64
Message-ID: <20010316121654.C1771@redhat.com>
In-Reply-To: <20010315191352.D1598@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010315191352.D1598@linuxcare.com>; from anton@linuxcare.com.au on Thu, Mar 15, 2001 at 07:13:52PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 15, 2001 at 07:13:52PM +1100, Anton Blanchard wrote:
> 
> On sparc64 we dont care about the different memory zones and iterating
> through them all over the place only serves to waste CPU. I suspect this
> would be the case with some other architectures but for the moment I
> have just enabled it for sparc64.
> 
> With this patch I get close to a 1% improvement in dbench on the dual
> ultra60.

I'd be surprised if dbench was anything other than disk-bound on most
systems.  On any of my machines, the standard error of a single dbench
run is *way* larger than 1%, and I'd expect to have to run the
benchmark a dozen times to get a confidence interval small enough to
detect a 1% performance change: are your runs repeatable enough to be
this sensitive to the effect of the allocator?

Cheers,
 Stephen
