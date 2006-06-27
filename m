Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161329AbWF0VrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161329AbWF0VrH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 17:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161330AbWF0VrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 17:47:07 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:51927 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161329AbWF0VrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 17:47:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IHthNKDkMouflrrw7rt9NEwjNmsp7rkIFJ0naBwNZdvsAmRBLslDZTnNSRBLdg7x/xpCsn7vWOcZqZiQc6eYzE0s+x53Gk/xrrTqu2n0+jxLzFSXeLIM+iFJaaxYrQySveERxocIucY8lHO8qFbKvgTUKEmluSJ99QhHvwUk5bw=
Message-ID: <a44ae5cd0606271447j58ad9cdchc4728c010245df5b@mail.gmail.com>
Date: Tue, 27 Jun 2006 14:47:03 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.17-mm3 -- BUG: trying to register non-static key!
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mmc0: starting CMD0 arg 00000000 flags 00000040
BUG: trying to register non-static key!
turning off the locking correctness validator.
 [<c1003502>] show_trace_log_lvl+0x54/0xfd
 [<c1003b6a>] show_trace+0xd/0x10
 [<c1003c0e>] dump_stack+0x19/0x1b
 [<c102c0a8>] __lock_acquire+0x101/0x95e
 [<c102cbca>] lock_acquire+0x60/0x80
 [<c11fcc7b>] _spin_lock_irq+0x29/0x38
 [<c11faa0a>] wait_for_completion+0x24/0xd0
 [<f8831367>] mmc_wait_for_req+0xa2/0xaf [mmc_core]
 [<f8831539>] mmc_wait_for_cmd+0x50/0x5b [mmc_core]
 [<f883162f>] mmc_idle_cards+0x83/0xe0 [mmc_core]
 [<f8831a0e>] mmc_rescan+0x18a/0xec4 [mmc_core]
 [<c1024198>] run_workqueue+0x86/0xcb
 [<c1024711>] worker_thread+0xe1/0x114
 [<c1026ca7>] kthread+0xb0/0xdc
 [<c1001005>] kernel_thread_helper+0x5/0xb
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (0)
