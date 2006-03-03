Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752185AbWCCIxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbWCCIxw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 03:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189AbWCCIxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 03:53:52 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:34761 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1752185AbWCCIxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 03:53:51 -0500
Date: Fri, 3 Mar 2006 09:53:37 +0100 (CET)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Simon Derr <Simon.Derr@bull.net>, linux-kernel@vger.kernel.org,
       FACCINI BRUNO <Bruno.Faccini@bull.net>
Subject: Re: Deadlock in net/sunrpc/sched.c
In-Reply-To: <1141321512.10398.13.camel@netapplinux-10.connectathon.org>
Message-ID: <Pine.LNX.4.61.0603030943160.15393@openx3.frec.bull.fr>
References: <Pine.LNX.4.61.0603021116030.15393@openx3.frec.bull.fr>
 <1141321512.10398.13.camel@netapplinux-10.connectathon.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 03/03/2006 09:55:11,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 03/03/2006 09:55:22,
	Serialize complete at 03/03/2006 09:55:22
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2006, Trond Myklebust wrote:

> > Now to exit this loop, B needs to reach __rpc_do_wake_up_task() where a 
> > list_del will occur. But for this the RPC_TASK_WAKEUP must be released by 
> > process A, and this won't happen until process B releases the queue 
> > spinlock. --> deadlock.
> 
> Could you see if this fixes it?
> 
> Cheers,
>   Trond


Thanks, I will apply it.
But don't hold your breath though, this happened on a large cluster with 
high security and restricted access so I can't just try it like I would 
on my desktop machine.
There will probably be several weeks before I get back to you.

	Simon.

