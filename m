Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284656AbRLEUYg>; Wed, 5 Dec 2001 15:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284665AbRLEUYV>; Wed, 5 Dec 2001 15:24:21 -0500
Received: from z.thunderworx.net ([217.27.32.64]:25874 "EHLO francoudi.com")
	by vger.kernel.org with ESMTP id <S284656AbRLEUWt>;
	Wed, 5 Dec 2001 15:22:49 -0500
Date: Wed, 5 Dec 2001 22:22:35 +0200
From: Vladimir Ivaschenko <hazard@francoudi.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sendmsg() leaves Identification field in IP header empty
Message-ID: <20011205222235.A7572@francoudi.com>
In-Reply-To: <3C0E6F8B.A6C85AB6@francoudi.com.suse.lists.linux.kernel> <p73d71t8md0.fsf@amdsim2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <p73d71t8md0.fsf@amdsim2.suse.de>; from ak@suse.de on Wed, Dec 05, 2001 at 09:04:27PM +0100
X-Operating-System: Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote about "Re: sendmsg() leaves Identification field in IP header empty":

> 
> In theory the hack from TCP could be ported to UDP too, but I'm not sure if it is
> worth it for WCCP (to be honest I don't know what WCCP is so I cannot assess if 
> it's important enough to add a workaround for it) 

Andi, thanks a lot for the insight, I will try your suggestions.  
WCCP is a Web Cache Communication Protocol; it is used by Cisco
routers to forward traffic to proxies. What is confusing is that
send() generates an ID for packets with DF set, at least when
used in a way like Squid uses it. I briefly checked Squid source
code and didn't find any places where it would disable MTU Path
discovery.

> > Sorry if I'm wrong but I think this is a kernel problem because
> > sendmsg() is a system call. On RH6.2 with 2.2.19 this doesn't happen,
> 
> It's strictly not a bug because the RFCs don't require an IPID for !DF.

Ok, an intercompatibility issue. :-)

-- 
Best Regards
Vladimir Ivaschenko
Certified Linux Engineer (RHCE)
