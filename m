Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbUAOU4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 15:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUAOU4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 15:56:14 -0500
Received: from ms-smtp-01-qfe0.nyroc.rr.com ([24.24.2.55]:33775 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S263468AbUAOUzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 15:55:52 -0500
Date: Thu, 15 Jan 2004 15:55:42 -0500
To: sank saraph <sank_kernel@computermail.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: help project
Message-ID: <20040115205542.GA5149@andromeda>
References: <20040113144551.00C2D7263@sitemail.everyone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113144551.00C2D7263@sitemail.everyone.net>
User-Agent: Mutt/1.5.4i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a similar interest: I want to be able to take a process, save its
state to a file, reboot, and reload the process.  Possibly on a
different machine.  I hope you realize that there are _lots_ of points
of failure, things like file deletion.  You should look at the mosix
clustering project; they save the userspace state of a process, and
transfer that across the network, and have system calls run on the
remote host, which has all the arch-specific stuff.  A process ("task")
is defined by a task_struct, in include/linux/sched.h., but that
definition is not at all self-contained.  See
[http://www.clarkson.edu/~pryzbyj/task/struct-task_struct.html] for some
work I did to convince myself of this.  (I've given up on that
document).  In short, there's no good way of doing this .. mosix saves
the user context easily enough, but, sadly, saving the kernel stuff is,
at best, extremely tedious.  Let me know if you come up with anything
else.

Justin
On Tue, Jan 13, 2004 at 06:45:51AM -0800, sank saraph wrote:
> Hello all,
>                   I am currently working on the project ???Process Migration???
> I want to save all the context, memory address space. So that it is
> transferred to remote node & resume that process.
>                 So how can I save the context of process? 
> Thanks in advanced ???.  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
