Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbUKWI4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbUKWI4t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 03:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbUKWI4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 03:56:49 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:64719 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262332AbUKWI4n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 03:56:43 -0500
Subject: Re: [PATCH 2.6.9] fork: add a hook in do_fork()
From: Guillaume Thouvenin <Guillaume.Thouvenin@Bull.net>
To: Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       guillaume.thouvenin@bull.net
In-Reply-To: <20041123080643.GD23974@kroah.com>
References: <1101189797.6210.53.camel@frecb000711.frec.bull.fr>
	 <20041123080643.GD23974@kroah.com>
Date: Tue, 23 Nov 2004 09:56:37 +0100
Message-Id: <1101200197.6210.72.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2004 10:03:42,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2004 10:03:45,
	Serialize complete at 23/11/2004 10:03:45
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-23 at 00:06 -0800, Greg KH wrote:
> On Tue, Nov 23, 2004 at 07:03:17AM +0100, Guillaume Thouvenin wrote:
> > 
> >    I don't know if this solution is good but it's easy to implement and
> > it just does the trick. I made some tests and it doesn't impact the
> > performance of the Linux kernel. 
> 
> What's wrong with the LSM hook already available for you to use for this
> function?
> 
> thanks,

In fact I don't see how to use LSM hook to get information like PID of
the parent and the child. As far as I understand LSM hook, I can
register my own pointer to security_operations and like this, I can add
an hook in fork through the security_task_create() right? So my function
will be called each time a new process will be created but the only
parameter passed to the function is the clone_flags.

Is it possible to get the parent PID and the child PID which are
involved when the fork occurred?

Thank you very much for your help,
Guillaume

