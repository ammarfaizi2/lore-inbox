Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752032AbWCBSKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbWCBSKJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 13:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbWCBSKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 13:10:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4556 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752029AbWCBSKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 13:10:07 -0500
Date: Thu, 2 Mar 2006 10:08:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Permit NFS superblock sharing [try #2]
Message-Id: <20060302100838.63bc8741.akpm@osdl.org>
In-Reply-To: <13560.1141322238@warthog.cambridge.redhat.com>
References: <20060302092854.2818e98c.akpm@osdl.org>
	<20060301162113.774d1745.akpm@osdl.org>
	<20060301173617.16639.83553.stgit@warthog.cambridge.redhat.com>
	<3718.1141299945@warthog.cambridge.redhat.com>
	<13560.1141322238@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> > nfs-apply-mount-root-dentry-override-to-filesystems:
>  > 3 out of 10 hunks FAILED -- saving rejects to file fs/nfs/inode.c.rej
> 
>  Would it help you if I split the NFS bits out of patch 2 into a separate patch?

I wouldn't worry about splitting patches to make their application easier -
the main thing is to ensure that they're logical units from the
design/implementation POV.  And that the kernel should compile (and
hopefully run) at each stage of the series.

And don't worry about the -mm-only patches - I'll sort them out.  Unless
people are working against functionality which is only in -mm, they should
work against mainline.

But in the case where you're hitting hard on a particular subsystem, the
best tree to work against is that subsystem's tree.  Which is a bit of a
pain if you want to put your feature out to external testers, because then
you need to also make a snapshot of the subsystem tree available as well. 
That's just a cost of doing business, really.  It ends up being extremely
simple if one is using quilt.

