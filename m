Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbVH0HtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbVH0HtM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 03:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbVH0HtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 03:49:12 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:19613 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030339AbVH0HtL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 03:49:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DO2JXB2ma2SIvuNJm+6B17Sn3JFFyY0rNzrNMrhLw2YOg1xU6Q7aRmP9kZMvT4j+FqYvR30E0TfY2oVyyq2RjV9mZsaOvBj41Hhdon8bEJQIGsZNXQFrEF7G6hNwd/RLIzN1NZZkjIMawBDt63klcqDVojuByCGHmRTw178KCQ4=
Message-ID: <1e33f57105082700496de6e103@mail.gmail.com>
Date: Sat, 27 Aug 2005 13:19:11 +0530
From: Gaurav Dhiman <gaurav4lkg@gmail.com>
To: raja <vnagaraju@effigent.net>
Subject: Re: pid
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43101357.7060103@effigent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43101357.7060103@effigent.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/05, raja <vnagaraju@effigent.net> wrote:
> Hi,
>     I am trying to find the pid of the process with out using the
> getpid() using the following program.
> 
> int main()
> {
>     struct thread_info * threadInfo = current_thread_info();
>     struct task_struct *taskInfo = threadInfo->task;
>     printf("Pid Is %d\n",taskInfo->pid);
> }

You are writting a user space programme and in that you can not use
the kernel data structures. Usually user programmes communicate wth
kernel through system calls. The thing you are doing is not allowed.
If you are a kernelnewbie, I would recommend you to subscribe to
kernelnewbies mailing list.

regards,
-Gaurav

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
>
