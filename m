Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUGQL6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUGQL6I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 07:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266704AbUGQL6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 07:58:08 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:60816 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266703AbUGQL6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 07:58:05 -0400
Message-ID: <40F9144A.9010107@yahoo.com.au>
Date: Sat, 17 Jul 2004 21:58:02 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Blueman <daniel.blueman@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.7, e1000] large MTU allocation failure...
References: <25348.1090062249@www11.gmx.net>
In-Reply-To: <25348.1090062249@www11.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Blueman wrote:
> When I try to enable jumbo frames, and increase the MTU size to 9000 octets
> [1], I see allocation failures in the kernel logs [2].
> 
> Is there another way of enabling jumbo frames and use a large MTU?
> 
> Kernel is stock 2.6.7, IA32.
> 
> --- [1]
> 
> # ifconfig eth0 mtu 9000
> 
> --- [2]
> 
> Intel(R) PRO/1000 Network Driver - version 5.2.52-k4
> Copyright (c) 1999-2004 Intel Corporation.
> e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network
> Connection
> e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps
> Full Duplex
> ifconfig: page allocation failure. order:3, mode:0x20

Order 3 GFP_ATOMIC allocation failures aren't really surprising.

I wonder if things can be improved in the network system. If not,
I have a possible workaround for the problem.
