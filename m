Return-Path: <linux-kernel-owner+w=401wt.eu-S932350AbWLLTti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWLLTti (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 14:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWLLTti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 14:49:38 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:32293 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932350AbWLLTti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 14:49:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gxewoG9+lqsN4gAE7J6RDzeCfJ9UVVUF7cGflmV9CLHom9wXgYOdv6XRSuu+z1m3Y7Ba78VBF3UKmwNDdjZ6PtU7KQF8OPAt403euQ+oLqFPukiVGueWGaSfRVTS3b1PH/eCGFz5hmDUYcNoh+0KKqHyhmOjE63ItuG79W9BA+I=
Message-ID: <5a4c581d0612121149h4695dd51sd9cfbef8a3ef37f1@mail.gmail.com>
Date: Tue, 12 Dec 2006 20:49:37 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.19-git19: lockdep messages on console
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very shortly after boot on my K7-800 running up-to-date FC6
 and 2.6.19-git19; didn't happen in 2.6.19-vanilla:

[   42.911439] EXT3-fs: mounted filesystem with ordered data mode.
[   43.749614] Adding 248968k swap on /dev/hda5.  Priority:-1
extents:1 across:248968k
[   43.773965] Adding 240932k swap on /dev/hdb6.  Priority:-2
extents:1 across:240932k
[   54.951190] eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1
[   56.954293] skge eth1: enabling interface
[   92.748209] cdrom: This disc doesn't have any tracks I recognize!
[  134.915521] INFO: trying to register non-static key.
[  134.915890] the code is fine but needs lockdep annotation.
[  134.916249] turning off the locking correctness validator.
[  134.916635]  [<c01032b8>] dump_trace+0x63/0x1eb
[  134.916981]  [<c010345a>] show_trace_log_lvl+0x1a/0x2f
[  134.917351]  [<c0103aec>] show_trace+0x12/0x14
[  134.917674]  [<c0103b9e>] dump_stack+0x16/0x18
[  134.917997]  [<c0129f69>] __lock_acquire+0x124/0x9d0
[  134.918365]  [<c012ab4d>] lock_acquire+0x68/0x82
[  134.918699]  [<c03191d7>] _spin_lock+0x35/0x42
[  134.919035]  [<c02c0658>] neigh_destroy+0x96/0x11a
[  134.919391]  [<c02c2481>] neigh_periodic_timer+0x105/0x157
[  134.919780]  [<c011aabc>] run_timer_softirq+0xed/0x14a
[  134.920157]  [<c0117842>] __do_softirq+0x52/0xaa
[  134.920491]  [<c0104b87>] do_softirq+0x5b/0xc8
[  134.920816]  [<c01177e4>] irq_exit+0x3c/0x48
[  134.921126]  [<c0104ca6>] do_IRQ+0xb2/0xc8
[  134.921425]  [<c0102d5a>] common_interrupt+0x2e/0x34
[  134.921785]  [<c0101670>] default_idle+0x3b/0x54
[  134.922118]  [<c010be99>] apm_cpu_idle+0x19f/0x1f4
[  134.922468]  [<c0100f86>] cpu_idle+0x41/0x6a
[  134.922778]  [<c01005b1>] rest_init+0x37/0x3a
[  134.923092]  [<c046c6d9>] start_kernel+0x2dd/0x2df
[  134.923450]  =======================

Available for patch testing. Thanks,

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
