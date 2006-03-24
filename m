Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWCXTcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWCXTcu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWCXTcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:32:50 -0500
Received: from xenotime.net ([66.160.160.81]:12500 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964794AbWCXTct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:32:49 -0500
Date: Fri, 24 Mar 2006 11:35:02 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, viro@ftp.linux.org.uk
Subject: Re: [BLOCK] delay all uevents until partition table is scanned
Message-Id: <20060324113502.e6583da6.rdunlap@xenotime.net>
In-Reply-To: <20060324191748.GA13654@vrfy.org>
References: <20060324191748.GA13654@vrfy.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2006 20:17:48 +0100 Kay Sievers wrote:

> From: Kay Sievers <kay.sievers@suse.de>
> 
> [BLOCK] delay all uevents until partition table is scanned
> 
> +	/* scan partition table, but supress uevents */
> +	disk->part_uevent_supress = 1;
> +	err = blkdev_get(bdev, FMODE_READ, 0);
> +	disk->part_uevent_supress = 0;

s/supress/suppress/ please.

> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index eef5ccd..089bb01 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -104,6 +104,7 @@ struct gendisk {
>                                           * disks that can't be partitioned. */
>  	char disk_name[32];		/* name of major driver */
>  	struct hd_struct **part;	/* [indexed by minor] */
> +	int part_uevent_supress;


---
~Randy
