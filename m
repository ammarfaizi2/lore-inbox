Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263398AbTC2IBo>; Sat, 29 Mar 2003 03:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263399AbTC2IBo>; Sat, 29 Mar 2003 03:01:44 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.26]:3987 "EHLO
	mwinf0503.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263398AbTC2IBn>; Sat, 29 Mar 2003 03:01:43 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: J S <webnews@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Tasklets vs. Task Queues for Deferred Processing
Date: Sat, 29 Mar 2003 09:12:53 +0100
User-Agent: KMail/1.5.1
References: <1048893277.4058.11.camel@localhost.localdomain>
In-Reply-To: <1048893277.4058.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303290912.54062.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 March 2003 00:14, J S wrote:
> I'm trying to defer some processing to a later point.  I'm in a softirq,
> so in_interrupt() returns true.  I need to schedule some work for later,
> in process context.  I have read in the O'Reilly linux device drivers
> book that tasklets always run in interrupt time.  Also, I guess the only
> task_queue that is in process context is the scheduler task queue.  I've
> seen in a few places that task queues are on their way out and tasklets
> are being used instead.  Is this completely true?  Should I consider
> task queues as a deprecated method of deferred processing?`  What other
> deferred processing methods can I use that will run in process context?

In 2.5, use a workqueue.

Duncan.
