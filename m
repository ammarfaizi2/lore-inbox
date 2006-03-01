Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWCAA2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWCAA2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 19:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWCAA2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 19:28:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12989 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964861AbWCAA2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 19:28:31 -0500
Date: Tue, 28 Feb 2006 16:21:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Martin Bligh <mbligh@mbligh.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.16-rc5-mm1
Message-Id: <20060228162157.0ed55ce6.akpm@osdl.org>
In-Reply-To: <4404DA29.7070902@free.fr>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Riffard <laurent.riffard@free.fr> wrote:
>
> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000034

I booted that thing on five machines, four architectures :(

Could people please test a couple more patchsets, see if we can isolate it?

http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.1.gz

is 2.6.16-rc5-mm1 minus:

proc-make-proc_numbuf-the-buffer-size-for-holding-a.patch
tref-implement-task-references.patch
proc-dont-lock-task_structs-indefinitely.patch
proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch
proc-optimize-proc_check_dentry_visible.patch

and http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.2.gz is
2.6.16-rc5-mm1 minus:

trivial-cleanup-to-proc_check_chroot.patch
proc-fix-the-inode-number-on-proc-pid-fd.patch
proc-remove-useless-bkl-in-proc_pid_readlink.patch
proc-remove-unnecessary-and-misleading-assignments.patch
proc-simplify-the-ownership-rules-for-proc.patch
proc-replace-proc_inodetype-with-proc_inodefd.patch
proc-remove-bogus-proc_task_permission.patch
proc-kill-proc_mem_inode_operations.patch
proc-properly-filter-out-files-that-are-not-visible.patch
proc-fix-the-link-count-for-proc-pid-task.patch
proc-move-proc_maps_operations-into-task_mmuc.patch
dcache-add-helper-d_hash_and_lookup.patch
proc-rewrite-the-proc-dentry-flush-on-exit.patch
proc-close-the-race-of-a-process-dying-durning.patch
proc-refactor-reading-directories-of-tasks.patch
#
proc-make-proc_numbuf-the-buffer-size-for-holding-a.patch
tref-implement-task-references.patch
proc-dont-lock-task_structs-indefinitely.patch
proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch
proc-optimize-proc_check_dentry_visible.patch


Thanks.
