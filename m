Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWISQav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWISQav (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbWISQav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:30:51 -0400
Received: from smtp-out.google.com ([216.239.33.17]:18339 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751512AbWISQau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:30:50 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=csRYkdLWyQymvj19jmam9k467kPYD7c0EJgPmwauFgiqGnDsgfaU7XQ4kn+JUmXWw
	HiLWgvKrzKIJjLiE+se6w==
Subject: Re: [Patch 01/05]- Containers: Documentation on using containers
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, devel@openvz.org,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200609191532.k8JFWJfE022222@turing-police.cc.vt.edu>
References: <1158284314.5408.146.camel@galaxy.corp.google.com>
	 <200609191532.k8JFWJfE022222@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: Google Inc
Date: Tue, 19 Sep 2006 09:30:24 -0700
Message-Id: <1158683424.18533.51.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-19 at 11:32 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 14 Sep 2006 18:38:33 PDT, Rohit Seth said:
> 
> (Sorry for the late reply...)
> 
> 
> > --- linux-2.6.18-rc6-mm2.org/Documentation/containers.txt	1969-12-31 16:00:00.000000000 -0800
> > +++ linux-2.6.18-rc6-mm2.ctn/Documentation/containers.txt	2006-09-14 17:13:48.000000000 -0700
> 
> > +5- Remove a task from container
> > +	echo <pid> rmtask
> 
> echo <pid> > rmtask
> 
> is what I think was intended.  Also, I'm not sure <pid> is the best
> meta-syntax - anybody got a better idea?
> 

Fixed that.

> > +9- Freeing a container
> > +	cd /mnt/configfs/containers/
> > +	rmdir test_container
> 
> What happens if you try to remove a container that still has active tasks? Are
> you relying on the VFS to catch the 'non-empty directory'? (of course, 'rm -r'
> has predictable semantics here).
> 

When a rmdir operation is done on a directory, then all tasks have to
move out of container (before we the rmdir operation is complete).  This
removal of tasks from a container is done as part of
container_remove_tasks.

> I see support for "add a task" and "remove a task", but none for listing
> the current tasks in the container?

This is one of the TODO items that I've listed.  Will be there soon.

thanks,
-rohit

