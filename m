Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263645AbUFCNpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbUFCNpt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 09:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbUFCNpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 09:45:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:42203 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263645AbUFCNps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 09:45:48 -0400
Date: Thu, 3 Jun 2004 15:44:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Paul Clements <paul.clements@steeleye.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd: fix device names
Message-ID: <20040603134440.GC3915@openzaurus.ucw.cz>
References: <4034FDD0.33BC57AF@SteelEye.com> <40BC8C49.4020602@steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BC8C49.4020602@steeleye.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It seems more appropriate to call the devices "nbX" rather than 
> "nbdX",
> since that's what the device nodes are actually named.

> @@ -713,7 +753,7 @@ static int __init nbd_init(void)
>  		disk->fops = &nbd_fops;
>  		disk->private_data = &nbd_dev[i];
>  		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
> -		sprintf(disk->disk_name, "nbd%d", i);
> +		sprintf(disk->disk_name, "nb%d", i);
>  		sprintf(disk->devfs_name, "nbd/%d", i);

You might want to fix devfs name, too.


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

