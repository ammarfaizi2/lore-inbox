Return-Path: <linux-kernel-owner+w=401wt.eu-S932521AbXAQQ5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbXAQQ5D (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 11:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbXAQQ5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 11:57:01 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:40412 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932521AbXAQQ47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 11:56:59 -0500
Message-ID: <45AE567C.3080706@sw.ru>
Date: Wed, 17 Jan 2007 20:01:48 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "<Andrew Morton" <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       linux-mips@linux-mips.org, linux-parport@lists.infradead.org,
       minyard@acm.org, rtc-linux@googlegroups.com, clemens@ladisch.de,
       heiko.carstens@de.ibm.com, xfs@oss.sgi.com, linuxppc-dev@ozlabs.org,
       paulus@samba.org, openipmi-developer@lists.sourceforge.net,
       linux-390@vm.marist.edu, schwidefsky@de.ibm.com, tim@cyberelk.net,
       codalist@TELEMANN.coda.cs.cmu.edu, a.zummo@towertech.it,
       tony.luck@intel.com, vojtech@suse.cz, linux-scsi@vger.kernel.org,
       xfs-masters@oss.sgi.com, linux-ntfs-dev@lists.sourceforge.net,
       netdev@vger.kernel.org, aia21@cantab.net, aharkes@cs.cmu.edu,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       mark.fasheh@oracle.com, coda@cs.cmu.edu, lethal@linux-sh.org,
       kurt.hackel@oracle.com, containers@lists.osdl.org, linux390@de.ibm.com,
       philb@gnu.org, andrea@suse.de,
       linuxsh-shmedia-dev@lists.sourceforge.net, ak@suse.de
Subject: Re: [PATCH 14/59] sysctl: C99 convert xfs ctl_tables
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com> <11689656301563-git-send-email-ebiederm@xmission.com>
In-Reply-To: <11689656301563-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

minor extra space in table below...

Kirill

> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  fs/xfs/linux-2.6/xfs_sysctl.c |  258 ++++++++++++++++++++++++++++------------
>  1 files changed, 180 insertions(+), 78 deletions(-)
> 
> diff --git a/fs/xfs/linux-2.6/xfs_sysctl.c b/fs/xfs/linux-2.6/xfs_sysctl.c
> index af777e9..5a0eefc 100644
> --- a/fs/xfs/linux-2.6/xfs_sysctl.c
> +++ b/fs/xfs/linux-2.6/xfs_sysctl.c
> @@ -55,95 +55,197 @@ xfs_stats_clear_proc_handler(
>  #endif /* CONFIG_PROC_FS */
>  
>  STATIC ctl_table xfs_table[] = {
> -	{XFS_RESTRICT_CHOWN, "restrict_chown", &xfs_params.restrict_chown.val,
> -	sizeof(int), 0644, NULL, &proc_dointvec_minmax,
> -	&sysctl_intvec, NULL,
> -	&xfs_params.restrict_chown.min, &xfs_params.restrict_chown.max},
> -
> -	{XFS_SGID_INHERIT, "irix_sgid_inherit", &xfs_params.sgid_inherit.val,
> -	sizeof(int), 0644, NULL, &proc_dointvec_minmax,
> -	&sysctl_intvec, NULL,
> -	&xfs_params.sgid_inherit.min, &xfs_params.sgid_inherit.max},
> -
> -	{XFS_SYMLINK_MODE, "irix_symlink_mode", &xfs_params.symlink_mode.val,
> -	sizeof(int), 0644, NULL, &proc_dointvec_minmax,
> -	&sysctl_intvec, NULL,
> -	&xfs_params.symlink_mode.min, &xfs_params.symlink_mode.max},
> -
> -	{XFS_PANIC_MASK, "panic_mask", &xfs_params.panic_mask.val,
> -	sizeof(int), 0644, NULL, &proc_dointvec_minmax,
> -	&sysctl_intvec, NULL,
> -	&xfs_params.panic_mask.min, &xfs_params.panic_mask.max},
> -
> -	{XFS_ERRLEVEL, "error_level", &xfs_params.error_level.val,
> -	sizeof(int), 0644, NULL, &proc_dointvec_minmax,
> -	&sysctl_intvec, NULL,
> -	&xfs_params.error_level.min, &xfs_params.error_level.max},
> -
> -	{XFS_SYNCD_TIMER, "xfssyncd_centisecs", &xfs_params.syncd_timer.val,
> -	sizeof(int), 0644, NULL, &proc_dointvec_minmax,
> -	&sysctl_intvec, NULL,
> -	&xfs_params.syncd_timer.min, &xfs_params.syncd_timer.max},
> -
> -	{XFS_INHERIT_SYNC, "inherit_sync", &xfs_params.inherit_sync.val,
> -	sizeof(int), 0644, NULL, &proc_dointvec_minmax,
> -	&sysctl_intvec, NULL,
> -	&xfs_params.inherit_sync.min, &xfs_params.inherit_sync.max},
> -
> -	{XFS_INHERIT_NODUMP, "inherit_nodump", &xfs_params.inherit_nodump.val,
> -	sizeof(int), 0644, NULL, &proc_dointvec_minmax,
> -	&sysctl_intvec, NULL,
> -	&xfs_params.inherit_nodump.min, &xfs_params.inherit_nodump.max},
> -
> -	{XFS_INHERIT_NOATIME, "inherit_noatime", &xfs_params.inherit_noatim.val,
> -	sizeof(int), 0644, NULL, &proc_dointvec_minmax,
> -	&sysctl_intvec, NULL,
> -	&xfs_params.inherit_noatim.min, &xfs_params.inherit_noatim.max},
> -
> -	{XFS_BUF_TIMER, "xfsbufd_centisecs", &xfs_params.xfs_buf_timer.val,
> -	sizeof(int), 0644, NULL, &proc_dointvec_minmax,
> -	&sysctl_intvec, NULL,
> -	&xfs_params.xfs_buf_timer.min, &xfs_params.xfs_buf_timer.max},
> -
> -	{XFS_BUF_AGE, "age_buffer_centisecs", &xfs_params.xfs_buf_age.val,
> -	sizeof(int), 0644, NULL, &proc_dointvec_minmax,
> -	&sysctl_intvec, NULL,
> -	&xfs_params.xfs_buf_age.min, &xfs_params.xfs_buf_age.max},
> -
> -	{XFS_INHERIT_NOSYM, "inherit_nosymlinks", &xfs_params.inherit_nosym.val,
> -	sizeof(int), 0644, NULL, &proc_dointvec_minmax,
> -	&sysctl_intvec, NULL,
> -	&xfs_params.inherit_nosym.min, &xfs_params.inherit_nosym.max},
> -
> -	{XFS_ROTORSTEP, "rotorstep", &xfs_params.rotorstep.val,
> -	sizeof(int), 0644, NULL, &proc_dointvec_minmax,
> -	&sysctl_intvec, NULL,
> -	&xfs_params.rotorstep.min, &xfs_params.rotorstep.max},
> -
> -	{XFS_INHERIT_NODFRG, "inherit_nodefrag", &xfs_params.inherit_nodfrg.val,
> -	sizeof(int), 0644, NULL, &proc_dointvec_minmax,
> -	&sysctl_intvec, NULL,
> -	&xfs_params.inherit_nodfrg.min, &xfs_params.inherit_nodfrg.max},
> +	{
> +		.ctl_name	= XFS_RESTRICT_CHOWN,
> +		.procname	= "restrict_chown",
> +		.data		= &xfs_params.restrict_chown.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec,
> +		.extra1		= &xfs_params.restrict_chown.min,
> +		.extra2		= &xfs_params.restrict_chown.max
> +	},
> +	{
> +		.ctl_name	= XFS_SGID_INHERIT,
> +		.procname	= "irix_sgid_inherit",
> +		.data		= &xfs_params.sgid_inherit.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec,
> +		.extra1		= &xfs_params.sgid_inherit.min,
> +		.extra2		= &xfs_params.sgid_inherit.max
> +	},
> +	{
> +		.ctl_name	= XFS_SYMLINK_MODE,
> +		.procname	= "irix_symlink_mode",
> +		.data		= &xfs_params.symlink_mode.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec,
> +		.extra1		= &xfs_params.symlink_mode.min,
> +		.extra2		= &xfs_params.symlink_mode.max
> +	},
> +	{
> +		.ctl_name	= XFS_PANIC_MASK,
> +		.procname	= "panic_mask",
> +		.data		= &xfs_params.panic_mask.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	=  &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec,
> +		.extra1		= &xfs_params.panic_mask.min,
> +		.extra2		= &xfs_params.panic_mask.max
> +	},
>  
> +	{
> +		.ctl_name	= XFS_ERRLEVEL,
> +		.procname	= "error_level",
> +		.data		= &xfs_params.error_level.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec,
> +		.extra1		= &xfs_params.error_level.min,
> +		.extra2		= &xfs_params.error_level.max
> +	},
> +	{
> +		.ctl_name	= XFS_SYNCD_TIMER,
> +		.procname	= "xfssyncd_centisecs",
> +		.data		= &xfs_params.syncd_timer.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec,
> +		.extra1		= &xfs_params.syncd_timer.min,
> +		.extra2		= &xfs_params.syncd_timer.max
> +	},
> +	{
> +		.ctl_name	= XFS_INHERIT_SYNC,
> +		.procname	= "inherit_sync",
> +		.data		= &xfs_params.inherit_sync.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec,
> +		.extra1		= &xfs_params.inherit_sync.min,
> +		.extra2		= &xfs_params.inherit_sync.max
> +	},
> +	{
> +		.ctl_name	= XFS_INHERIT_NODUMP,
> +		.procname	= "inherit_nodump",
> +		.data		= &xfs_params.inherit_nodump.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec, NULL,
> +		.extra1		= &xfs_params.inherit_nodump.min,
> +		.extra2		= &xfs_params.inherit_nodump.max
> +	},
> +	{
> +		.ctl_name	= XFS_INHERIT_NOATIME,
> +		.procname	= "inherit_noatime",
> +		.data		= &xfs_params.inherit_noatim.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec, NULL,
> +		.extra1		= &xfs_params.inherit_noatim.min,
> +		.extra2		= &xfs_params.inherit_noatim.max
> +	},
> +	{
> +		.ctl_name	= XFS_BUF_TIMER,
> +		.procname	= "xfsbufd_centisecs",
> +		.data		= &xfs_params.xfs_buf_timer.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec,
> +		.extra1		= &xfs_params.xfs_buf_timer.min,
> +		.extra2		= &xfs_params.xfs_buf_timer.max
> +	},
> +	{
> +		.ctl_name	= XFS_BUF_AGE,
> +		.procname	= "age_buffer_centisecs",
> +		.data		= &xfs_params.xfs_buf_age.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec, NULL,
> +		.extra1		= &xfs_params.xfs_buf_age.min,
> +		.extra2		= &xfs_params.xfs_buf_age.max
> +	},
> +	{
> +		.ctl_name	= XFS_INHERIT_NOSYM,
> +		.procname	= "inherit_nosymlinks",
> +		.data		= &xfs_params.inherit_nosym.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec,
> +		.extra1		= &xfs_params.inherit_nosym.min,
> +		.extra2		= &xfs_params.inherit_nosym.max
> +	},
> +	{
> +		.ctl_name	= XFS_ROTORSTEP,
> +		.procname	= "rotorstep",
> +		.data		= &xfs_params.rotorstep.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec,
> +		.extra1		= &xfs_params.rotorstep.min,
> +		.extra2		= &xfs_params.rotorstep.max
> +	},
> +	{
> +		.ctl_name	= XFS_INHERIT_NODFRG,
> +		.procname	= "inherit_nodefrag",
> +		.data		= &xfs_params.inherit_nodfrg.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec,
> +		.extra1		= &xfs_params.inherit_nodfrg.min,
> +		.extra2		= &xfs_params.inherit_nodfrg.max
> +	},
>  	/* please keep this the last entry */
>  #ifdef CONFIG_PROC_FS
> -	{XFS_STATS_CLEAR, "stats_clear", &xfs_params.stats_clear.val,
> -	sizeof(int), 0644, NULL, &xfs_stats_clear_proc_handler,
> -	&sysctl_intvec, NULL,
> -	&xfs_params.stats_clear.min, &xfs_params.stats_clear.max},
> +	{
> +		.ctl_name	= XFS_STATS_CLEAR,
> +		.procname	= "stats_clear",
> +		.data		= &xfs_params.stats_clear.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	=  &xfs_stats_clear_proc_handler,
<<< minor. extra space.
> +		.strategy	= &sysctl_intvec,
> +		.extra1		= &xfs_params.stats_clear.min,
> +		.extra2		= &xfs_params.stats_clear.max
> +	},
>  #endif /* CONFIG_PROC_FS */
>  
> -	{0}
> +	{}
>  };
>  
>  STATIC ctl_table xfs_dir_table[] = {
> -	{FS_XFS, "xfs", NULL, 0, 0555, xfs_table},
> -	{0}
> +	{
> +		.ctl_name	= FS_XFS,
> +		.procname	= "xfs",
> +		.mode		= 0555,
> +		.child		= xfs_table
> +	},
> +	{}
>  };
>  
>  STATIC ctl_table xfs_root_table[] = {
> -	{CTL_FS, "fs",  NULL, 0, 0555, xfs_dir_table},
> -	{0}
> +	{
> +		.ctl_name	= CTL_FS,
> +		.procname	= "fs",
> +		.mode		= 0555,
> +		.child		= xfs_dir_table
> +	},
> +	{}
>  };
>  
>  void

