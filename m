Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290810AbSBLHTU>; Tue, 12 Feb 2002 02:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290811AbSBLHTK>; Tue, 12 Feb 2002 02:19:10 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:16378 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290810AbSBLHTF>; Tue, 12 Feb 2002 02:19:05 -0500
Date: Tue, 12 Feb 2002 02:18:47 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200202120718.g1C7IlS29064@devserv.devel.redhat.com>
To: zwane@linux.realnet.co.sz
Cc: Kernel Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk prefix cleanups.
In-Reply-To: <mailman.1013495822.30629.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1013495822.30629.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is a simple patch which reduces resultant binary size by 1.2k for 
> this particular module (opl3sa2). [...]

>  #define OPL3SA2_MODULE_NAME	"opl3sa2"
> +#define OPL3SA2_PFX		OPL3SA2_MODULE_NAME ": "
 
> -			printk(KERN_ERR "opl3sa2: MSS mixer not installed?\n");
> +			printk(KERN_ERR OPL3SA2_PFX "MSS mixer not installed?\n");

I do not believe that it shortens binaries. Care to quote
size(1) output and /proc/modules with and without the patch?

-- Pete
