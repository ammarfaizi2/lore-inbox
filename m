Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131766AbQKJVPS>; Fri, 10 Nov 2000 16:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131765AbQKJVPJ>; Fri, 10 Nov 2000 16:15:09 -0500
Received: from k2.llnl.gov ([134.9.1.1]:65244 "EHLO k2.llnl.gov")
	by vger.kernel.org with ESMTP id <S130892AbQKJVO7>;
	Fri, 10 Nov 2000 16:14:59 -0500
Message-ID: <3A0C1CB6.BC7BE4AB@scs.ch>
Date: Fri, 10 Nov 2000 08:05:10 -0800
From: Reto Baettig <baettig@scs.ch>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17ext3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "M.Kiran Babu" <kbabu@iitg.ernet.in>
CC: linux-kernel@vger.kernel.org
Subject: Re: threads
In-Reply-To: <Pine.LNX.4.10.10011102031210.31929-100000@kamrup.iitg.ernet.in>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lock_kernel is a special case and will not block when you call it in
order to create a new kernel thread. Look at the implementation of
lock_kernel if you have any doubts (this is true for the 2.2 kernels. I
don't know it by heart for the 2.4 kernel). 

	Reto

"M.Kiran Babu" wrote:
> 
>  sir,
> i got some doubts in kernel
> programming. i am using linux 6.1 version. i want to use threads in
> kernel.is it possible to use pthreads in kernel. there is one more
> function kernel_thread. can i use
> that function. if i use that function how to get synchonization. inmany
> files it was used. but everywhere lock_kernel() and unlock_kernel()
> functions are being used. if we use that commands the whole kernel gets
> locked. is there any other mechanisms. or can i use that methods only. if
> i can use these methods what is the syntax of kernel_thread function. the
> arguments that are passing to these function are 3. i dont know what are
> those three. please  tell me.
> 
> 
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
