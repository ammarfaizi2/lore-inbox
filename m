Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313194AbSD3QJL>; Tue, 30 Apr 2002 12:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313589AbSD3QJK>; Tue, 30 Apr 2002 12:09:10 -0400
Received: from h24-78-175-24.vn.shawcable.net ([24.78.175.24]:8321 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S313194AbSD3QJK>;
	Tue, 30 Apr 2002 12:09:10 -0400
Date: Tue, 30 Apr 2002 09:09:34 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: Multipath routes timeouts
Message-ID: <20020430160934.GA12225@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've set up a simple test multipath route out eth1 and eth2 which go to
the same switch.  I'm pinging from the multipath box to another box
plugged in to the switch, and it seems to work nicely.  However,
something seems a bit strange with the timeout when I unplug the link
that is currently being used -- the base_reachable_time and delay_time
works properly (watching "ip neigh"), but then the entry in the routing
table gets a negative timeout, like this:

192.168.253.1 from 192.168.253.254 dev eth2 
    cache  expires -94sec mtu 1500 advmss 1460

I have to wait a while longer before this route expires from route cache
and it then uses the neighbor table again and finds the correct route. 
Is this expected?  If so, why is the timeout negative and decreasing?
(If I run "ip route flush cache" at this point, it immediately finds the
correct route.)

Thanks,

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
