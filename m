Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVCAUUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVCAUUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 15:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVCAUUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 15:20:50 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:909 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S262015AbVCAUUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 15:20:43 -0500
Message-ID: <4224CE98.2060204@candelatech.com>
Date: Tue, 01 Mar 2005 12:20:40 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network speed Linux-2.6.10
References: <Pine.LNX.4.61.0503011426180.578@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0503011426180.578@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> 
> Conditions:
> 
> Intel NIC e100 device driver. Two identical machines.
> Private network, no other devices. Connected using a Netgear switch.
> Test data is the same thing sent from memory on one machine
> to a discard server on another, using TCP/IP SOCK_STREAM.
> 
> If I set both machines to auto-negotiation OFF and half duplex,
> I get about 9 to 9.5 megabytes/second across the private wire
> network.
> 
> If I set one machine to full duplex and the other to half-duplex
> I get 10 to 11 megabytes/second transfer across the network,
> regardless of direction.

That is asking for all sorts of trouble.

> If I set both machines to auto-negotiation OFF and full duplex,
> I get 300 to 400 kilobytes/second regardless of the direction.

Check for errors in the NICs counters (/proc/net/dev/) in this case.
It appears it is not actually set to full-duplex, or maybe it's
10Mbps-FD.  Use ethtool to see the actual settings.

What happens if you just don't muck with the NIC and let it auto-negotiate
on it's own?

Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

