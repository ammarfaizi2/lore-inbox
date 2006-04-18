Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWDRQ7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWDRQ7G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 12:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWDRQ7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 12:59:05 -0400
Received: from dvhart.com ([64.146.134.43]:5072 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751123AbWDRQ7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 12:59:04 -0400
Message-ID: <44451AD5.9070709@mbligh.org>
Date: Tue, 18 Apr 2006 09:59:01 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: 2.6.17-rc1-mm3 dies in LTP on amd64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Runs most tests just fine, but not LTP.
-mm2 ran LTP fine.

Full log here:
http://test.kernel.org/abat/28728/debug/console.log

The trainwreck starts with:

Modules linked in:
Pid: 228, comm: kswapd0 Not tainted 2.6.17-rc1-mm3-autokern1 #1
RIP: 0010:[<ffffffff8047a8dc>] <ffffffff8047a8dc>{__sched_text_start+1852}
RSP: 0000:0000000000000000  EFLAGS: 00010046
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff805d9338
RDX: ffff8100010c5090 RSI: ffffffff805d9338 RDI: ffff8100010c5090
RBP: ffffffff805d9338 R08: 0000000000000010 R09: ffff8100e3e63d28
R10: ffff8100e3e63a88 R11: 000000000000000b R12: ffff810000011280
R13: ffff81007e186f40 R14: ffff810008003620 R15: 000002b9f81aa1c4
FS:  0000000000000000(0000) GS:ffffffff805fa000(0000) knlGS:00000000f7ea7460
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: fffffffffffffff8 CR3: 000000007174a000 CR4: 00000000000006e0
Process kswapd0 (pid: 228, threadinfo ffff8100e3e62000, task 
ffff8100010c5090)
Stack: ffffffff80578e20 ffff8100010c5090 0000000000000001 ffffffff80578f58
        0000000000000000 ffffffff80578e78 ffffffff8020b082 ffffffff80578f58
        0000000000000000 ffffffff80483520
Call Trace: <#DF> <ffffffff8020b082>{show_registers+140}
        <ffffffff8020b30b>{__die+159} <ffffffff8020b380>{die+50}
        <ffffffff8020bb46>{do_double_fault+115} 
<ffffffff8020aa61>{double_fault+125}
        <ffffffff8047a8dc>{__sched_text_start+1852} <EOE>

Code: e8 0d da d8 ff 65 48 8b 34 25 00 00 00 00 4c 8b 46 08 f0 41
