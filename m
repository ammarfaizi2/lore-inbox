Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUCWKq7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbUCWKq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:46:58 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:42453 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262450AbUCWKqo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:46:44 -0500
Date: Tue, 23 Mar 2004 16:15:52 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: tiwai@suse.de, Andrea Arcangeli <andrea@suse.de>,
       Robert Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-ID: <20040323104552.GE3676@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040323101755.GC3676@in.ibm.com> <1080038105.5296.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080038105.5296.8.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 11:35:06AM +0100, Arjan van de Ven wrote:
> 
> > Reduce bh processing time of rcu callbacks by using tunable per-cpu
> > krcud daemeons.
> 
> why not just use work queues ?

No particular reason other than that I wanted to experiment with
the priority of the kernel threads when we test it under heavy load.
If all these are deemed necessary, I will clean it up.

There is one minor irritant - I need to check if the worker thread
for my cpu is running or not. I will have to add something to do
that since this whole thing is conditional and also RCU is initialized
before workqueues.

Thanks
Dipankar

