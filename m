Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbTEIDky (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 23:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbTEIDky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 23:40:54 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:44752 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262284AbTEIDkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 23:40:53 -0400
Message-ID: <3EBB25FD.7060809@nortelnetworks.com>
Date: Thu, 08 May 2003 23:52:29 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn't work due to /dev/rtc issues
References: <3EBAD63C.4070808@nortelnetworks.com> <20030509001339.GQ8978@holomorphy.com> <Pine.LNX.4.50.0305081735040.2094-100000@blue1.dev.mcafeelabs.com> <20030509003825.GR8978@holomorphy.com> <Pine.LNX.4.53.0305082052160.21290@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Thu, 8 May 2003, William Lee Irwin III wrote:
>>>>Why would you want to use an interrupt? Just count jiffies in sched.c

I'm trying to get a feel for the maximum time from an interrupt coming in until 
the userspace handler gets notified.  On intel you can program the hardware to 
generate interupts through /dev/rtc.  The powerpc doesn't seem to support this.

Jiffies are not accurate enough, I am expecting max latencies in the 1-2 ms range.

> Does it have a printer port like the Intel machines?

Unfortunately no.  USB/Firewire/Ethernet on the desktop, ethernet/serial for 
compactPCI.

I want to find an additional programmable interrupt source.  It bites that cheap 
PCs have this, and the powerpc doesn't.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

