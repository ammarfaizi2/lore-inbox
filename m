Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbVLIP0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVLIP0r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVLIP0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:26:47 -0500
Received: from pin.if.uz.zgora.pl ([212.109.128.251]:52680 "EHLO
	pin.if.uz.zgora.pl") by vger.kernel.org with ESMTP id S932329AbVLIP0p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:26:45 -0500
Message-ID: <4399B195.9050801@pin.if.uz.zgora.pl>
Date: Fri, 09 Dec 2005 17:32:21 +0100
From: Jacek Luczak <difrost@pin.if.uz.zgora.pl>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.15-rc5 and Alsa 1.0.10
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I'm using now 2.6.15-rc5 kernel with latest Alsa 1.0.10 and I received a 
lot of 'bad page state at free_hot_cold_page' (see example below) 
messages. Is this kernel or alsa error?

System:
Slackware Linux, GCC 3.4.4, Binutils 2.16.1.
CPU: Pentium 4 3Ghz HT
Sound card: CMI9880 (HDA)

Regards

	Jacek Luczak

---------------

Dec  9 16:53:20 slawek kernel: Bad page state at free_hot_cold_page (in 
process 'xmms', page c12da9c0)
Dec  9 16:53:20 slawek kernel: flags:0x80000414 mapping:00000000 
mapcount:0 count:0
Dec  9 16:53:20 slawek kernel: Backtrace:
Dec  9 16:53:20 slawek kernel:  [<c013f2de>] bad_page+0x84/0xbc
Dec  9 16:53:20 slawek kernel:  [<c013fabc>] free_hot_cold_page+0x55/0x144
Dec  9 16:53:20 slawek kernel:  [<c014032c>] __pagevec_free+0x16/0x1e
Dec  9 16:53:20 slawek kernel:  [<c0145e31>] release_pages+0x112/0x16b
Dec  9 16:53:20 slawek kernel:  [<c01526a1>] 
free_pages_and_swap_cache+0x5d/0x83
Dec  9 16:53:20 slawek kernel:  [<c014e9c4>] unmap_region+0x122/0x138
Dec  9 16:53:20 slawek kernel:  [<c014eca7>] do_munmap+0x10f/0x179
Dec  9 16:53:20 slawek kernel:  [<c014ed5b>] sys_munmap+0x4a/0x6b
Dec  9 16:53:20 slawek kernel:  [<c0102de9>] syscall_call+0x7/0xb
Dec  9 16:53:20 slawek kernel: Trying to fix it up, but a reboot is needed
Dec  9 16:53:20 slawek kernel: Bad page state at free_hot_cold_page (in 
process 'xmms', page c12da9a0)
Dec  9 16:53:20 slawek kernel: flags:0x80000414 mapping:00000000 
mapcount:0 count:0
Dec  9 16:53:20 slawek kernel: Backtrace:
Dec  9 16:53:20 slawek kernel:  [<c013f2de>] bad_page+0x84/0xbc
Dec  9 16:53:20 slawek kernel:  [<c013fabc>] free_hot_cold_page+0x55/0x144
Dec  9 16:53:20 slawek kernel:  [<c014032c>] __pagevec_free+0x16/0x1e
Dec  9 16:53:20 slawek kernel:  [<c0145e31>] release_pages+0x112/0x16b
Dec  9 16:53:20 slawek kernel:  [<c01526a1>] 
free_pages_and_swap_cache+0x5d/0x83
Dec  9 16:53:20 slawek kernel:  [<c014e9c4>] unmap_region+0x122/0x138
Dec  9 16:53:20 slawek kernel:  [<c014eca7>] do_munmap+0x10f/0x179
Dec  9 16:53:20 slawek kernel:  [<c014ed5b>] sys_munmap+0x4a/0x6b
Dec  9 16:53:20 slawek kernel:  [<c0102de9>] syscall_call+0x7/0xb
Dec  9 16:53:20 slawek kernel: Trying to fix it up, but a reboot is needed
Dec  9 16:53:20 slawek kernel: Bad page state at free_hot_cold_page (in 
process 'xmms', page c12da980)
Dec  9 16:53:20 slawek kernel: flags:0x80000414 mapping:00000000 
mapcount:0 count:0
Dec  9 16:53:20 slawek kernel: Backtrace:
Dec  9 16:53:20 slawek kernel:  [<c013f2de>] bad_page+0x84/0xbc
Dec  9 16:53:20 slawek kernel:  [<c013fabc>] free_hot_cold_page+0x55/0x144
Dec  9 16:53:20 slawek kernel:  [<c014032c>] __pagevec_free+0x16/0x1e
Dec  9 16:53:20 slawek kernel:  [<c0145e31>] release_pages+0x112/0x16b
Dec  9 16:53:20 slawek kernel:  [<c01526a1>] 
free_pages_and_swap_cache+0x5d/0x83
Dec  9 16:53:20 slawek kernel:  [<c014e9c4>] unmap_region+0x122/0x138
Dec  9 16:53:20 slawek kernel:  [<c014eca7>] do_munmap+0x10f/0x179
Dec  9 16:53:20 slawek kernel:  [<c014ed5b>] sys_munmap+0x4a/0x6b
Dec  9 16:53:20 slawek kernel:  [<c0102de9>] syscall_call+0x7/0xb
Dec  9 16:53:20 slawek kernel: Trying to fix it up, but a reboot is needed
Dec  9 16:53:20 slawek kernel: Bad page state at free_hot_cold_page (in 
process 'xmms', page c12da960)
Dec  9 16:53:20 slawek kernel: flags:0x80000414 mapping:00000000 
mapcount:0 count:0
Dec  9 16:53:20 slawek kernel: Backtrace:
Dec  9 16:53:20 slawek kernel:  [<c013f2de>] bad_page+0x84/0xbc
Dec  9 16:53:20 slawek kernel:  [<c013fabc>] free_hot_cold_page+0x55/0x144
Dec  9 16:53:20 slawek kernel:  [<c014032c>] __pagevec_free+0x16/0x1e
Dec  9 16:53:20 slawek kernel:  [<c0145e31>] release_pages+0x112/0x16b
Dec  9 16:53:20 slawek kernel:  [<c01526a1>] 
free_pages_and_swap_cache+0x5d/0x83
Dec  9 16:53:20 slawek kernel:  [<c014e9c4>] unmap_region+0x122/0x138
Dec  9 16:53:20 slawek kernel:  [<c014eca7>] do_munmap+0x10f/0x179
Dec  9 16:53:20 slawek kernel:  [<c014ed5b>] sys_munmap+0x4a/0x6b
Dec  9 16:53:20 slawek kernel:  [<c0102de9>] syscall_call+0x7/0xb
Dec  9 16:53:20 slawek kernel: Trying to fix it up, but a reboot is needed
Dec  9 16:53:20 slawek kernel: Bad page state at free_hot_cold_page (in 
process 'xmms', page c12da940)
Dec  9 16:53:20 slawek kernel: flags:0x80000414 mapping:00000000 
mapcount:0 count:0
Dec  9 16:53:20 slawek kernel: Backtrace:
Dec  9 16:53:20 slawek kernel:  [<c013f2de>] bad_page+0x84/0xbc
Dec  9 16:53:20 slawek kernel:  [<c013fabc>] free_hot_cold_page+0x55/0x144
Dec  9 16:53:20 slawek kernel:  [<c014032c>] __pagevec_free+0x16/0x1e
Dec  9 16:53:20 slawek kernel:  [<c0145e31>] release_pages+0x112/0x16b
Dec  9 16:53:20 slawek kernel:  [<c01526a1>] 
free_pages_and_swap_cache+0x5d/0x83
Dec  9 16:53:20 slawek kernel:  [<c014e9c4>] unmap_region+0x122/0x138
Dec  9 16:53:20 slawek kernel:  [<c014eca7>] do_munmap+0x10f/0x179
Dec  9 16:53:20 slawek kernel:  [<c014ed5b>] sys_munmap+0x4a/0x6b
Dec  9 16:53:20 slawek kernel:  [<c0102de9>] syscall_call+0x7/0xb
Dec  9 16:53:20 slawek kernel: Trying to fix it up, but a reboot is needed
Dec  9 16:53:20 slawek kernel: Bad page state at free_hot_cold_page (in 
process 'xmms', page c12da920)
Dec  9 16:53:20 slawek kernel: flags:0x80000414 mapping:00000000 
mapcount:0 count:0
Dec  9 16:53:20 slawek kernel: Backtrace:
Dec  9 16:53:20 slawek kernel:  [<c013f2de>] bad_page+0x84/0xbc
Dec  9 16:53:20 slawek kernel:  [<c013fabc>] free_hot_cold_page+0x55/0x144
Dec  9 16:53:20 slawek kernel:  [<c014032c>] __pagevec_free+0x16/0x1e
Dec  9 16:53:20 slawek kernel:  [<c0145e31>] release_pages+0x112/0x16b
Dec  9 16:53:20 slawek kernel:  [<c01526a1>] 
free_pages_and_swap_cache+0x5d/0x83
Dec  9 16:53:20 slawek kernel:  [<c014e9c4>] unmap_region+0x122/0x138
Dec  9 16:53:20 slawek kernel:  [<c014eca7>] do_munmap+0x10f/0x179
Dec  9 16:53:20 slawek kernel:  [<c014ed5b>] sys_munmap+0x4a/0x6b
Dec  9 16:53:20 slawek kernel:  [<c0102de9>] syscall_call+0x7/0xb
Dec  9 16:53:20 slawek kernel: Trying to fix it up, but a reboot is needed
Dec  9 16:53:20 slawek kernel: Bad page state at free_hot_cold_page (in 
process 'xmms', page c12da900)
Dec  9 16:53:20 slawek kernel: flags:0x80000414 mapping:00000000 
mapcount:0 count:0
Dec  9 16:53:20 slawek kernel: Backtrace:
Dec  9 16:53:20 slawek kernel:  [<c013f2de>] bad_page+0x84/0xbc
Dec  9 16:53:20 slawek kernel:  [<c013fabc>] free_hot_cold_page+0x55/0x144
Dec  9 16:53:20 slawek kernel:  [<c014032c>] __pagevec_free+0x16/0x1e
Dec  9 16:53:20 slawek kernel:  [<c0145e31>] release_pages+0x112/0x16b
Dec  9 16:53:20 slawek kernel:  [<c01526a1>] 
free_pages_and_swap_cache+0x5d/0x83
Dec  9 16:53:20 slawek kernel:  [<c014e9c4>] unmap_region+0x122/0x138
Dec  9 16:53:20 slawek kernel:  [<c014eca7>] do_munmap+0x10f/0x179
Dec  9 16:53:21 slawek kernel:  [<c014ed5b>] sys_munmap+0x4a/0x6b
Dec  9 16:53:21 slawek kernel:  [<c0102de9>] syscall_call+0x7/0xb
Dec  9 16:53:21 slawek kernel: Trying to fix it up, but a reboot is needed
Dec  9 16:53:21 slawek kernel: Bad page state at free_hot_cold_page (in 
process 'xmms', page c12da8e0)
Dec  9 16:53:21 slawek kernel: flags:0x80000414 mapping:00000000 
mapcount:0 count:0
Dec  9 16:53:21 slawek kernel: Backtrace:
Dec  9 16:53:21 slawek kernel:  [<c013f2de>] bad_page+0x84/0xbc
Dec  9 16:53:21 slawek kernel:  [<c013fabc>] free_hot_cold_page+0x55/0x144
Dec  9 16:53:21 slawek kernel:  [<c014032c>] __pagevec_free+0x16/0x1e
Dec  9 16:53:21 slawek kernel:  [<c0145e31>] release_pages+0x112/0x16b
Dec  9 16:53:21 slawek kernel:  [<c01526a1>] 
free_pages_and_swap_cache+0x5d/0x83
Dec  9 16:53:21 slawek kernel:  [<c014e9c4>] unmap_region+0x122/0x138
Dec  9 16:53:21 slawek kernel:  [<c014eca7>] do_munmap+0x10f/0x179
Dec  9 16:53:21 slawek kernel:  [<c014ed5b>] sys_munmap+0x4a/0x6b
Dec  9 16:53:21 slawek kernel:  [<c0102de9>] syscall_call+0x7/0xb
Dec  9 16:53:21 slawek kernel: Trying to fix it up, but a reboot is needed
