Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbUEJWWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUEJWWY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbUEJWWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:22:23 -0400
Received: from web14922.mail.yahoo.com ([216.136.225.6]:13926 "HELO
	web14922.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261984AbUEJWWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:22:13 -0400
Message-ID: <20040510222211.78262.qmail@web14922.mail.yahoo.com>
Date: Mon, 10 May 2004 15:22:11 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Is it possible to implement interrupt time printk's reliably?
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       keithp@keithp.com
In-Reply-To: <Pine.LNX.4.44.0405102253330.8016-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So how long is the delay between PCI probe time (when the framebuffer goes
active) and when early user space is up with initrd? Or is initrd up first? If
initrd is up first then early user space mode setting will occur at the same
time that it does currently.

--- James Simmons <jsimmons@infradead.org> wrote:
> 
> > So how do printk's work in the very early boot? Is the video card active
> before
> > the kernel probes it's module, or are these very early printk's being queued
> > until the video driver is probed?
> 
> printk messages are stored in log_buf in printk.c. The console driver just 
> reads the buffer and displays what is in the buffer. Look at printk.c 
> carefully.
> 
>  
> 


=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 
