Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265047AbUD3DUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265047AbUD3DUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 23:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265048AbUD3DUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 23:20:32 -0400
Received: from mail.ict.ac.cn ([159.226.39.4]:12930 "HELO mail.ict.ac.cn")
	by vger.kernel.org with SMTP id S265047AbUD3DU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 23:20:29 -0400
From: "zhangjg" <zhangjg@ict.ac.cn>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG] kernel 2.4.18 kupdate BUG report 
Date: Tue, 4 May 2004 11:19:47 +0800
Message-ID: <000001c43186$a7630680$060f0a0a@zhangjg>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I running redhat 8.0(2.4.18-14 kernel), read/write a big file on a
raid0 device(3ware, ide disk), the kernel panic as next, and the total
disk io is about 5-10MB.
Sep 18 18:04:29 xxxx kernel:EIP is at_make_request [kernel] 0xa2
Sep 18 18:04:29 xxxx kernel:Eax: 000020000 ebx: 00000001 ecx: f0515200
edx: 00004000 esi: 00000008 edi: 2b23aboo ebp: 00000001: esp: c36b5e78
Sep 18 18:04:29 xxxx kernel:Process kupdated (pid: 6) stackpage:
c36b5000
Sep 18 18:04:29 xxxx kernel: Stack: c022d850 c022db02 000002b4 00000008
f2404720 031d9000 00000000 ca1196c0 
Sep 18 18:04:29 xxxx kernel:        00000001 00000008 f7144970 f7144800
f70a0000 00000000 00004000 ca11ae48 
Sep 18 18:04:29 xxxx kernel:        ca1189e0 0841ae40 002007d0 00000000
00000000 002007d0 00000202 c017f2c0 
Sep 18 18:04:29 xxxx kernel: Call Trace: [submit_bh+88/116]
[write_locked_buffers+30/40] [sync_old_buffers+112/168] 
Sep 18 18:04:29 xxxx kernel: Call Trace: [<c017f2c0>] [<c017f378>]
[<c013680a>] [<c0136936>] [<c0139e1c>] 
Sep 18 18:04:29 xxxx kernel:    [kupdate+309/316] [stext+0/100]
[stext+0/100] [kernel_thread+26/48] 
Sep 18 18:04:29 xxxx kernel:    [<c013a125>] [<c0105000>] [<c010575a>]
[<c0105763>] 
Sep 18 18:04:29 xxxx kernel: 
Sep 18 18:04:29 xxxx kernel: Code: 0f 0b 83 c4 0c 8d b4 26 00 00 00 00
8b 74 24 5c 56 8b 7c 24


