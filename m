Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265769AbUAEGlU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 01:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbUAEGlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 01:41:20 -0500
Received: from dp.samba.org ([66.70.73.150]:39614 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265769AbUAEGlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 01:41:19 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: mingo@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-reply-to: Your message of "Sun, 04 Jan 2004 21:06:06 -0800."
             <Pine.LNX.4.44.0401042100510.15831-100000@bigblue.dev.mdolabs.com> 
Date: Mon, 05 Jan 2004 17:38:47 +1100
Message-Id: <20040105064117.0C20C2C065@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0401042100510.15831-100000@bigblue.dev.mdolabs.com> you write:
> Honestly I do not like playing with SIGCLD/waitpid for things that do not 
> concern real task exits. 

Well, it's pretty well documented.

> But I think it can be avoided, and actually I 
> don't know why I did not think about this before. We don't need to return 
> a struct task_struct* for kthread_create(). We can have:
> 
> struct kthread_struct {

Nope.  That's EXACTLY the kind of burden on the caller I wanted to
avoid if at all possible.

I just have decide whether to submit the wait one or the shared queue
one to Andrew....

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
