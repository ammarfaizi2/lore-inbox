Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269788AbRHIMht>; Thu, 9 Aug 2001 08:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269785AbRHIMhk>; Thu, 9 Aug 2001 08:37:40 -0400
Received: from ns.suse.de ([213.95.15.193]:6160 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S269784AbRHIMh2>;
	Thu, 9 Aug 2001 08:37:28 -0400
Date: Thu, 9 Aug 2001 14:37:20 +0200
From: Andi Kleen <ak@suse.de>
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ARP misbehaviour
Message-ID: <20010809143720.A14368@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.31.0108091335210.25815-100000@pc40.e18.physik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0108091335210.25815-100000@pc40.e18.physik.tu-muenchen.de>; from rkuhn@e18.physik.tu-muenchen.de on Thu, Aug 09, 2001 at 02:15:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 10.187.185.11    dev eth1                scope link
> 129.187.154.0/24 dev eth0  proto kernel  scope link  src 129.187.154.217
^^^^^^^^^^^^^^^^^^^^^^^^^^^

> ======================================================================
> root@pc40:/ > arping 192.168.1.254
> ARPING 192.168.1.254 from 129.187.154.153 eth0
                            ^^^^^^^^^^^^^^^^

arp_filter checks the source address, and the route for that source
address is on eth0, so it is perfectly correct.

You need to change your routing so that the 129.187.154.153 route goes
through eth1 or alternatively add blackhole policy routing with
eth0's address as source address.


-Andi

P.S.: Cross posting this way is very impolite. Don't do it.

