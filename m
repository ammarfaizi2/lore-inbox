Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWARSON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWARSON (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWARSOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:14:12 -0500
Received: from mail.dvmed.net ([216.237.124.58]:38073 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964907AbWARSOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:14:11 -0500
Message-ID: <43CE8567.5040205@pobox.com>
Date: Wed, 18 Jan 2006 13:13:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Jens Axboe <axboe@suse.de>, jeffrey.t.kirsher@intel.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] e1000 C style badness
References: <20060118080738.GD3945@suse.de> <20060118083721.GA4222@suse.de> <9e4733910601180953i11963df9n232cd8980c4bf7f2@mail.gmail.com>
In-Reply-To: <9e4733910601180953i11963df9n232cd8980c4bf7f2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Jon Smirl wrote: > e1000 is failing the same way for me
	too. Chip is on the motherboard: > Intel Corporation 82540EM Gigabit
	Ethernet Controller (rev 02) [...] > I am using an old switch so I
	normally get a half duplex connection: > Jan 18 10:14:25 jonsmirl
	kernel: e1000: eth0: e1000_watchdog_task: NIC > Link is Up 100 Mbps
	Half Duplex > I don't normally get the NETDEV up and changed
	notifications. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> e1000 is failing the same way for me too. Chip is on the motherboard:
> Intel Corporation 82540EM Gigabit Ethernet Controller (rev 02)
[...]
> I am using an old switch so I normally get a half duplex connection:
> Jan 18 10:14:25 jonsmirl kernel: e1000: eth0: e1000_watchdog_task: NIC
> Link is Up 100 Mbps Half Duplex
> I don't normally get the NETDEV up and changed notifications.

e1000 is failing for everybody :(  Looks like somewhere in this 40-patch 
behemoth, an "e1000 doesn't work anymore" change slipped in.

We'll get it fixed ASAP, even if it means reverting all those patches.

	Jeff


