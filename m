Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270031AbRIGAq0>; Thu, 6 Sep 2001 20:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270101AbRIGAqP>; Thu, 6 Sep 2001 20:46:15 -0400
Received: from smtp-server2.tampabay.rr.com ([65.32.1.39]:56300 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S270031AbRIGApz>; Thu, 6 Sep 2001 20:45:55 -0400
Message-Id: <200109070046.f870kEM06465@smtp-server2.tampabay.rr.com>
Content-Type: text/plain; charset=US-ASCII
From: Phillip Susi <psusi@cfl.rr.com>
Reply-To: psusi@cfl.rr.com
To: Robert Love <rml@tech9.net>
Subject: Re: [PATCH] (Updated) Preemptible Kernel
Date: Thu, 6 Sep 2001 20:39:25 +0000
X-Mailer: KMail [version 1.3]
In-Reply-To: <999813729.2039.9.camel@phantasy>
In-Reply-To: <999813729.2039.9.camel@phantasy>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This sounds interesting, but am I correct in assuming that this only allows 
preemption during code that is called from user space?  For instance, it 
would be bad to preempt an ISR or BH, right?  Actually... what happens if 
say, the kernel called from user space is holding a lock, and gets preempted? 
 Is there a mechanism to disable preemption while holding locks or at other 
resources that need to be freed before another task is run?

By the way, are there any other 'modes of execution' for lack of a better 
word, besides IRS, B, and.... 'called from user space', also for lack of a 
better word.  Forgive me, I'm not that familiar with the Linux kernel yet.  

On Thursday 06 September 2001 10:02 pm, Robert Love wrote:
> Available at (about 29K):
>
> http://tech9.net/rml/linux/patch-rml-2.4.10-pre4-preempt-kernel-1
> http://tech9.net/rml/linux/patch-rml-2.4.9-ac9-preempt-kernel-1
>
> for kernel 2.4.10-pre4 and 2.4.9-ac9, respectively.
>
> Changes since previous post:
> * update for new kernels
> * fix newline/space format buglet
>
> Changes since original patch:
> * fix compile bug -- CONFIG_HAVE_DEC_LOCK is set as needed, now.
>
> This patch allows a new config setting, CONFIG_PREEMPT (set in
> `Processor Type and Features') that enables a fully preemptible kernel.
> Preemption is controled via SMP lock points.  Control of execution is
> yielded to higher processes even if the currently running process is in
> kernel space.
>
> This should increase response and decrease latency, and is a highly
> recommended patch for real-time, audio, and embedded systems.  However,
> it is recommended for anyone.  I use it on my everyday workstation.
>
> An interesting new article on a preemptible kernel in linux is available
> at:
>
> http://www.linuxdevices.com/articles/AT5152980814.html

-- 
--> Phill Susi
