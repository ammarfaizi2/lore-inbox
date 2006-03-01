Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWCAKHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWCAKHD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 05:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWCAKHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 05:07:03 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:1736 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S932136AbWCAKHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 05:07:01 -0500
Message-ID: <4405723E.5060606@free.fr>
Date: Wed, 01 Mar 2006 11:06:54 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050920
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Martin Bligh <mbligh@mbligh.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.16-rc5-mm1
References: <20060228042439.43e6ef41.akpm@osdl.org>	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>	<4404CE39.6000109@liberouter.org>	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>	<4404DA29.7070902@free.fr> <20060228162157.0ed55ce6.akpm@osdl.org>
In-Reply-To: <20060228162157.0ed55ce6.akpm@osdl.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 01.03.2006 01:21, Andrew Morton a écrit :
> Laurent Riffard <laurent.riffard@free.fr> wrote:
> 
>>BUG: unable to handle kernel NULL pointer dereference at virtual address 00000034
> 
> 
> I booted that thing on five machines, four architectures :(
> 
> Could people please test a couple more patchsets, see if we can isolate it?
> 
> http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.1.gz
> 
> is 2.6.16-rc5-mm1 minus:
> 
> proc-make-proc_numbuf-the-buffer-size-for-holding-a.patch
> tref-implement-task-references.patch
> proc-dont-lock-task_structs-indefinitely.patch
> proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
> proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch
> proc-optimize-proc_check_dentry_visible.patch

Ok, 2.6.16-rc5-mm1.1 works for me:
- I can run java from command line in runlevel 1
- I can launch Mozilla in X

> and http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.2.gz is
> 2.6.16-rc5-mm1 minus:
> 
> trivial-cleanup-to-proc_check_chroot.patch
> proc-fix-the-inode-number-on-proc-pid-fd.patch
> proc-remove-useless-bkl-in-proc_pid_readlink.patch
> proc-remove-unnecessary-and-misleading-assignments.patch
> proc-simplify-the-ownership-rules-for-proc.patch
> proc-replace-proc_inodetype-with-proc_inodefd.patch
> proc-remove-bogus-proc_task_permission.patch
> proc-kill-proc_mem_inode_operations.patch
> proc-properly-filter-out-files-that-are-not-visible.patch
> proc-fix-the-link-count-for-proc-pid-task.patch
> proc-move-proc_maps_operations-into-task_mmuc.patch
> dcache-add-helper-d_hash_and_lookup.patch
> proc-rewrite-the-proc-dentry-flush-on-exit.patch
> proc-close-the-race-of-a-process-dying-durning.patch
> proc-refactor-reading-directories-of-tasks.patch
> #
> proc-make-proc_numbuf-the-buffer-size-for-holding-a.patch
> tref-implement-task-references.patch
> proc-dont-lock-task_structs-indefinitely.patch
> proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
> proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch
> proc-optimize-proc_check_dentry_visible.patch
> 
> 
> Thanks.

I guess you don't need me to test 2.6.16-rc5-mm1.2 since 
2.6.16-rc5-mm1.1 is OK.

thanks
-- 
laurent
