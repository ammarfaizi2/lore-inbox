Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264671AbSJTXoA>; Sun, 20 Oct 2002 19:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264674AbSJTXoA>; Sun, 20 Oct 2002 19:44:00 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:19671 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264671AbSJTXn7>; Sun, 20 Oct 2002 19:43:59 -0400
Date: Sun, 20 Oct 2002 04:45:56 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Hanna Linder <hannal@us.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] use correct wakeups in fs/pipe.c
Message-ID: <33170000.1035114356@w-hlinder>
In-Reply-To: <Pine.LNX.4.44.0210201646160.989-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0210201646160.989-100000@blue1.dev.mcafeelabs.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Sunday, October 20, 2002 16:49:24 -0700 Davide Libenzi <davidel@xmailserver.org> wrote:

> On Sun, 20 Oct 2002, Hanna Linder wrote:
> 
>> --On Saturday, October 19, 2002 20:12:42 +0200 Manfred Spraul <manfred@colorfullife.com> wrote:
>> 
>> > wake_up_interruptible() and _sync() calls are reversed in pipe_read().
>> > 
>> > The attached patches only calls _sync if a schedule() call follows.
>> > 
>> 
>> FYI. This patch fixes a hang on pipetest.c with the --epoll option.
> 
> Hanna, I'm not sure if your port of the epoll pipe code on 2.5.44 is
> correct. That fix shouldn't affect epoll. Try the code I sent you
> yesterday or today, it working fine on my machine without the fix.

You are right. I had changed pipetest.c in all my debugging earlier
and used the original version of pipetest.c with your new patch and
Manfreds, which worked. I will be more carefull in the future.

Thanks.

Hanna


