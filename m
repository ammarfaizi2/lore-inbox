Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVECRWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVECRWq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 13:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVECRWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 13:22:46 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:25521 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261436AbVECRWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 13:22:41 -0400
Message-ID: <4277B34C.4000403@nortel.com>
Date: Tue, 03 May 2005 11:22:20 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
CC: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       albert@users.sourceforge.net, paulus@samba.org, schwidefsky@de.ibm.com,
       mahuja@us.ibm.com, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
Subject: Re: [RFC][PATCH] new timeofday-based soft-timer subsystem
References: <1114814747.28231.2.camel@cog.beaverton.ibm.com> <20050429233546.GB2664@us.ibm.com> <20050503170224.GA2776@us.ibm.com>
In-Reply-To: <20050503170224.GA2776@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan wrote:

> but then there is another issue: the restart_block used by
> sys_nanosleep() only allows for 4 unsigned long arguments, when, in
> fact, nanoseconds are a 64-bit quantity in the kernel. As long as the
> nanosleep() request is no more than around 4 seconds, we should be ok
> using unsigned longs.

My man page for nanosleep specifies that the "nanoseconds" portion of 
the timespec must be under 1 billion and is of type "long".  Is that no 
longer valid?

Chris
