Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWEDJ4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWEDJ4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 05:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWEDJ4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 05:56:12 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7696 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1751467AbWEDJ4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 05:56:11 -0400
Date: Thu, 4 May 2006 09:55:53 +0000
From: Pavel Machek <pavel@suse.cz>
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 6/13: eCryptfs] Superblock operations
Message-ID: <20060504095552.GC5844@ucw.cz>
References: <20060504031755.GA28257@hellewell.homeip.net> <20060504033829.GE28613@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504033829.GE28613@hellewell.homeip.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

> +/**
> + * Get the filesystem statistics. Currently, we let this pass right through
> + * to the lower filesystem and take no action ourselves.
> + */
> +static int ecryptfs_statfs(struct super_block *sb, struct kstatfs *buf)
> +{
> +	int rc = 0;
> +
> +	ecryptfs_printk(KERN_DEBUG, "Enter\n");
> +	rc = vfs_statfs(ECRYPTFS_SUPERBLOCK_TO_LOWER(sb), buf);
> +	ecryptfs_printk(KERN_DEBUG, "Exit; rc = [%d]\n", rc);
> +	return rc;
> +}

This is ugly. Could you remove the debugging, or at least use dprintk?


-- 
Thanks, Sharp!
