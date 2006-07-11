Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbWGKGD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbWGKGD4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbWGKGD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:03:56 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:21626 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965130AbWGKGDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:03:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=X95yDRPx4W/h9lxLnTDSUwjo8FFYeCkqo1Nws8ZsXYFKK3rDjWZf9Ol4NBwxwHR10aKdueDIWzTwzcX/KUbNnAyvquZgQ7UTIa/IAwBeMAwzMsFJYDrUxv0zEQAdNpWlIBVhVFI7XN1YQ6s+Um1saeE5lCe+GK1VLSM8S/SqLnI=
Message-ID: <4dccc9070607102303v380281adp3943e1d58fad8d0@mail.gmail.com>
Date: Tue, 11 Jul 2006 11:33:54 +0530
From: "Srinivas Ganji" <srinivasganji.linux@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Spinlock Related Debug Messages in Block Driver
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I implemented the sample block driver for the removable devices and
the code contains no statements related to the spin lock except a lock
to the blk_init_queue API as shown below.

spinlock_t qlock;
gDisk->blkqueue = blk_init_queue(do_my_request, &gDisk->qlock);

The kernel version is 2.6.10.

Everything works fine but when I try to copy a file of huge size
(about 100MB), the following debug messages are getting displayed on
the console:

Fc3: drivers/block/ll_rw_blk.c: 2351: spin_lock already locked by the drivers.
Fc3: drivers/block/ll_rw_blk.c: 2468: spin_unlock not locked by the drivers.

In spite of these debug messages; the file is getting copied successfully.
I studied the Block driver 16th chapter in LDD third edition.

Can any one provide a pointer to these debug messages. Do I need to
implement any patches for the kernel.

Regards,
Srinivas G.
