Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263919AbUCZDpJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263920AbUCZDpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:45:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:14731 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263919AbUCZDpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:45:04 -0500
Date: Thu, 25 Mar 2004 19:44:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: mike.miller@hp.com
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: cciss update for 2.6
Message-Id: <20040325194458.048b0f46.akpm@osdl.org>
In-Reply-To: <20040325224641.GE4456@beardog.cca.cpqcorp.net>
References: <20040325224641.GE4456@beardog.cca.cpqcorp.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike.miller@hp.com wrote:
>
> Please consider this patch for inclusion in the 2.6 kernel.
>

I think this was a 2.4 patch?

> 
>  If no device is attached we now return -ENXIO instead of some bogus numbers.
>  Prevents applications from trying to access non-existent disks.
>  Also adds HDIO_GETGEO_BIG IOCTL that fdisk uses.

drivers/block/cciss.c: In function `cciss_ioctl':
drivers/block/cciss.c:480: `HDIO_GETGEO_BIG' undeclared (first use in this function)
drivers/block/cciss.c:480: (Each undeclared identifier is reported only once
drivers/block/cciss.c:480: for each function it appears in.)
drivers/block/cciss.c:482: storage size of `driver_geo' isn't known
drivers/block/cciss.c:483: `dsk' undeclared (first use in this function)
drivers/block/cciss.c:490: structure has no member named `hd'
drivers/block/cciss.c:492: sizeof applied to an incomplete type
drivers/block/cciss.c:482: warning: unused variable `driver_geo'

