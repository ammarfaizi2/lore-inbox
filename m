Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbULCJd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbULCJd0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 04:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbULCJd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 04:33:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:61152 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262116AbULCJdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 04:33:22 -0500
Date: Fri, 3 Dec 2004 01:32:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Olivier RAMAT" <olrt@ifrance.com>
Cc: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Kernel 2.6.9 oops during data transfer to noname usb key
Message-Id: <20041203013254.55534ef8.akpm@osdl.org>
In-Reply-To: <0412030857.370100@th00.idoo.com>
References: <0412030857.370100@th00.idoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Olivier RAMAT" <olrt@ifrance.com> wrote:
>
> Hello !
> This is my first post to the linux.kernel mailing list so please
> apologize ;-)
> 
> Here's the oops that I experienced while copying files to my noname
> usb key :

A few things have been fixed since then.  Please test either 2.6.10-rc2
plus
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.10-rc2-bk16.gz
or test 2.6.10-rc3 when it is released.  And then send a followup report.


> Nov 10 07:47:40 darkstar kernel:  [<c0103f25>]
> kernel_thread_helper+0x5/0x10
> Nov 10 07:47:40 darkstar kernel: SCSI error : <0 0 0 0> return code =
> 0x70000
> Nov 10 07:47:40 darkstar kernel: end_request: I/O error, dev sda, sector
> 348970
> Nov 10 07:47:40 darkstar kernel: Buffer I/O error on device sda1,
> logical block 348907
> Nov 10 07:47:40 darkstar kernel: lost page write due to I/O error on
> sda1
> Nov 10 07:47:50 darkstar kernel: ------------[ cut here ]------------
> Nov 10 07:47:50 darkstar kernel: kernel BUG at
> /usr/src/linux-2.6.9/drivers/block/as-iosched.c:1853!

Ouch.  Haven't seen that before.  Maybe scsi error recovery screwed up the
request queueing.  James, have we fixed anything in that area post-2.6.9?

