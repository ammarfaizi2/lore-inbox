Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261430AbREOUM6>; Tue, 15 May 2001 16:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261431AbREOUMs>; Tue, 15 May 2001 16:12:48 -0400
Received: from csa.iisc.ernet.in ([144.16.67.8]:52236 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S261430AbREOUMj>;
	Tue, 15 May 2001 16:12:39 -0400
Date: Wed, 16 May 2001 01:42:21 +0530 (IST)
From: Sourav Sen <sourav@csa.iisc.ernet.in>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: strange behaviour in syscall
In-Reply-To: <Pine.SOL.3.96.1010515230910.8808A-100000@kohinoor.csa.iisc.ernet.in>
Message-ID: <Pine.SOL.3.96.1010516013832.9799B-100000@kohinoor.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Hello,
> 	I know that this is a newbies question, but I didn't get any
> answer in the newbies list, so I am posting it here. 
> 
> 	In 2.2.14, I have implemented a set of system calls(This is just
> academic). The numbers are from 191 - 196. (The virgin source tree has
> up to 190 in entry.S). I have given a printk in the system call proper in
> the last one(196),(and at many other places in the call chain from there).
> (Is it fair to use those syacall numbers ?)
> 
> 	But when I boot up that kernel that printk gets executed. While 
> booting, at least to my knowledge, that part of the code is not supposed
> to get executed. Also while the kernel goes down, that printk speaks
> again. 


	To clarify a bit, lately I have replaced the 196 th. call by 191,
	and removed the earlier 191 st. call, now the message is not appearing.
	My guess is some interrupt is getting vectored in 196 th entry 
	point, but I am totally in dark as to why such a thing might at
	all happen.

Thanks
sourav

> 
> 	All other system calls are working fine.
> 
> 	I am getting some oops and panic while that syscall executes, so I
> am suspicious that I am doing something that I should never have done.
> 
> 	Do anybody has any idea what might be going wrong?
> 
> Sorry to you all for disturbing,
> 
> --
> sourav 
> 
> 

