Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTDHRzT (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 13:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTDHRzS (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 13:55:18 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:7916 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S262000AbTDHRzL (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 13:55:11 -0400
From: Balram Adlakha <b_adlakha@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: *  2.5.67 sleep function from illegal context
Date: Tue, 8 Apr 2003 23:40:06 +0000
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304082340.06746.b_adlakha@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this repeatedly each second:


Debug: sleeping function called from illegal context at mm/slab.c:1658

Call Trace:
  [<c0117459>] __might_sleep+0x5f/0x72
  [<c0136b93>] kmalloc+0x88/0x8f
  [<c02583c7>] accel_cursor+0xd5/0x2f8
  [<c02587db>] fb_vbl_handler+0x82/0x9d
  [<c0115ecb>] scheduler_tick+0x2d9/0x2de
  [<c0120b89>] update_process_times+0x46/0x50
  [<c0256edc>] cursor_timer_handler+0x0/0x3d
  [<c0256efd>] cursor_timer_handler+0x21/0x3d
  [<c0120c3d>] run_timer_softirq+0x90/0x170
  [<c010e577>] timer_interrupt+0x56/0x119
  [<c011d065>] do_softirq+0xa1/0xa3
  [<c010abf6>] do_IRQ+0x10e/0x12b
  [<c0109320>] common_interrupt+0x18/0x20


It doesn't happen immediately after booting, but I saw it after shutting down 
X.
-- 


His philosophy was a mixture of three famous schools -- the Cynics, the 
Stoics and the Epicureans -- and summed up all three of them in his 
famous phrase, "You can't trust any bugger further than you can throw 
him, and there's nothing you can do about it, so let's have a drink."

