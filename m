Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUCaIk6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 03:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUCaIk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 03:40:58 -0500
Received: from ASte-Genev-Bois-101-1-4-241.w217-128.abo.wanadoo.fr ([217.128.44.241]:15112
	"EHLO slartibartfast.qube.net") by vger.kernel.org with ESMTP
	id S261851AbUCaIk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 03:40:57 -0500
Date: Wed, 31 Mar 2004 10:40:53 +0200
From: Ignacy Gawedzki <ig@zenon.mine.nu>
To: linux-kernel@vger.kernel.org
Cc: David Stevens <dlstevens@us.ibm.com>,
       USAGI users <usagi-users@linux-ipv6.org>
Subject: Re: (usagi-users 02870) Re: IPv6 multicast in 2.4.25 broken?
Message-ID: <20040331084053.GA25253@zenon.mine.nu>
Mail-Followup-To: Ignacy Gawedzki <ig@zenon.mine.nu>,
	linux-kernel@vger.kernel.org, David Stevens <dlstevens@us.ibm.com>,
	USAGI users <usagi-users@linux-ipv6.org>
References: <20040324185243.GB27409@zenon.mine.nu> <OFE1BE522F.02DB03E7-ON88256E67.00767AD5-88256E67.0077576D@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFE1BE522F.02DB03E7-ON88256E67.00767AD5-88256E67.0077576D@us.ibm.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 01:47:06PM -0800, thus spake David Stevens:
>    Can you reproduce this in a small test program and send me
>    the source? Also, the contents of /dev/proc/igmp6 and any
>    arguments you ran the program with would be helpful.

Not at this time, as I would have to reinstall a 2.4.25 kernel.  But I
plan to do the testing soon.

>    At first I thought it might be that you have an MLD-snooping
>    switch that doesn't understand MLDv2 packets, but ff02::1 is
>    the all-nodes address which all hosts join, and which is not
>    advertised at all. That should work if you're receiving any
>    multicasts at all.

Well, I see those packets with tcpdump on both the sending and receiving
interfaces, so no ethernet equipment is involved.  Moreover, the same
code works perfectly on 2.4.24, which should indicate that there are
some changes between the two (more precisely between 2.4.24 and
2.4.25-pre4) that break something.  Somehow the multicast packets are
received but not relayed to the socket...

-- 
 "The whole problem with the world is that fools and fanatics are
   always so certain of themselves, and wiser people so full of doubts."
                                                 - Bertrand Russell
