Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbUC2Gxj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 01:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbUC2Gxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 01:53:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:26598 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262712AbUC2Gxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 01:53:38 -0500
Date: Sun, 28 Mar 2004 22:53:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.5-rc2 __WAITQUEUE_INITIALIZER
Message-Id: <20040328225322.05ac9f7b.akpm@osdl.org>
In-Reply-To: <5648.1080539353@kao2.melbourne.sgi.com>
References: <5648.1080539353@kao2.melbourne.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> wrote:
>
> When struct __wait_queue is on stack or you reuse an existing
> waitqueue, you get garbage in the flags.
> 
> Index: 5-rc2.1/include/linux/wait.h
> --- 5-rc2.1/include/linux/wait.h Thu, 18 Dec 2003 16:46:13 +1100 kaos (linux-2.6/m/c/34_wait.h 1.1 644)
> +++ 5-rc2.1(w)/include/linux/wait.h Mon, 29 Mar 2004 15:36:39 +1000 kaos (linux-2.6/m/c/34_wait.h 1.1 644)
> @@ -40,6 +40,7 @@ typedef struct __wait_queue_head wait_qu
>   */
>  
>  #define __WAITQUEUE_INITIALIZER(name, tsk) {				\
> +	.flags		= 0,						\
>  	.task		= tsk,						\
>  	.func		= default_wake_function,			\
>  	.task_list	= { NULL, NULL } }

The compiler will do this for us?
