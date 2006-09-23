Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWIWVH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWIWVH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 17:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWIWVH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 17:07:26 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:54498 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750885AbWIWVHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 17:07:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SHj7IHG7MNLSRr3WiXWBJlyH1Tf/3f5GTEgwpOw3HcZ6opoylHHhgpF0UyZSnxc0uG2WdK+3JzaW36FNvUl4ZM9EDt4N1/vK5a6vhrjIlyu8NUYYH4PDpGalK+LoCl9Ef2YmgwHSfoTU0cuF7tYRj8qm9xgigXjWCwUcu/t5C3M=
Message-ID: <a44ae5cd0609231407r1ab38dedu7a2ac9578c064566@mail.gmail.com>
Date: Sat, 23 Sep 2006 14:07:24 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: 2.6.18 -- ide_core: exports duplicate symbol ide_lock (owned by kernel) -- kobject_add failed for ide-disk with -EEXIST
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ide_core: exports duplicate symbol ide_lock (owned by kernel)
kobject_add failed for ide-disk with -EEXIST, don't try to register
things with the same name in the same directory.
 [<c1003e88>] show_trace_log_lvl+0x58/0x16a
 [<c1004535>] show_trace+0xd/0x10
 [<c10045d9>] dump_stack+0x19/0x1b
 [<c10b00d5>] kobject_add+0x14b/0x171
 [<c10b0205>] kobject_register+0x1c/0x34
 [<c11141c5>] bus_add_driver+0x4e/0x106
 [<c1114e17>] driver_register+0x78/0x7d
 [<f882400d>] idedisk_init+0xd/0xf [ide_disk]
 [<c1034f53>] sys_init_module+0x12cb/0x14b0
 [<c1002eab>] syscall_call+0x7/0xb
DWARF2 unwinder stuck at syscall_call+0x7/0xb
Leftover inexact backtrace:
 [<c1004535>] show_trace+0xd/0x10
 [<c10045d9>] dump_stack+0x19/0x1b
 [<c10b00d5>] kobject_add+0x14b/0x171
 [<c10b0205>] kobject_register+0x1c/0x34
 [<c11141c5>] bus_add_driver+0x4e/0x106
 [<c1114e17>] driver_register+0x78/0x7d
 [<f882400d>] idedisk_init+0xd/0xf [ide_disk]
 [<c1034f53>] sys_init_module+0x12cb/0x14b0
 [<c1002eab>] syscall_call+0x7/0xb
usb usb1: suspend_rh (auto-stop)

CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
