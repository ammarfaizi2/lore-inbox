Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTEKRCI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 13:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbTEKRCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 13:02:08 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:62969 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261769AbTEKRCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 13:02:07 -0400
Date: Sun, 11 May 2003 13:12:11 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: PROBLEM: ide_floppy and 2.5.69
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305111314_MC3-1-3860-9546@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:

> hde: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
>  hde: hde1
>  hde: hde1
> Badness in kobject_register at lib/kobject.c:293
> Call Trace:
>  [<c020c968>] kobject_register+0x58/0x70
>  [<c017c747>] register_disk+0x137/0x140
>  [<c026609e>] add_disk+0x4e/0x60
>  [<c0266020>] exact_match+0x0/0x10
>  [<c0266030>] exact_lock+0x0/0x20
>  [<c02a6def>] idefloppy_attach+0x16f/0x1a0
>  [<c029b49f>] ata_attach+0x4f/0x120
>  [<c029c3b5>] ide_register_driver+0xf5/0x110
>  [<c02a6e3b>] idefloppy_init+0x1b/0x60
>  [<c046272c>] do_initcalls+0x2c/0xa0
>  [<c01288df>] init_workqueues+0xf/0x30
>  [<c01050a3>] init+0x33/0x190
>  [<c0105070>] init+0x0/0x190
>  [<c010707d>] kernel_thread_helper+0x5/0x18


  It is trying to register the object "hde1" twice and getting
-EEXIST on the second try.

  I reported this to the list over a month ago...


