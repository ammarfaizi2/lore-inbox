Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbSCOInA>; Fri, 15 Mar 2002 03:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285720AbSCOImu>; Fri, 15 Mar 2002 03:42:50 -0500
Received: from mail.epost.de ([64.39.38.76]:45532 "EHLO mail.epost.de")
	by vger.kernel.org with ESMTP id <S285692AbSCOImh>;
	Fri, 15 Mar 2002 03:42:37 -0500
Message-ID: <3C91B3A1.7030709@dlr.de>
Date: Fri, 15 Mar 2002 09:41:05 +0100
From: Martin Wirth <martin.wirth@dlr.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: de-DE
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <E16lmBj-0003v4-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rusty Russell wrote:

>
>Discussions with Ulrich have reaffirmed my opinion that pthreads are
>crap.  Hence I'm not all that tempted to warp the (nice, clean,
>usable) futex code too far to meet pthreads' wierd needs.
>
Crap or not, there are tons of software based on pthreads and at least 
the NGPT team says that Linus
agreed to implement for necessary kernel-infrastructure for a full, fast 
pthread implementation.

Now, if you want to implement mutexes and condition variables with the attribute
PTHREAD_PROCESS_SHARED then you need some functionality like the futexes.
Or NGPT will add his own syscalls to handle these things, which is simply
unnecessary double functionality.

>
>However, it's not too hard to implement condition variables using an
>unavailable mutex, if we go for "full" semaphores: ie. not just
>mutexes.  It requires a bit more of a stretch for kernel atomic ops...
>
A full semaphore is nice, but not a full replacement for a waitqueue (or 
a pthread condition variable brr..).
For the semaphore you always have to assure that the ups and downs are 
balanced, what is not the case
for the condition variable.

Martin


