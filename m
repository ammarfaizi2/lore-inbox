Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbTEHATL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 20:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264185AbTEHATL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 20:19:11 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:41351 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S264154AbTEHATK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 20:19:10 -0400
From: Rusty Russell <rusty@au1.ibm.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: akpm@zip.com.au, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu 
In-reply-to: Your message of "Wed, 07 May 2003 11:21:03 +0530."
             <20030507055103.GA31797@in.ibm.com> 
Date: Wed, 07 May 2003 16:16:06 +1000
Message-Id: <20030508003139.432A617DE0@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030507055103.GA31797@in.ibm.com> you write:
> I tried to run a test to compare this implementation, but got an oops.
> Here is the oops and the patch I was trying...  

> +	if (!init_committed_space)

init_committed_space is a function.  You meant to call it 8)

> btw, why the change from kmalloc_percpu(size) to kmalloc_percpu(type)?
> You do kmalloc(sizeof (long)) for the usual kmalloc, but 
> kmalloc_percpu(long) for percpu data...looks strange no?

Yes, I'd probably want to change the name, if Andrew had agreed to the
concept.  But the type is very convenient, because you want to know
the alignment (kmalloc doesn't care, it just pads to cachline).

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
