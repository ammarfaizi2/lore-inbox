Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263397AbTC2IBj>; Sat, 29 Mar 2003 03:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263398AbTC2IBj>; Sat, 29 Mar 2003 03:01:39 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:60036 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263397AbTC2IBi>; Sat, 29 Mar 2003 03:01:38 -0500
Date: Sat, 29 Mar 2003 09:12:51 +0100
From: Juergen Quade <quade@hsnr.de>
To: J S <webnews@comcast.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Tasklets vs. Task Queues for Deferred Processing
Message-ID: <20030329081251.GA6604@hsnr.de>
References: <1048893277.4058.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1048893277.4058.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 28, 2003 at 06:14:37PM -0500, J S wrote:
> I'm trying to defer some processing to a later point.  I'm in a softirq,
> so in_interrupt() returns true.  I need to schedule some work for later,
> in process context.  I have read in the O'Reilly linux device drivers
> book that tasklets always run in interrupt time.  Also, I guess the only
> task_queue that is in process context is the scheduler task queue.  I've
> seen in a few places that task queues are on their way out and tasklets
> are being used instead.  Is this completely true?  Should I consider

True.

> task queues as a deprecated method of deferred processing?`  What other
> deferred processing methods can I use that will run in process context?

Beside application triggered driver functions (open, close, read,
write ...) you can (only) use kernel threads.
You can use "pure" kernel threads, workqueues or especially the
kevent-daemon (2.4.x) or the event-workqueue (2.5.x).

If you only need to call something like a short function, use
the work queue. Need more info?

        Juergen.
