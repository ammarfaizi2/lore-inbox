Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWCAN5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWCAN5R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 08:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWCAN5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 08:57:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:53433 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750835AbWCAN5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 08:57:15 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.16-rc5-mm1
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Laurent Riffard <laurent.riffard@free.fr>, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, rjw@sisk.pl, mbligh@mbligh.org,
       clameter@engr.sgi.com, ebiederm@xmission.com
In-Reply-To: <20060301023235.735c8c47.akpm@osdl.org>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	 <9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	 <4404CE39.6000109@liberouter.org>
	 <9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	 <4404DA29.7070902@free.fr> <20060228162157.0ed55ce6.akpm@osdl.org>
	 <4405723E.5060606@free.fr>  <20060301023235.735c8c47.akpm@osdl.org>
Content-Type: text/plain; charset=utf-8
Date: Wed, 01 Mar 2006 14:58:31 +0100
Message-Id: <1141221511.7775.10.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-01 at 02:32 -0800, Andrew Morton wrote:
> Laurent Riffard <laurent.riffard@free.fr> wrote:
> >
> > Le 01.03.2006 01:21, Andrew Morton a écrit :
> >  > Laurent Riffard <laurent.riffard@free.fr> wrote:
> >  > 
> >  >>BUG: unable to handle kernel NULL pointer dereference at virtual address 00000034
> >  > 
> >  > 
> >  > I booted that thing on five machines, four architectures :(
> >  > 
> >  > Could people please test a couple more patchsets, see if we can isolate it?
> >  > 
> >  > http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.1.gz
> >  > 
> >  > is 2.6.16-rc5-mm1 minus:
> >  > 
> >  > proc-make-proc_numbuf-the-buffer-size-for-holding-a.patch
> >  > tref-implement-task-references.patch
> >  > proc-dont-lock-task_structs-indefinitely.patch
> >  > proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
> >  > proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch
> >  > proc-optimize-proc_check_dentry_visible.patch
> > 
> >  Ok, 2.6.16-rc5-mm1.1 works for me:
> >  - I can run java from command line in runlevel 1
> >  - I can launch Mozilla in X
> 
> Useful, thanks.  So the second batch of /proc patches are indeed the problem.
> 
> If you have (even more) time you could test
> http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm2-pre1.gz. 
> That's the latest of everything with the problematic sysfs patches reverted
> and Eric's recent /proc fixes.

Seems to work OK here, with debug settings as in Paul Jackson's report.
No java crash, no fuser -n tcp NNNN crash.  Only thing I see so far is
the proc symbolic link to nirvana permissions thingie.  Box is P4 HT.

	-Mike

