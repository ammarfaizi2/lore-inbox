Return-Path: <linux-kernel-owner+w=401wt.eu-S1750879AbXAKRRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbXAKRRP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 12:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbXAKRRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 12:17:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:48009 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbXAKRRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 12:17:14 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,174,1167638400"; 
   d="scan'208"; a="184020670:sNHT1167934117"
Message-ID: <45A6710E.1020506@intel.com>
Date: Thu, 11 Jan 2007 09:17:02 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.9 (X11/20061228)
MIME-Version: 1.0
To: castet.matthieu@free.fr
CC: e1000-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [E1000-devel] e1000 : link down issues
References: <1168534773.45a66cf58d25e@imp4-g19.free.fr>
In-Reply-To: <1168534773.45a66cf58d25e@imp4-g19.free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jan 2007 17:17:03.0559 (UTC) FILETIME=[4FF31D70:01C735A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

castet.matthieu@free.fr wrote:
> Hi,
> 
> I got a 82566DM e1000 network controller [1] on my motherboard, and most of the
> time the link go down when doing dhcp. [2]
> 
> ifconfig eth0 up -> link become up
> dhclient eth0 -> some packet are transmited and received and the link become
> down.

I'm unsure whether we saw this problem before or not but it does sound familiar. First I 
would like to ask you to check your motherboards vendor website for a possible BIOS 
update for your motherboard. The 82566DM chipsets are rather new and we have pushed out 
NVM changes to vendors for some known issues.

> I sometimes got e1000_reset: Hardware Error.
> 
> This happen with vanilla 2.6.19 and e1000-7.3.20 drivers.
> 
> This is very anoying because I should do rmmod e1000; modprobe e1000; ifup e1000
> in loop until the link stay up. I try forcing speed, duplex and flow control, but
 > nothing solve my issue.
> 
> The device is working fine on windows.

unfortunately that doesn't say that much. I do know that we are queueing some ich8/82566 
changes for the kernel and if you're willing to try them I can provide patch to the 
kernel netdev tree to you (it was posted here 3 days ago) to try.

Cheers,

Auke


PS feel free to trim lkml from the CC to move this discussion further to e1000-devel 
list only.
