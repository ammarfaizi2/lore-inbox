Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272189AbRHXQEN>; Fri, 24 Aug 2001 12:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272202AbRHXQEE>; Fri, 24 Aug 2001 12:04:04 -0400
Received: from ns.suse.de ([213.95.15.193]:39179 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S272189AbRHXQDv>;
	Fri, 24 Aug 2001 12:03:51 -0400
Date: Fri, 24 Aug 2001 18:04:00 +0200
From: Andi Kleen <ak@suse.de>
To: Ben Greear <greearb@candelatech.com>
Cc: Andi Kleen <ak@suse.de>, Bernhard Busch <bbusch@biochem.mpg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Poor Performance for ethernet bonding
Message-ID: <20010824180400.B2848@gruyere.muc.suse.de>
In-Reply-To: <3B865882.24D57941@biochem.mpg.de.suse.lists.linux.kernel> <oupg0ahmv2a.fsf@pigdrop.muc.suse.de> <3B867096.3A1D7DE@candelatech.com> <20010824172256.A2531@gruyere.muc.suse.de> <3B86769D.17A979D7@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B86769D.17A979D7@candelatech.com>; from greearb@candelatech.com on Fri, Aug 24, 2001 at 08:45:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2001 at 08:45:33AM -0700, Ben Greear wrote:
> On the surface, multi-path routing sounds complicated to me, while
> layer-2 bonding seems relatively trivial to set up/administer.  Since we do
> support bonding, if it's a simple fix to make it better, we
> might as well do that, eh?

multipath routing is really not complicated; I don't know why it "sounds"
complicated to you. Of course you could always add new features to the kernel
because the existing ones which do the same thing in a better way
"sound complicated" to someone; I doubt it is a good use of developer time 
however. 

BTW when you would teach bonding about flows it wouldn't be layer-2 anymore.

To kill the "sounds complicated" myth: 

ip route add 10.0.0.0/8 nexthop dev eth0 nexthop dev eth1 

gives you a multipath route with eth0 and eth1 with the same weight for 
10.0.0.0 netmask 255.0.0.0. If you replace 10.0.0.0/8 with default it'll
be your default route. The kernel does the rest.


-Andi
