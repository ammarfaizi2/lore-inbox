Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTEHHgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 03:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbTEHHgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 03:36:38 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:28149 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S261153AbTEHHgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 03:36:38 -0400
From: Rusty Russell <rusty@au1.ibm.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Subject: Re: [PATCH] kmalloc_percpu 
Cc: akpm@zip.com.au, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
In-reply-to: Your message of "Thu, 08 May 2003 13:12:37 +0530."
             <20030508074237.GA2760@in.ibm.com> 
Date: Thu, 08 May 2003 17:47:34 +1000
Message-Id: <20030508074907.276E517DE0@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030508074237.GA2760@in.ibm.com> you write:
> But still, even after actually calling init_committed_space
> with the newer patch (The first one which you mailed to Andrew in this
> thread) I get an oops at __alloc_percpu.
> 
> Here's the oops report...looks like the 
> struct pcpu_block *pcpu has NULL...

Damn initialization order.

Change:
	__initcall(init_alloc_percpu);
to
	core_initcall(init_alloc_percpu);

Anyway, patch has been scrapped, at least for now.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
