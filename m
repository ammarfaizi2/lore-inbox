Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264544AbTIDDms (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbTIDDms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:42:48 -0400
Received: from anumail3.anu.edu.au ([150.203.2.43]:59020 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S264544AbTIDDmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:42:46 -0400
Message-ID: <3F56B3CC.1010300@cyberone.com.au>
Date: Thu, 04 Sep 2003 13:38:52 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
References: <20030903180547.GD5769@work.bitmover.com> <20030903181550.GR4306@holomorphy.com> <1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk> <20030903194658.GC1715@holomorphy.com> <105370000.1062622139@flay> <20030903212119.GX4306@holomorphy.com> <115070000.1062624541@flay> <20030903215135.GY4306@holomorphy.com> <20030904005822.GC5227@work.bitmover.com> <20030904011253.GA4306@holomorphy.com> <20030904024904.GI5227@work.bitmover.com>
In-Reply-To: <20030904024904.GI5227@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-7.4)
X-Spam-Tests: BAYES_01,EMAIL_ATTRIBUTION,IN_REP_TO,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MOZILLA_UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

>On Wed, Sep 03, 2003 at 06:12:53PM -0700, William Lee Irwin III wrote:
>
>>On Wed, Sep 03, 2003 at 02:51:35PM -0700, William Lee Irwin III wrote:
>>
>>>>This is only truly feasible when the nodes are homogeneous. They will
>>>>not be as there will be physical locality (esp. bits like device
>>>>proximity) concerns. 
>>>>
>>On Wed, Sep 03, 2003 at 05:58:22PM -0700, Larry McVoy wrote:
>>
>>>Huh?  The nodes are homogeneous.  Devices are either local or proxied.
>>>
>>Virtualized devices are backed by real devices at some level, so the
>>distance from the node's physical location to the device's then matters.
>>
>
>Go read what I've written about this.  There is no sharing, devices are 
>local or remote.  You share in the page cache only, if you want fast access
>to a device you ask it to put the data in memory and you map it.  It's 
>absolutely as fast as an SMP.  With no locking.
>

There is probably more to it - I'm just an interested bystander - but
how much locking does this case incur with a single kernel system?
And what happens if more than one node wants to access the device? Through
a filesystem?


