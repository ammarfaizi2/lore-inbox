Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVDCF2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVDCF2k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 00:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVDCF2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 00:28:40 -0500
Received: from weber.sscnet.ucla.edu ([128.97.42.3]:1695 "EHLO
	weber.sscnet.ucla.edu") by vger.kernel.org with ESMTP
	id S261172AbVDCF2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 00:28:38 -0500
Message-ID: <424F7EC4.1000107@cogweb.net>
Date: Sat, 02 Apr 2005 21:27:32 -0800
From: David Liontooth <liontooth@cogweb.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: venza@brownhat.org, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: ICS1883 LAN PHY not detected
References: <424EF19B.7030105@cogweb.net> <424F45F0.1000504@pobox.com>
In-Reply-To: <424F45F0.1000504@pobox.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> David Liontooth wrote:
>
>> 0000:02:0b.0 Ethernet controller: Marvell Technology Group Ltd. Yukon 
>> Gigabit Ethernet 10/100/1000Base-T Adapter (rev 13)
>
> You want the sk98lin or skge drivers.

Correct -- that one worked already in Debian-Installer. What was 
confusing is that the Gigabyte K8NS Ultra-939 board has a second 
gigabyte NIC, identified in the motherboard manual as a 100/10 ICS1883 
LAN PHY, that is in fact an nforce gigabyte controller, part of the 
nforce3 250 chipset (cf. 
http://cogweb.net/owens/Images/Gigabyte-K8NS-Ultra-939.jpg line 5). For 
some reason the PCI ID 00E6 doesn't show up in lspci, so I thought it 
was not detected by the kernel. However, the forcedeth driver brought it 
to life.

Dave

