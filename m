Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263815AbUG2KxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUG2KxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 06:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUG2KxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 06:53:15 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:41150 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263815AbUG2KxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 06:53:14 -0400
Message-ID: <4108D349.1030209@yahoo.com.au>
Date: Thu, 29 Jul 2004 20:36:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: haveblue@us.ibm.com, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@sgi.com>
Subject: Re: Oops in find_busiest_group(): 2.6.8-rc1-mm1
References: <1089871489.10000.388.camel@nighthawk>	<20040728234255.29ef4c13.pj@sgi.com>	<4108B66D.1050000@yahoo.com.au> <20040729022912.04a0806d.pj@sgi.com>
In-Reply-To: <20040729022912.04a0806d.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nick writes:
> 
>> Can you try with 2.6.8-rc2-mm1?
> 
> 
> This _is_ with 2.6.8-rc2-mm1.
> 
> 
>>Does it happen continually after the system has booted?
> 
> 
> Yes - nonstop - 4 times per millisecond, for at least as
> long as the machine has been up (I'm rebooting every few
> minutes, for other reasons ...).
> 
> 
>>comment out the call to cpu_attach_domain ... Does that fix it?
> 
> 
> Yes - that fixes it.  My ratelimited printks on NULL group cease.
> 

Hmm, nothing else seems to be oopsing. Maybe it is the ia64
domain setup code that Jesse did? The domains/groups must
not have been built properly somewhere.
