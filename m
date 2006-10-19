Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946370AbWJSTEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946370AbWJSTEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946384AbWJSTEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:04:09 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:62834 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1946370AbWJSTEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:04:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=5bFBLBOfXAP66yfV5hzmXmDY0w0JNodmDQqibCLH3NoQFTjSMbuWINEPyYSRisBqq03quUPqYfQNmXSpW4X3NOn8wl6CayXGgCuCdSwOM7hio6JgWZxb5MJGTatTcoX3ztdR7ltelynRsAKkIbRHPw9T6cQq6Z7ePPeFqEGYPiI=  ;
Message-ID: <4537CC1E.60204@yahoo.com.au>
Date: Fri, 20 Oct 2006 05:03:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: akpm@osdl.org, mbligh@google.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, dino@in.ibm.com, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>	<453750AA.1050803@yahoo.com.au>	<20061019105515.080675fb.pj@sgi.com>	<4537BEDA.8030005@yahoo.com.au> <20061019115652.562054ca.pj@sgi.com>
In-Reply-To: <20061019115652.562054ca.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
>>>So ... where should it be done?
>>
>>sched.c I suppose.
> 
> 
> Are we discussing where the implementing code should go,
> or where the isolated cpu map special file should be
> exposed to user space?

Both?

> And you didn't answer my other questions, such as:
>  1) If your other patch to manipulate sched domains
>     has code that belongs in kernel/cpuset.c, and
>     special files that belong in /dev/cpuset, why
>     shouldn't this one naturally go in the same places?

Because they are cpuset specific. This is not.

>  2) Why ... why?  What would be better about sched.c
>     and what's wrong with where it is (the code and
>     the exposed file)?

Because it is not specific to CONFIG_CPUSETS. People who
don't configure CONFIG_CPUSETS may still want to change
isolcpus at runtime.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
