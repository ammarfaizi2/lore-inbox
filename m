Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbUAYPyr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 10:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbUAYPyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 10:54:47 -0500
Received: from mail.netbeat.de ([193.254.185.26]:30359 "HELO mail.netbeat.de")
	by vger.kernel.org with SMTP id S264428AbUAYPyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 10:54:46 -0500
Subject: 2.6.2-rc1-mm2: sleep_on_timeout with parport
From: Jan Ischebeck <mail@jan-ischebeck.de>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040123103959.4dcf5b58.akpm@osdl.org>
References: <1074870538.5122.9.camel@JHome.uni-bonn.de>
	 <20040123103959.4dcf5b58.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1075046073.26778.3.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 25 Jan 2004 16:55:01 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to print without switching the printer on I got the following
error messages.

lp0 out of paper
Badness in interruptible_sleep_on_timeout at kernel/sched.c:2245
Call Trace:
 [<c0121a6f>] interruptible_sleep_on_timeout+0x10f/0x120
 [<c0121500>] default_wake_function+0x0/0x20
 [<e0a34e5f>] parport_release+0x7f/0x140 [parport]
 [<e0a10180>] lp_error+0x40/0xc0 [lp]
 [<e0a10289>] lp_check_status+0x89/0xd0 [lp]
 [<e0a10318>] lp_wait_ready+0x48/0x80 [lp]
 [<e0a1066a>] lp_write+0x31a/0x3e0 [lp]
 [<e0a10350>] lp_write+0x0/0x3e0 [lp]
 [<c015bee8>] vfs_write+0xb8/0x130
 [<c02f298c>] common_interrupt+0x18/0x20
 [<c015c012>] sys_write+0x42/0x70
 [<c02f1fa7>] syscall_call+0x7/0xb


-- 
Jan Ischebeck <mail@jan-ischebeck.de>

