Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVBTU17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVBTU17 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 15:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVBTU17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 15:27:59 -0500
Received: from smtp4.poczta.onet.pl ([213.180.130.28]:45547 "EHLO
	smtp4.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S261852AbVBTU16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 15:27:58 -0500
From: Piotr Rzezniczak <djv@op.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Wake-on-LAN/PCI Linux support
Date: Sun, 20 Feb 2005 21:28:17 +0100
User-Agent: KMail/1.7.2
Cc: djv@op.pl
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200502202128.17378.djv@op.pl>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does Linux currently support Wake-on-LAN/PCI? I have a 3Com
> 3c905 TX-M NIC which supports wake-on-LAN and wake-on-PCI.
> On Windows XP, I have configured the system so that I can use
> "ether-wake" to wake up mysystem from standby/hibernation
> remotely through the network.  
(cut) 
> However, when I shut down linux by using "init 0", the system
> gets totally shut down, including the NIC. The switch port for
> the NIC shows the card is not mantaining the link and thus,
> "ether-wake" is totally useless. 

I found the following solution for the same problem:
- use standard 3c59x driver from kernel sources (even for 3c90x cards)
- load this driver as a kernel module
- add the following entry in /etc/modules:
 ---- cut ----
 3c59x options=0x408
 ---- cut ----

Wake-on-lan works properly now with 3com 905cx-tx-m card (3c905c) on my 
Debian 3.1 (unstable) and 2.6.10 kernel

greetings
Piotr (djv) Rzezniczak
