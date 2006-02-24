Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWBXAO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWBXAO3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 19:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWBXAO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 19:14:29 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:58043 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932172AbWBXAO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 19:14:28 -0500
Message-ID: <43FE5018.8080604@jp.fujitsu.com>
Date: Fri, 24 Feb 2006 09:15:20 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/7] ppc64 - Specify amount of kernel memory at boot	time
References: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie>	 <20060217141712.7621.49906.sendpatchset@skynet.csn.ul.ie>	 <1140196618.21383.112.camel@localhost.localdomain>	 <Pine.LNX.4.64.0602211445160.4335@skynet.skynet.ie>	 <1140543359.8693.32.camel@localhost.localdomain>	 <Pine.LNX.4.64.0602221625100.2801@skynet.skynet.ie>	 <1140712969.8697.33.camel@localhost.localdomain>	 <Pine.LNX.4.64.0602231646530.24093@skynet.skynet.ie>	 <1140716304.8697.53.camel@localhost.localdomain>	 <Pine.LNX.4.64.0602231740410.24093@skynet.skynet.ie> <1140718555.8697.73.camel@localhost.localdomain>
In-Reply-To: <1140718555.8697.73.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
>> That sort of surprise is totally unacceptable but the behaviour of 
>> kernelcore needs to be consistent on both the x86 and the ppc (any any 
>> other ar. How about;
>>
>> 1. kernelcore=X determines the total amount of memory for !ZONE_EASYRCLM
>>     (be it ZONE_DMA, ZONE_NORMAL or ZONE_HIGHMEM)
> 
> Sounds reasonable.  But, if you're going to do that, should we just make
> it the opposite and explicitly be easy_reclaim_mem=?  Do we want the
> limit to be set as "I need this much kernel memory", or "I want this
> much removable memory".  I dunno.

Now, amount of EASYRCLM memory can change in run time, but kernelcore memory
cannot. So, I like kernelcore= option. I think this is clear setting for admin.

-- Kame

