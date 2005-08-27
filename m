Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbVH0Hy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbVH0Hy0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 03:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbVH0Hy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 03:54:26 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:10258 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030340AbVH0HyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 03:54:25 -0400
Date: Sat, 27 Aug 2005 09:53:28 +0200
From: Willy Tarreau <willy@w.ods.org>
To: raja <vnagaraju@effigent.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pid
Message-ID: <20050827075328.GD10110@alpha.home.local>
References: <43101357.7060103@effigent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43101357.7060103@effigent.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2005 at 12:46:39PM +0530, raja wrote:
> Hi,
>    I am trying to find the pid of the process with out using the 
> getpid() using the following program.

Hmmm, I think you're trying to burn all the steps to programming...
First, your program needs some includes, otherwise it will never
know what struct thread_info and task_struct are made of.
Second, those are kernel structures and functions. There's no where you
can call them from userland.

You should really start from the ground with easier programs to
familiarize with C first.

Regards,
Willy

> 
> int main()
> {
>    struct thread_info * threadInfo = current_thread_info();
>    struct task_struct *taskInfo = threadInfo->task;
>    printf("Pid Is %d\n",taskInfo->pid);
> }
> 
> 
> And when i try to compile using
> gcc  -Wall  pid.c
> 
> Then I am getting so many errors like
> 
> 
> pid.c:9: warning: implicit declaration of function `current_thread_info'
> pid.c:9: warning: initialization makes pointer from integer without a cast
> pid.c:10: error: dereferencing pointer to incomplete type
> pid.c:11: error: dereferencing pointer to incomplete type
> 
> 
> 
> Will you please help me.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
