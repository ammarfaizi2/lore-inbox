Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWIIAPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWIIAPU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 20:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWIIAPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 20:15:20 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:24989 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751226AbWIIAPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 20:15:17 -0400
Date: Fri, 8 Sep 2006 17:15:05 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Zach Brown <zach.brown@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/10] configfs: use size_t length modifier in pr_debug format argument
Message-ID: <20060909001505.GE22572@ca-server1.us.oracle.com>
Mail-Followup-To: Zach Brown <zach.brown@oracle.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net> <20060908225453.9340.85458.sendpatchset@kaori.pdx.zabbo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908225453.9340.85458.sendpatchset@kaori.pdx.zabbo.net>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 03:54:53PM -0700, Zach Brown wrote:
> configfs: use size_t length modifier in pr_debug format argument

Signed-off-by: Joel Becker <joel.becker@oracle.com>
> 
> Signed-off-by: Zach Brown <zach.brown@oracle.com>
> ---
> 
>  fs/configfs/file.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: 2.6.18-rc6-debug-args/fs/configfs/file.c
> ===================================================================
> --- 2.6.18-rc6-debug-args.orig/fs/configfs/file.c
> +++ 2.6.18-rc6-debug-args/fs/configfs/file.c
> @@ -137,8 +137,8 @@ configfs_read_file(struct file *file, ch
>  		if ((retval = fill_read_buffer(file->f_dentry,buffer)))
>  			goto out;
>  	}
> -	pr_debug("%s: count = %d, ppos = %lld, buf = %s\n",
> -		 __FUNCTION__,count,*ppos,buffer->page);
> +	pr_debug("%s: count = %zd, ppos = %lld, buf = %s\n",
> +		 __FUNCTION__, count, *ppos, buffer->page);
>  	retval = flush_read_buffer(buffer,buf,count,ppos);
>  out:
>  	up(&buffer->sem);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

 The herd instinct among economists makes sheep look like
 independant thinkers.

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
