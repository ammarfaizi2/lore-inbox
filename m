Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUD1VNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUD1VNW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUD1VNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 17:13:15 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:19080 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261248AbUD1VMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 17:12:03 -0400
Message-ID: <40901E1A.9020904@nortelnetworks.com>
Date: Wed, 28 Apr 2004 17:11:54 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Christoph Pohl <christoph.pohl@inf.tu-dresden.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Low bogomips on IBM x445 (kernel 2.6.5)
References: <408E3D74.2090301@inf.tu-dresden.de> <1083184612.9664.15.camel@cog.beaverton.ibm.com>
In-Reply-To: <1083184612.9664.15.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:

> This is expected. Since the IBM x440/x445 are NUMA systems, we cannot
> use the TSC (cpu cycle counter) as a time source. Instead we use an off
> chip performance counter which runs at 100Mhz. This then translates to a
> bogoMIPS value of ~200. 

That sounds very strange.  Bogomips is supposed to be how many busy-wait loops the cpu can do in a 
second, or at least that's what I've seen in all the books.  It shouldn't matter what the time 
source is.

I would expect a NUMA machine to have different bogomips values for the different CPUs, but the 
values should still be the same as if that cpu was on a uniprocessor system, no?

Chris
