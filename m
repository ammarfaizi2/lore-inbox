Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263208AbVCDXnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263208AbVCDXnL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263353AbVCDXem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:34:42 -0500
Received: from smartmx-07.inode.at ([213.229.60.39]:11735 "EHLO
	smartmx-07.inode.at") by vger.kernel.org with ESMTP id S263155AbVCDVTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:19:20 -0500
Message-ID: <4228D0D9.9010301@inode.info>
Date: Fri, 04 Mar 2005 22:19:21 +0100
From: Richard Fuchs <richard.fuchs@inode.info>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: slab corruption in skb allocs
References: <42283093.7040405@inode.info> <20050304035309.1da7774e.akpm@osdl.org> <42285354.5090900@inode.info> <20050304201153.GR3163@waste.org>
In-Reply-To: <20050304201153.GR3163@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

_correction_ to my previous mail, this does _not_ happen with the 
eepro100 driver. (sorry for the confusion, i got the kernel images mixed 
up with all the testing i've been doing.)

could this affect the e1000 driver as well?


Matt Mackall wrote:

> Send the output of ethtool, please.

box 1, affected:

Settings for eth0:
         Supported ports: [ TP MII ]
         Supported link modes:   10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
         Supports auto-negotiation: Yes
         Advertised link modes:  10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
         Advertised auto-negotiation: Yes
         Speed: 100Mb/s
         Duplex: Full
         Port: MII
         PHYAD: 1
         Transceiver: internal
         Auto-negotiation: on
         Current message level: 0x000020c1 (8385)
         Link detected: yes



box 2, affected:

         Supported ports: [ TP MII ]
         Supported link modes:   10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
         Supports auto-negotiation: Yes
         Advertised link modes:  10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
         Advertised auto-negotiation: Yes
         Speed: 100Mb/s
         Duplex: Full
         Port: MII
         PHYAD: 1
         Transceiver: internal
         Auto-negotiation: on
         Supports Wake-on: g
         Wake-on: g
         Current message level: 0x00000007 (7)
         Link detected: yes



box 3, not affected:

         Supported ports: [ TP MII ]
         Supported link modes:   10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
         Supports auto-negotiation: Yes
         Advertised link modes:  10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
         Advertised auto-negotiation: Yes
         Speed: 100Mb/s
         Duplex: Full
         Port: MII
         PHYAD: 1
         Transceiver: internal
         Auto-negotiation: on
         Supports Wake-on: g
         Wake-on: g
         Current message level: 0x00000007 (7)
         Link detected: yes


> This tends to be checksum
> offloading not working as it should or the like. Can you repeat this
> with bulk ssh traffic?

yes, with various strange effects:

Received disconnect from 195.58.172.154: 2: Bad packet length 919251405.

or

Received disconnect from 195.58.172.154: 2: Corrupted MAC on input.


cheers
richard
