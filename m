Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314073AbSEHNWC>; Wed, 8 May 2002 09:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314124AbSEHNWB>; Wed, 8 May 2002 09:22:01 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:22678 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314073AbSEHNWA>;
	Wed, 8 May 2002 09:22:00 -0400
Date: Wed, 8 May 2002 18:54:57 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockfree rtcache lookup using RCU
Message-ID: <20020508185457.I10505@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020508125711.B10505@in.ibm.com> <20020508.011008.107273722.davem@redhat.com> <20020508142433.D10505@in.ibm.com> <20020508.020932.128330582.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 02:09:32AM -0700, David S. Miller wrote:
> The more common situation is server N IP (where N is 1 or a very small
> number), destination clients == thousands of IPs.
> 
> So looking up the same dst cache entry with each benchmark client
> is very unrealistic.  Try a unique IP address for every single lookup.

Ok, how about this then -

A large number of processes of which small sets may look up the same
ip address. dst ip addresses change after every 50 packets or
so.

Is this more realistic ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
