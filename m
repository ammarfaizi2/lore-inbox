Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131293AbQKIVGR>; Thu, 9 Nov 2000 16:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbQKIVGH>; Thu, 9 Nov 2000 16:06:07 -0500
Received: from ns.caldera.de ([212.34.180.1]:17924 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131360AbQKIVF6>;
	Thu, 9 Nov 2000 16:05:58 -0500
Date: Thu, 9 Nov 2000 22:05:43 +0100
Message-Id: <200011092105.WAA06502@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: root@chaos.analogic.com ("Richard B. Johnson")
Cc: Brian Gerst <bgerst@didntduck.org>,
        Linux kernel <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Module open() problems, Linux 2.4.0
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.3.95.1001109154744.16836A-100000@chaos.analogic.com>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.3.95.1001109154744.16836A-100000@chaos.analogic.com> you wrote:
> On Thu, 9 Nov 2000, Jeff Garzik wrote:
>> There is NO guarantee that module use count == device open count.  Never
>> has been, AFAIK.  It just happens to work out that way on a lot of
>> pre-2.4 code.
>> 
>> The kernel is free to bump the module reference count up and down as it
>> pleases.  For example, if a driver creates a kernel thread, that will
>> increase its module usage count by one, for the duration of the kernel
>> thread's lifetime.
>> 
>> The only rule is that you cannot unload a module until its use count it
>> zero.  
>> 
>> 	Jeff
>> 

> I suppose. Look at what you just stated! This means that a reported
> value is now worthless.

Correct.  And it was always worthless.

> To restate, somebody decided that we didn't need this reported value
> anymore. Therefore, it is okay to make it worthless.

It was always wothless besides == 0 means: you can unload me now.

> I don't agree. The De-facto standard has been that the module usage
> count is equal to the open count. This became the standard because
> of a long established history.

It's the same de-facto standard as bogo-mips ~= CPU MHz.  It was so,
but it was neither intended nor documented so.

> This is one of the tools we use to verify that an entire system
> is functioning properly.

It was the wrong tool.

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
