Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752273AbWJ1NPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbWJ1NPY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 09:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752305AbWJ1NPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 09:15:24 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:24716 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752273AbWJ1NPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 09:15:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Wb/NA9CmXIuHrHUW6MSaOMBJg/nZj6504AN72gUywMozPJfD2A7ybt43iSmpQiNudio4EriarF4T3w5YeqCN8WjsnS09T/5fDKvFK+ANjrsNRMASWBigog9wIx1Os+hcsndFfuMpEyPnKmYlDvC+e2PZraZy7XyyTrXCCNwirgc=
Message-ID: <5a4c581d0610280615m588f01f4m34095cba25cfb30d@mail.gmail.com>
Date: Sat, 28 Oct 2006 15:15:22 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: 2.6.19-rc2 DWARF unwinder stuck ehci_iaa_watchdog
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Non-fatal trace coming from my K7-800 running FC5
 with a 2.6.19-rc2 kernel (which will soon be rebooted
 into 2.6.19-rc3-git4):

[73003.806189] BUG: warning at drivers/usb/host/ehci-hcd.c:274/ehci_iaa_watchdog
()
[73003.807155]  [<c0103037>] dump_trace+0x64/0x1cd
[73003.807511]  [<c01031b2>] show_trace_log_lvl+0x12/0x25
[73003.807889]  [<c01037b9>] show_trace+0xd/0x10
[73003.808216]  [<c0103800>] dump_stack+0x19/0x1b
[73003.808549]  [<e486ddbb>] ehci_iaa_watchdog+0x35/0x67 [ehci_hcd]
[73003.808990]  [<c01196a5>] run_timer_softirq+0xed/0x145
[73003.809500]  [<c0116d8f>] __do_softirq+0x55/0xb0
[73003.809949]  [<c0104739>] do_softirq+0x58/0xbd
[73003.810287]  [<c0116d2e>] irq_exit+0x3f/0x4b
[73003.810712]  [<c0104854>] do_IRQ+0xb6/0xce
[73003.811027]  [<c0102bf5>] common_interrupt+0x25/0x2c
[73003.811384] DWARF2 unwinder stuck at common_interrupt+0x25/0x2c
[73003.811759]
[73003.811857] Leftover inexact backtrace:
[73003.811861]
[73003.812199]  [<c010eda3>] __wake_up+0x31/0x3b
[73003.812501]  [<c02f81d6>] unix_write_space+0x4b/0x7a
[73003.812847]  [<c02a74e6>] sock_wfree+0x26/0x3a
[73003.813152]  [<c02a89fc>] __kfree_skb+0x8c/0xaf
[73003.813459]  [<c02a8a47>] kfree_skb+0x28/0x2a
[73003.813754]  [<c02f6dc4>] unix_stream_recvmsg+0x352/0x443
[73003.814115]  [<c02a3c6f>] sock_aio_read+0xd2/0xe0
[73003.814633]  [<c014b2d0>] do_sync_read+0xae/0xec
[73003.815124]  [<c014ba75>] vfs_read+0x9b/0x136
[73003.815589]  [<c014be30>] sys_read+0x3b/0x60
[73003.816048]  [<c0102989>] sysenter_past_esp+0x56/0x8d
[73003.816555]  =======================

Since I found no googlable reference to this, I thought
 I'd just post it... thanks, ciao,

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
