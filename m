Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264675AbUDVVUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264675AbUDVVUt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 17:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264686AbUDVVUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 17:20:49 -0400
Received: from desnol.ru ([217.150.58.74]:7907 "EHLO desnol.ru")
	by vger.kernel.org with ESMTP id S264675AbUDVVUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 17:20:47 -0400
Date: Fri, 23 Apr 2004 01:21:15 +0400
From: Agri <agri@desnol.ru>
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: fork do not copy /proc/<PID>/cmdline permissions
Message-Id: <20040423012115.36fa0fe8@agri-home>
In-Reply-To: <Pine.LNX.4.53.0404221628300.940@chaos>
References: <20040422215322.19475d98@agri-home>
	<Pine.LNX.4.53.0404221628300.940@chaos>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004 16:36:28 -0400 (EDT)
"Richard B. Johnson" <root@chaos.analogic.com> wrote:

> On Thu, 22 Apr 2004, Agri wrote:
> 
> > I expected from fork to make a rather complete copy of a process,
> > but it does not copy /proc/<PID>/cmdline access permissions.
> > Therefore, the only way (at least i know) to hide all args of
> > processes is to start every program within shell script:
> > bash -c 'chmod /proc/$$/cmdline; exec userprogramm ...'
> >
> > Tested on 2.6.5.
> >
> > Agri
> 
> Huh? /proc/$PID/cmdline doesn't exist until after a task is
> created. 
So setting all /proc/$PID/* file parameters should be a part of task creation.

> What you did was create a task, change whatever
> is in proc, then exec (which doesn't change the PID).
I know that. It solved my problem, but didn't fix the bug.
Any fork of a process reveals all its args.
Everybody have a right to be paranoid to hide everything, don't u think? :-)
Huh... Including number of processes. :-)

> 
> How would you expect fork() to know that you wanted to
> do this? The permissions in /proc are file permissions.
> They have nothing to do with a task.
> 
> Also, any task can read its own command-line without using
> /proc at all.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
>             Note 96.31% of all statistics are fiction.
> 
> 
> 

