Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263473AbTC2VhE>; Sat, 29 Mar 2003 16:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263474AbTC2VhE>; Sat, 29 Mar 2003 16:37:04 -0500
Received: from vena.lwn.net ([206.168.112.25]:59276 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S263473AbTC2VhD>;
	Sat, 29 Mar 2003 16:37:03 -0500
Message-ID: <20030329214822.27254.qmail@eklektix.com>
To: J S <webnews@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tasklets vs. Task Queues for Deferred Processing 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Fri, 28 Mar 2003 18:14:37 EST."
             <1048893277.4058.11.camel@localhost.localdomain> 
Date: Sat, 29 Mar 2003 14:48:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have read in the O'Reilly linux device drivers
> book that tasklets always run in interrupt time.  Also, I guess the only
> task_queue that is in process context is the scheduler task queue.  I've
> seen in a few places that task queues are on their way out and tasklets
> are being used instead.  Is this completely true?

All true.  If you're developing for 2.4, you can use schedule_task() and
life will be OK.  For 2.5, you really want to use work queues instead; see
http://lwn.net/Articles/23634/ for a description of how to do that.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
