Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUGIFJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUGIFJr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 01:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbUGIFJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 01:09:47 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:27504 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264260AbUGIFJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 01:09:40 -0400
Message-ID: <40EE288F.20301@yahoo.com.au>
Date: Fri, 09 Jul 2004 15:09:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: "David S. Miller" <davem@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6
References: <20040705023120.34f7772b.akpm@osdl.org> <20040706125438.GS21066@holomorphy.com> <20040706233618.GW21066@holomorphy.com> <20040706170247.5bca760c.davem@redhat.com> <20040707073510.GA27609@elte.hu> <20040707140249.2bfe0a4b.davem@redhat.com> <40EE06B1.1090202@yahoo.com.au> <20040709025151.GV21066@holomorphy.com>
In-Reply-To: <20040709025151.GV21066@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> On Fri, Jul 09, 2004 at 12:45:05PM +1000, Nick Piggin wrote:
> 
>>We could make CLONE_IDLETASK clones not do the wakeup?
>>Ingo? I guess an alternative is to have the arch explicitly
>>make a call to dequeue it.
> 
> 
> This is all just context switching and bootstrap ordering, but I really
> have other vastly more urgent things to do at the moment than cleanups.

If you could help that would be great. You needn't do anything
other than test. The patch sort of enables run cloned thread
last which allows us to remove balance on clone, which is important.
For me.

> Please present a self-contained fixed-up init_idle() cleanup for me to
> testboot. Even the one in -mm is not so, as it depends on later patches
> to even compile.

The patch I just sent (which is on top of -mm6) should hopefully
work... if you feel like testing a solution that may still get
vetoed by Ingo.

Also, what compile errors are you getting? i386 seems to compile
kernel/ fine with only the first sched- patch applied.

