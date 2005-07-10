Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVGJSYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVGJSYy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 14:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVGJSYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 14:24:47 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59297 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262013AbVGJSYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 14:24:03 -0400
Date: Sun, 10 Jul 2005 20:24:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [47/48] Suspend2 2.1.9.8 for 2.6.12: 623-generic-block-io.patch
Message-ID: <20050710182410.GK10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <1120616444110@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120616444110@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +static int target_type = -1;
> +
> +/*
> +static char * description[7] = {
> +	"Socket",
> +	"Link",
> +	"Regular file",
> +	"Block device",
> +	"Directory",
> +	"Character device",
> +	"Fifo",
> +};
> +*/
> +
...
> +/*
> + *		Helpers.
> + */
> +
> +/* 
> + * Return the type of target we have, an index into the descriptions
> + * above.
> + */
> +static int get_target_type(struct inode * inode)
> +{
> +	switch (inode->i_mode & S_IFMT) {
> +		case S_IFSOCK:
> +			target_type = 0;
> +			break;
> +		case S_IFLNK:
> +			target_type = 1;
> +			break;
> +		case S_IFREG:
> +			target_type = 2;
> +			break;
> +		case S_IFBLK:
> +			target_type = 3;
> +			break;
> +		case S_IFDIR:
> +			target_type = 4;
> +			break;
> +		case S_IFCHR:
> +			target_type = 5;
> +			break;
> +		case S_IFIFO:
> +			target_type = 6;
> +			break;
> +	}
> +	return target_type;
> +}
> +	
> +#define target_is_usable (!(target_type == 1 || target_type == 4))
> +#define target_num_sectors (target_inode->i_size >> target_blkbits)

Why do you need this?
								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
