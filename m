Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVKODxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVKODxB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 22:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVKODxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 22:53:01 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:23168 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S932065AbVKODxB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 22:53:01 -0500
Message-ID: <43795575.9010904@wolfmountaingroup.com>
Date: Mon, 14 Nov 2005 20:26:45 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <58MJb-2Sn-37@gated-at.bofh.it> <58NvO-46M-23@gated-at.bofh.it> <58Rpx-1m6-11@gated-at.bofh.it> <58UGF-6qR-27@gated-at.bofh.it> <58UQf-6Da-3@gated-at.bofh.it> <437933B6.1000503@shaw.ca> <1132020468.27215.25.camel@mindpipe> <20051115032819.GA5620@redhat.com>
In-Reply-To: <20051115032819.GA5620@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Mon, Nov 14, 2005 at 09:07:48PM -0500, Lee Revell wrote:
> > On Mon, 2005-11-14 at 19:02 -0600, Robert Hancock wrote:
> > > Giridhar Pemmasani wrote:
> > > > Shouldn't I have to prevent scheduler from changing the tasks when executing
> > > > Windows code? Otherwise, kernel gets wrong current thread information,
> > > > which is based on stack pointer. This is the stumbling block for implementing
> > > > private stacks.
> > > 
> > > As long as preemption is disabled when the driver code is executing
> > 
> > Um, but it's really really bad for drivers to do that.
>
>And loading Windows drivers into the kernel isn't ?
>I think we're already in no-mans land here.
>
>Remember, we have no clue what those drivers are even doing.
>Preemption is the least of its problems.
>
>		Dave
>
>
>  
>

NetWare used 16K stacks in kernel by default. 4K is not enough room. I 
have to dance around a lot of issues with 4K stacks. I haven't followed
who came up with the idea to limit stacks to 4K, but they should have 
the option of 4-16K. NeWare 5.0 started using 32 Stacks for
all the compression support and FS crap, but 16K was a good number.

Why does the kernel need to be limited to 4K? for kernel preemption?

Someone needs to fix this. It's busted. It makes porting code between 
Windows and Linux and other OS's difficult to support.

Jeff


