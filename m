Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUDKPYR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 11:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUDKPYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 11:24:17 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:8803 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262361AbUDKPYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 11:24:16 -0400
Message-ID: <40796318.4010508@yahoo.com.au>
Date: Mon, 12 Apr 2004 01:24:08 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: scheduler problems on shutdown
References: <1516092704.1081534916@[10.10.2.4]> <71390000.1081611090@[10.10.2.4]> <40791475.7040300@cyberone.com.au> <1860000.1081696302@[10.10.2.4]>
In-Reply-To: <1860000.1081696302@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>I think the WARN_ON can go. You have to make sure the for_each_cpu
>>loop doesn't get to run it though. It shouldn't be in the latest -mm
>>kernels, is it?
> 
> 
> OK, I'll figure it out. I don't like the latest code, so don't really want
> to "upgrade" though.
>  

Oh? Anything specific?

> 
>>It is normal to have an entire group offline with CPU hotplug.
> 
> 
> Only if we can't figure out how to hotplug groups as well, which would
> be a much cleaner way of doing it.
> 

I think we'll soon want to add a sched domain setup callback
for hotplug that can take care of these things as required.
But for now, the current situation should be OK.
