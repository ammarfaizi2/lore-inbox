Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264133AbTKJWBB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 17:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbTKJWBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 17:01:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:16294 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264133AbTKJWA7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 17:00:59 -0500
Date: Mon, 10 Nov 2003 14:04:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?UmFt824=?= Rey Vicente <ramon.rey@hispalinux.es>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [2.6.0-test9-mm2] Badness in as_put_request at
 drivers/block/as-iosched.c:1783
Message-Id: <20031110140451.2b5db433.akpm@osdl.org>
In-Reply-To: <1068500134.2060.3.camel@debian>
References: <1068500134.2060.3.camel@debian>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ramón Rey Vicente <ramon.rey@hispalinux.es> wrote:
>
> Hi.
> 
> Trying to scan de ide-scsi devices of my system, I get this
> 
> arq->state 4
> Badness in as_put_request at drivers/block/as-iosched.c:1783
> Call Trace:
>  [<c01dc908>] as_put_request+0x48/0xa0
>  [<c01d47d3>] elv_put_request+0x13/0x20
>  [<c01d69f2>] __blk_put_request+0x52/0xa0
>  [<c01d6a61>] blk_put_request+0x21/0x40
>  [<c01d9d0e>] sg_io+0x2ee/0x440
>  [<c01da5c0>] scsi_cmd_ioctl+0x3c0/0x480
>  [<c0124b49>] update_process_times+0x29/0x40
>  [<c011949c>] schedule+0x31c/0x620
>  [<d093bb65>] cdrom_ioctl+0x25/0xd60 [cdrom]
>  [<c012eb33>] do_clock_nanosleep+0x1b3/0x300
>  [<c0119800>] default_wake_function+0x0/0x20
>  [<c01d86fa>] blkdev_ioctl+0x7a/0x383
>  [<c01584be>] block_ioctl+0x1e/0x40
>  [<c016158f>] sys_ioctl+0xef/0x260
>  [<c0257c57>] syscall_call+0x7/0xb

It looks to me that a simple set_request()/put_request() will always do
this.

Nick?
