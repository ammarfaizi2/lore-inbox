Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129776AbQKJPkw>; Fri, 10 Nov 2000 10:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131038AbQKJPkm>; Fri, 10 Nov 2000 10:40:42 -0500
Received: from mail.zmailer.org ([194.252.70.162]:63752 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129776AbQKJPkS>;
	Fri, 10 Nov 2000 10:40:18 -0500
Date: Fri, 10 Nov 2000 17:39:57 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "M.Kiran Babu" <kbabu@iitg.ernet.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: threads
Message-ID: <20001110173957.M13151@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.10.10011102031210.31929-100000@kamrup.iitg.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10011102031210.31929-100000@kamrup.iitg.ernet.in>; from kbabu@iitg.ernet.in on Fri, Nov 10, 2000 at 08:33:29PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 08:33:29PM +0530, M.Kiran Babu wrote:
>  sir,
> i got some doubts in kernel
> programming. i am using linux 6.1 version. i want to use threads in

	Linux kernel versions are now running up to 2.4.0*, what is
	that 6.1 ?  Some distribution ?  Which ?
	Which kernel version you are referring into ?

> kernel.is it possible to use pthreads in kernel. there is one more
                               ^^^^^^^^^^^^^^^^^^   NO.
> function kernel_thread.
> can i use that function.

	#include <asm/processor.h>

	extern pid_t kernel_thread(int (*fn)(void *), void * arg,
				   unsigned long flags);

> if i use that function how to get synchonization.

	With mutexes, waitqueues, or spinlocks.
	All kernel facilities.

> inmany files it was used. but everywhere lock_kernel() and unlock_kernel()
> functions are being used. if we use that commands the whole kernel gets
> locked.

	Really ?  Who says you need to   lock_kernel()  for starting
	a kernel thread ?

> is there any other mechanisms. or can i use that methods only.
> if i can use these methods what is the syntax of kernel_thread function.
> the arguments that are passing to these function are 3.
> i dont know what are those three. please tell me.

	Pick 2.4.0 sources, open them up.

	Then do:  "make psdocs" or "make pdfdocs" or "make htmldocs"
	and you get up documents from within the system into your
	source location Documentation/DocBook/  subdirectory.

	You propably want to study  kernel-hacking,  kernel-locking,
	and  kernel-api   documents.

	(Your system needs to have DocBook, related SGML tools, and
	 (for PS/PDF) (La)TeX subsystem.)

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
