Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTJMSPj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 14:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTJMSPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 14:15:39 -0400
Received: from ulysses.news.tiscali.de ([195.185.185.36]:6917 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S261875AbTJMSPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 14:15:37 -0400
To: linux-kernel@vger.kernel.org
Path: 127.0.0.1!nobody
From: Peter Matthias <espi@epost.de>
Newsgroups: linux.kernel
Subject: Re: ACM USB modem on Kernel 2.6.0-test
Date: Mon, 13 Oct 2003 18:28:27 +0200
Organization: Tiscali Germany
Message-ID: <brjemb.gd.ln@127.0.0.1>
References: <FwYB.Z9.25@gated-at.bofh.it>
NNTP-Posting-Host: p62.246.118.45.tisdip.tiscali.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: ulysses.news.tiscali.de 1066068811 88718 62.246.118.45 (13 Oct 2003 18:13:31 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Mon, 13 Oct 2003 18:13:31 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell schrieb:

>> usb 3-3: configuration #1 chosen from 2 choices
>> drivers/usb/class/cdc-acm.c: need inactive config #2
>> drivers/usb/class/cdc-acm.c: need inactive config #2
> 
> Until we get more intelligence somewhere, do this:
> 
>     # cd /sys/bus/usb/devices/3-3
>     # echo '2' > bConfigurationValue
>     #

It works, but I get lots of theses warnings.

Peter

Badness in local_bh_enable at kernel/softirq.c:121
Call Trace:
 [<c011bf5d>] local_bh_enable+0x7d/0x80
 [<c0204984>] ppp_async_input+0x2f4/0x5a0
 [<c0203dcb>] ppp_asynctty_receive+0x4b/0x90
 [<c01def5f>] flush_to_ldisc+0x7f/0xd0
 [<df88d20f>] acm_read_bulk+0xbf/0x140 [cdc_acm]
 [<c023af59>] usb_hcd_giveback_urb+0x29/0x50
 [<c0248585>] dl_done_list+0xd5/0xe0
 [<c0248ea0>] ohci_irq+0xe0/0x150
 [<c023afb6>] usb_hcd_irq+0x36/0x60
 [<c010a9ca>] handle_IRQ_event+0x3a/0x70
 [<c010acb1>] do_IRQ+0x71/0xf0
 [<c010920c>] common_interrupt+0x18/0x20

Badness in local_bh_enable at kernel/softirq.c:121
Call Trace:
 [<c011bf5d>] local_bh_enable+0x7d/0x80
 [<c0203dd0>] ppp_asynctty_receive+0x50/0x90
 [<c01def5f>] flush_to_ldisc+0x7f/0xd0
 [<df88d20f>] acm_read_bulk+0xbf/0x140 [cdc_acm]
 [<c023af59>] usb_hcd_giveback_urb+0x29/0x50
 [<c0248585>] dl_done_list+0xd5/0xe0
 [<c0248ea0>] ohci_irq+0xe0/0x150
 [<c023afb6>] usb_hcd_irq+0x36/0x60
 [<c010a9ca>] handle_IRQ_event+0x3a/0x70
 [<c010acb1>] do_IRQ+0x71/0xf0
 [<c010920c>] common_interrupt+0x18/0x20

