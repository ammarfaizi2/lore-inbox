Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313430AbSDPAgO>; Mon, 15 Apr 2002 20:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313424AbSDPAgN>; Mon, 15 Apr 2002 20:36:13 -0400
Received: from mail.webmaster.com ([216.152.64.131]:39565 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S313423AbSDPAgI> convert rfc822-to-8bit; Mon, 15 Apr 2002 20:36:08 -0400
From: David Schwartz <davids@webmaster.com>
To: <kpierre@fit.edu>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Mon, 15 Apr 2002 17:36:01 -0700
In-Reply-To: <3CBAF8EC.6070403@fit.edu>
Subject: Re: Memory Leaking. Help!
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020416003603.AAA11784@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Apr 2002 11:59:40 -0400, Kervin Pierre wrote:
>Eugenio Mastroviti wrote:
>>much data as it can in memory. The actual memory in use (check with
>>'free') is total-(buffers+cache)= 2.2-(0.37+1.51)GB=about 320 MB, which
>
>This is interesting.  What exactly is buffers and cache used for?

	It is used to keep information that the kernel might otherwise throw away in 
case it is needed later. It is also used to accumulate writes so that they 
can be made at a time where they can be done more efficiently.

>I had the same issue with the original poster with a new server.  A
>fresh install with nothing significant running ( no bind nor sendmail,
>etc. ) reported that over 450 out of 512 MB was used, but looking at the
>process usage on top I barely got 5% memory usage by process.  If the
>above calculation ( memory use = total - buffers - cache ) is correct
>then the memory use drops to ~100 MB.

	So you now have a ton of information. You have 512Mb of physical RAM, 450 of 
that is being used. 100Mb of that is process memory, 350Mb of that is buffers 
and cache.

>I guess what's confusing is that total memory usuage is including
>buffers and cache.  If that memory is available to applications,
>shouldn't it be removed from the "total used" figure?

	Are you arguing that you shouldn't have all the information the kernel is 
providing you? That some of it should be hidden from you and memory should be 
said to be free when it really isn't?

	All of your physical memory, less what is used by the kernel itself, is 
always available to applications. That memory is being used. Really.

	If you don't want your memory to be used, take it out of your computer. You 
paid good money for it. The kernel is using it. You should be happy.

	DS


