Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTIJCbb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 22:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbTIJCbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 22:31:31 -0400
Received: from dyn-ctb-203-221-72-196.webone.com.au ([203.221.72.196]:51209
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S264178AbTIJCb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 22:31:29 -0400
Message-ID: <3F5E8CF7.5020603@cyberone.com.au>
Date: Wed, 10 Sep 2003 12:31:19 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: John Yau <jyau_kernel_dev@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 
References: <Law10-OE471DczmBlrP0000b07a@hotmail.com>
In-Reply-To: <Law10-OE471DczmBlrP0000b07a@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Yau wrote:

>>Your mechanism is basically "backboost". Its how you get X to keep a
>>high piroirity, but quite unpredictable. Giving a boost to a process
>>holding a semaphore is an interesting idea, but it doesn't address the
>>X problem.
>>
>
>Hmm...I'm actually curious why you called it "backboosting".  In academia
>this approach first described in the paper here:
>
>L. Sha, R. Rajkumar, and J. P. Lehoczky. Priority Inheritance Protocols: An
>Approach to Real-Time Synchronization. In IEEE Transactions on Computers,
>vol. 39, pp. 1175-1185, Sep. 1990.
>
>is referred to as priority inheritance.  Is there significant difference
>between your implementation and priority inheritance schemes implemented in
>other OSes?  If so, why backboosting?
>

Well I haven't read the paper, but I'm guessing this is semaphore
priority inheritance.

>
>I was under the impression that pipes and IPC in general are synchronized
>using some sort of semaphores/mutex...or does Linux use a different
>mechanism for IPC and does away with user space synchronization all together
>(e.g. flip-flop buffers with the kernel arbitrating all contention)?  IIRC
>processes don't write to X directly and has to send data to X via IPC.  If
>some futex derivative is used to synchronize the producers with X, then
>making priority inheritable futexes would solve the problem.
>

I _think_ communication with X will mostly be done with waitqueues.
Someone has a priority inheritance futex patch around. I'm not sure
that it is such an open and shut case as you think though. Even if you
could use futexes in communication with X.

>
>>The scheduler in Linus' tree is basically obsolete now, so there isn't
>>any point testing it really. Test Con's or my patches, and let us know
>>if you're still having problems with sir dumps-a-lot.
>>
>
>Okay enough said, you and Con should get your patches merged into that tree
>ASAP if they're ready.
>
>

I think Con's is ready (I think mine is as well, but nobody else does!)


