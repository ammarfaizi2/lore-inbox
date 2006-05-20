Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWETQCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWETQCB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 12:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWETQCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 12:02:01 -0400
Received: from dvhart.com ([64.146.134.43]:55433 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751329AbWETQCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 12:02:00 -0400
Message-ID: <446F3D6D.10704@mbligh.org>
Date: Sat, 20 May 2006 09:01:49 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: 2.6.17-rc4-mm2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile error on i386 NUMA (I thought Andy already fixed this one?)
Deja Vu ...

arch/i386/kernel/srat.c: In function `get_memcfg_from_srat':
arch/i386/kernel/srat.c:273: error: parse error before "early_printk"


---------------------------------------------------


Panic on boot on 2-way PPC64
http://test.kernel.org/abat/32360/debug/console.log

Bad page state in process 'idle'
page:c0000000010c3100 flags:0x0003300000000000 mapping:0000000000000000 
mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Call Trace:
[C0000000004CBB70] [C00000000000EEE8] .show_stack+0x74/0x1b4 (unreliable)
[C0000000004CBC20] [C000000000098D04] .bad_page+0x80/0x134
[C0000000004CBCB0] [C000000000099F28] .__free_pages_ok+0x134/0x280
[C0000000004CBD70] [C00000000039C4F8] .free_all_bootmem_core+0x15c/0x320
[C0000000004CBE50] [C0000000003923AC] .mem_init+0xc0/0x294
[C0000000004CBEF0] [C000000000385700] .start_kernel+0x208/0x300
[C0000000004CBF90] [C000000000008594] .start_here_common+0x88/0x8c
Hexdump:
000: c0 00 00 00 01 0c 30 b8 00 03 30 00 00 00 00 00
010: 00 00 00 00 ff ff ff ff 00 00 00 00 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: c0 00 00 00 01 0c 30 f0 c0 00 00 00 01 0c 30 f0
040: 00 03 30 00 00 00 00 00 00 00 00 00 ff ff ff ff
050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
060: 00 00 00 00 00 00 00 00 c0 00 00 00 01 0c 31 28
070: c0 00 00 00 01 0c 31 28 00 03 30 00 00 00 00 00
080: 00 00 00 00 ff ff ff ff 00 00 00 00 00 00 00 00
090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0a0: c0 00 00 00 01 0c 31 60 c0 00 00 00 01 0c 31 60
0b0: 00 03 30 00 00 00 00 00 00 00 00 00 ff ff ff ff

-------------------------------------------------------------
