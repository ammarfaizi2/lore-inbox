Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263249AbTCYTxU>; Tue, 25 Mar 2003 14:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263259AbTCYTxU>; Tue, 25 Mar 2003 14:53:20 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:26015 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263249AbTCYTxT>; Tue, 25 Mar 2003 14:53:19 -0500
Date: Tue, 25 Mar 2003 11:54:36 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 501] New: sleeping function in illegal context 
Message-ID: <1347610000.1048622076@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Distribution: Debian sarge
Hardware Environment: IBM Thinkpad 600

Problem Description: 
Mar 25 20:09:21 gswi1164 kernel: Call Trace:
Mar 25 20:09:21 gswi1164 kernel:  [__might_sleep+84/92] __might_sleep+0x54/0x5c
Mar 25 20:09:21 gswi1164 kernel:  [kmalloc+97/372] kmalloc+0x61/0x174
Mar 25 20:09:21 gswi1164 kernel:  [accel_cursor+224/708] accel_cursor+0xe0/0x2c4
Mar 25 20:09:21 gswi1164 kernel:  [try_to_wake_up+377/532] try_to_wake_up+0x179/0x214
Mar 25 20:09:21 gswi1164 kernel:  [fb_vbl_handler+120/148] fb_vbl_handler+0x78/0x94
Mar 25 20:09:21 gswi1164 kernel:  [add_timer+81/136] add_timer+0x51/0x88
Mar 25 20:09:21 gswi1164 kernel:  [update_process_times+44/56] update_process_times+0x2c/0x38
Mar 25 20:09:21 gswi1164 kernel:  [update_wall_time+14/56] update_wall_time+0xe/0x38
Mar 25 20:09:21 gswi1164 kernel:  [cursor_timer_handler+16/44] cursor_timer_handler+0x10/0x2c
Mar 25 20:09:21 gswi1164 kernel:  [run_timer_softirq+254/312] run_timer_softirq+0xfe/0x138
Mar 25 20:09:21 gswi1164 kernel:  [cursor_timer_handler+0/44] cursor_timer_handler+0x0/0x2c
Mar 25 20:09:21 gswi1164 kernel:  [do_softirq+81/176] do_softirq+0x51/0xb0
Mar 25 20:09:21 gswi1164 kernel:  [do_IRQ+276/304] do_IRQ+0x114/0x130
Mar 25 20:09:21 gswi1164 kernel:  [default_idle+0/52] default_idle+0x0/0x34
Mar 25 20:09:21 gswi1164 kernel:  [default_idle+0/52] default_idle+0x0/0x34
Mar 25 20:09:21 gswi1164 kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Mar 25 20:09:21 gswi1164 kernel:  [default_idle+0/52] default_idle+0x0/0x34
Mar 25 20:09:21 gswi1164 kernel:  [default_idle+0/52] default_idle+0x0/0x34
Mar 25 20:09:21 gswi1164 kernel:  [default_idle+38/52] default_idle+0x26/0x34
Mar 25 20:09:21 gswi1164 kernel:  [cpu_idle+53/68] cpu_idle+0x35/0x44
Mar 25 20:09:21 gswi1164 kernel:  [_stext+0/92] rest_init+0x0/0x5c
Mar 25 20:09:21 gswi1164 kernel:  [_stext+85/92] rest_init+0x55/0x5c
Mar 25 20:09:21 gswi1164 kernel:

This is sometimes when I stopped typing for a few seconds.


