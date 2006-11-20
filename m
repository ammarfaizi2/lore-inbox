Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966389AbWKTSe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966389AbWKTSe7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966390AbWKTSe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:34:59 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10959 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S966389AbWKTSe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:34:57 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make fs/proc/base.c:proc_pid_instantiate() static
References: <20061120022422.GQ31879@stusta.de>
Date: Mon, 20 Nov 2006 11:33:59 -0700
In-Reply-To: <20061120022422.GQ31879@stusta.de> (Adrian Bunk's message of
	"Mon, 20 Nov 2006 03:24:22 +0100")
Message-ID: <m1zmamufvs.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> This patch makes the needlessly global proc_pid_instantiate() static.

Looks good to me.

Acked-by: Eric W. Biederman <ebiederm@xmission.com>

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> --- linux-2.6.19-rc5-mm2/fs/proc/base.c.old 2006-11-20 02:08:33.000000000 +0100
> +++ linux-2.6.19-rc5-mm2/fs/proc/base.c	2006-11-20 02:08:47.000000000 +0100
> @@ -1946,8 +1946,9 @@
>  	return;
>  }
>  
> -struct dentry *proc_pid_instantiate(struct inode *dir,
> -	struct dentry * dentry, struct task_struct *task, void *ptr)
> +static struct dentry *proc_pid_instantiate(struct inode *dir,
> +					   struct dentry * dentry,
> +					   struct task_struct *task, void *ptr)
>  {
>  	struct dentry *error = ERR_PTR(-ENOENT);
>  	struct inode *inode;
