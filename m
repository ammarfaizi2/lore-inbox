Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269814AbUJVHCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269814AbUJVHCp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 03:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269640AbUJVHBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 03:01:54 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:25216 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269814AbUJVGzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 02:55:03 -0400
Message-ID: <4178AEC0.5050603@yahoo.com.au>
Date: Fri, 22 Oct 2004 16:54:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Zaitsev <peter@mysql.com>
CC: linux-kernel@vger.kernel.org, andrea@novell.com, alexeyk@mysql.com,
       markw@osdl.org
Subject: Re: IO performance problems with 2.6.9
References: <1098426220.5482.235.camel@sphere.site>
In-Reply-To: <1098426220.5482.235.camel@sphere.site>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitsev wrote:

> 4) Unrelated but still unfortunate.  2.6.9 kernel seems to behave weird
> if swap is disabled.  I was running with 8G of memory allocating 6G for
> MySQL buffers  which left about 1.5G for kernel, 1G of which was used
> for file cache.   During IO intensive run, using buffered IO I got
> "kswapd" running like a crazy taking 90% of CPU time on one of CPUs. 
> What for is it running if there is no swap files enabled ? 
> 

Can you boot with profile=2, and get a profile of about 30 seconds
while kswapd is going crazy please?

Also capture /proc/vmstat before and after that interaval.

Can you also capture a the output of vmstat 1 while this is happening

Thanks
