Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262867AbUCPFyL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 00:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbUCPFyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 00:54:10 -0500
Received: from alt.aurema.com ([203.217.18.57]:19359 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262867AbUCPFxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 00:53:39 -0500
Message-ID: <40569655.2030802@aurema.com>
Date: Tue, 16 Mar 2004 16:53:25 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: finding out the value of HZ from userspace
References: <1zkOe-Uc-17@gated-at.bofh.it> <1zl7M-1eJ-43@gated-at.bofh.it>	<1zn9p-3mW-5@gated-at.bofh.it> <1znj5-3wM-15@gated-at.bofh.it>	<1AaWr-655-7@gated-at.bofh.it> <m3fzc9o7bc.fsf@averell.firstfloor.org>
In-Reply-To: <m3fzc9o7bc.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Peter Williams <peterw@aurema.com> writes:
> 
> 
>>This horrible hack of converting all tick values to 100 (from 1000)
>>for export to user space because a large number of user space programs
>>assume that HZ is 100 would NOT be necessary if there was a mechanism
>>whereby user space programs could find out how many ticks there are in
>>a second instead of having to make assumptions.
> 
> 
> Already exists for a long time - AT_CLKTCK. glibc has a nice wrapper
> for it too (sysconf)

So it does and POSIX.1 (_SC_CLK_TCK) compliant as well.  Unfortunately, 
the presence of this functionality makes it VERY difficult to understand 
why ticks are being converted from HZ==1000 values to HZ=100 values when 
they are being exported to user space especially as this conversion 
throws away precision.  Can anyone enlighten me?

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com


