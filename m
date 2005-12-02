Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVLBMgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVLBMgt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 07:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbVLBMgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 07:36:49 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:60437 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750714AbVLBMgs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 07:36:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bs+Kr0HGcPUQL5/8FzAVnta6sve3f+nVqzNmULutgtDfWS5t+9pXZag5At2mcjO6rMMapv/ZxnFcle6J+Gq5gx/Llf/6PbJ3ltCBDbcwljpUJfcDEu6obIve5VP+C7+mLQYeUBVFoWQZxUT4Y6I6PPvedL76rFBMzAzf/Od2qp8=
Message-ID: <ee0ae26a0512020436w2c000a5dq@mail.gmail.com>
Date: Fri, 2 Dec 2005 21:36:45 +0900
From: Yanggun <yang.geum.seok@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.14 + SATAII150 TX2Plus does not recognize
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43902A52.9040909@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ee0ae26a0512020039k1a28da61y@mail.gmail.com>
	 <43902A52.9040909@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks.

but sata_promise driver not seem to support hot-swap. As following
message is said, it becomes block. Even if use irqpoll option, result
is same.

I want to use hot-swap.

Nov 18 03:19:36  kernel: irq 11: nobody cared (try booting with the
"irqpoll" option)
Nov 18 03:19:36  kernel:  [__report_bad_irq+42/141] __report_bad_irq+0x2a/0x8d
Nov 18 03:19:36  kernel:  [note_interrupt+158/247] note_interrupt+0x9e/0xf7
Nov 18 03:19:36  kernel:  [__do_IRQ+261/292] __do_IRQ+0x105/0x124
Nov 18 03:19:36  kernel:  [do_IRQ+82/124] do_IRQ+0x52/0x7c
Nov 18 03:19:36  kernel:  =======================
Nov 18 03:19:36  kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
Nov 18 03:19:36  kernel:  [__do_softirq+58/156] __do_softirq+0x3a/0x9c
Nov 18 03:19:36  kernel:  [do_softirq+112/116] do_softirq+0x70/0x74
Nov 18 03:19:36  kernel:  =======================
Nov 18 03:19:36  kernel:  [irq_exit+56/58] irq_exit+0x38/0x3a
Nov 18 03:19:36  kernel:  [do_IRQ+89/124] do_IRQ+0x59/0x7c
Nov 18 03:19:36  kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
Nov 18 03:19:36  gconfd (root-2818): Received signal 1, shutting down cleanly
Nov 18 03:19:55  kernel:  [unix_poll+96/180] unix_poll+0x60/0xb4
Nov 18 03:19:55  gconfd (root-2818): Exiting
Nov 18 03:19:55  kernel:  [get_offset_tsc+14/23] get_offset_tsc+0xe/0x17
Nov 18 03:19:55  kernel:  [do_gettimeofday+24/176] do_gettimeofday+0x18/0xb0
Nov 18 03:19:55  kernel:  [sys_gettimeofday+39/127] sys_gettimeofday+0x27/0x7f
Nov 18 03:19:55  kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 03:19:55  kernel: handlers:

2005/12/2, Tejun Heo <htejun@gmail.com>:
> Yanggun wrote:
> > Hi,
> >
> > i am currently using linux kernel version 2.6.14 on x86 with Promise
> > SATAII150 TX2Plus(250G SATA HDD Disk x 2).
> >
> > But, SATA HDD disk does not become. program execute result of "fdisk
> > /dev/sda" is  "Unable to read /dev/sda".
> >
> > Work well in linux kernel version 2.6.13.2.
> >
> > Do not act below since change as result that do debugging.
> >        "[SCSI] use scatter lists for all block pc requests and
> > simplify hw handlers"
> >        -  http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=392160335c798bbe94ab3aae6ea0c85d32b81bbc
> >
> > What should I do?
> >
>
> Your controller is probably supported by sata_promise driver included in
> the kernel.  Just use the standard driver.
>
> --
> tejun
>
