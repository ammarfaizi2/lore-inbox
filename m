Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbUBWDAL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 22:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbUBWDAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 22:00:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:62142 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261794AbUBWDAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 22:00:05 -0500
Date: Sun, 22 Feb 2004 19:00:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.6.2, Partition support for SCSI CDROM...
Message-Id: <20040222190047.01f6f024.akpm@osdl.org>
In-Reply-To: <40396134.6030906@realitydiluted.com>
References: <40396134.6030906@realitydiluted.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Steven J. Hill" <sjhill@realitydiluted.com> wrote:
>
> Greetings.
> 
> This patch enables support for CDROMs that have partitions on
> them, like say SGI and SUN media. It was sent to me by Christoph
> Hellwig and then I cleaned it up a bit. I am posting it more
> for flamebait^Wcomments to see if people are comfortable with it.

> +config BLK_DEV_SR_PARTITIONS
> +config BLK_DEV_SR_PARTITIONS_PER_DEVICE

Do we actually need these config options?  Why not hardwire it to some
reasonable upper bound and be done with it?

>  
> +#ifdef MODULE
> +	/* Check number of partitions specified. */
> +	if (partitions < 0)
> +		partitions = 0;
> +#endif
> +

Why is this ifdef needed?
