Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751684AbWCMGPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbWCMGPu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 01:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbWCMGPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 01:15:49 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:7578 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751430AbWCMGPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 01:15:49 -0500
Date: Mon, 13 Mar 2006 01:11:05 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Router stops routing after changing MAC Address
To: Greg Scott <GregScott@InfraSupportEtc.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Message-ID: <200603130115_MC3-1-BA82-CE7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <925A849792280C4E80C5461017A4B8A20321CC@mail733.InfraSupportEtc.com>

On Fri, 10 Mar 2006 18:33:15 -0600, Greg Scott wrote:

> How to change MAC addresses is documented well enough - and it works -
> but when I change MAC addresses, my router stops routing.  From the
> router, I can see the systems on both sides - but the router just
> refuses to forward packets.  Here are my little test scripts to change
> MAC Addresses.
> 
> First - ip-fudge-mac.sh
> [root@test-fw2 gregs]# more ip-fudge-mac.sh
> ip link set eth0 down
> ip link set eth0 address 01:02:03:04:05:06
                            ^
 Bit zero is set, so this is a multicast address.  Is that intentional?

> ip link set eth0 up
> 
> ip link set eth1 down
> ip link set eth1 address 17:20:16:01:60:03
                            ^
 Ditto.

> ip link set eth1 up
> 
> echo "1" > /proc/sys/net/ipv4/ip_forward


-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"

