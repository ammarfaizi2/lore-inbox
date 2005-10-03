Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbVJCFTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVJCFTr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 01:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVJCFTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 01:19:47 -0400
Received: from bay104-f41.bay104.hotmail.com ([65.54.175.51]:5748 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1750836AbVJCFTr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 01:19:47 -0400
Message-ID: <BAY104-F41A96EAB08C0ED655EBA34DF800@phx.gbl>
X-Originating-IP: [67.177.1.243]
X-Originating-Email: [paveraware@hotmail.com]
From: "Christensen Tom" <paveraware@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: tg3 and or pci-e bug
Date: Mon, 03 Oct 2005 05:19:44 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 03 Oct 2005 05:19:46.0979 (UTC) FILETIME=[12106730:01C5C7DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 3 supermicro systems based on the x6dal-tb2 motherboard.  It has 
built in broadcom 5721 gig-e pci-e nics.  eth0 on these boxes fails whenever 
a decent amount of data is pushed across them (decent being ~100Mb).  At 
this point I can say when it fails I get these error messages in 
/var/log/messages:
Oct  2 19:08:53 office kernel: NETDEV WATCHDOG: eth0: transmit timed out
Oct  2 19:08:53 office kernel: tg3: eth0: transmit timed out, resetting
Oct  2 19:08:53 office kernel: tg3: tg3_stop_block timed out, ofs=1400 
enable_bit=2
Oct  2 19:08:53 office kernel: tg3: tg3_stop_block timed out, ofs=c00 
enable_bit=2
Oct  2 19:08:53 office kernel: tg3: tg3_stop_block timed out, ofs=4800 
enable_bit=2
Oct  2 19:08:53 office kernel: tg3: eth0: Link is down.

I made a cron job to log ifconfig output to a file every minute.  This shows 
that the NIC resets itself at least every couple minutes when data is being 
passed.  The TX/RX stats in ifconfig reset to 0.  The above message in 
/var/log/messages doesn't happen every time the NIC resets like this.  I 
think that the NIC is resetting because of some bug, and sometimes, the 
reset fails and locks the NIC, creating the above messages.  The above only 
happens once or twice a day, the other nic resets happen as I said every 2-3 
minutes.  Is there any information that would be helpful in debugging this 
problem?  Let me know what to run and I'll do it.  Eth1 never has this 
problem, I have pushed 5GB+ onto the box over eth1 and it doesn't blink.
Tom


