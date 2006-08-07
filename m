Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWHGOFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWHGOFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 10:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWHGOFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 10:05:18 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:52926 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932072AbWHGOFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 10:05:16 -0400
Message-ID: <44D74895.2090600@in.ibm.com>
Date: Mon, 07 Aug 2006 19:35:09 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2
References: <20060806030809.2cfb0b1e.akpm@osdl.org>	 <6bffcb0e0608060409m2cd8fb4er6d7d2300915604c4@mail.gmail.com>	 <44D70D79.1010106@in.ibm.com> <6bffcb0e0608070516o6f750db8h31ffbfe63db9f8c9@mail.gmail.com>
In-Reply-To: <6bffcb0e0608070516o6f750db8h31ffbfe63db9f8c9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski wrote:
> Hi,
> 
> On 07/08/06, Balbir Singh <balbir@in.ibm.com> wrote:
>> Michal Piotrowski wrote:
>> > Hi,
>> >
>> > On 06/08/06, Andrew Morton <akpm@osdl.org> wrote:
>> >>
>> >> 
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/ 
>>
>> >>
>> >>
>> >
>> > I get this error during the build.
>> >
>> > kernel/built-in.o: In function `bacct_add_tsk':
>> > /usr/src/linux-mm/kernel/tsacct.c:39: undefined reference to `__divdi3'
>> > make[1]: *** [.tmp_vmlinux1] Error 1
>> > make: *** [_all] Error 2
>> >
>> > I'll try with CONFIG_TASKSTATS disabled.
>> >
>> > Regards,
>> > Michal
>> >
>>
>> Sounds likes we are trying to do a 64 bit division since timespec_to_ns()
>> returns a 64 bit value.
>>
>> Here's a compile tested patch to fix the problem
>>
> 
> It doesn't apply
> cat patches/tsacct1.patch | patch -p1 --dry-run
> patching file kernel/tsacct.c
> Hunk #1 FAILED at 36.
> 1 out of 1 hunk FAILED -- saving rejects to file kernel/tsacct.c.rej
> 
> Andrew's csa-basic-accounting-over-taskstats-fix.patch fix compilation 
> problem.
> 

Yeah, thats it! I did not see the fix in mm-commits.

Thanks for pointing to the fix.

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
