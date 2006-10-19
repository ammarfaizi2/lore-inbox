Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946077AbWJSHgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946077AbWJSHgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 03:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946078AbWJSHgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 03:36:31 -0400
Received: from smtp.gromco.com ([64.90.177.54]:56259 "EHLO smtp.gromco.com")
	by vger.kernel.org with ESMTP id S1946077AbWJSHgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 03:36:31 -0400
Message-ID: <45372C5E.8060601@gromco.com>
Date: Thu, 19 Oct 2006 03:42:22 -0400
From: Vladislav Malyshkin <mal@gromco.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel-2.6.18-1.2200 trace
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a strange trace during dmesg on kernel-2.6.18-1.2200

idr_remove called for id=1 which is not allocated.
 [<c0403f10>] dump_trace+0x69/0x1af
 [<c040406e>] show_trace_log_lvl+0x18/0x2c
 [<c04045e9>] show_trace+0xf/0x11
 [<c0404673>] dump_stack+0x15/0x17
 [<c04d3fcb>] idr_remove+0xe2/0x143
 [<c051ee50>] release_dev+0x63b/0x652
 [<c051ee6e>] tty_release+0x7/0xa
 [<c0461b2e>] __fput+0xba/0x178
 [<c045f466>] filp_close+0x52/0x59
 [<c041d3b4>] put_files_struct+0x64/0xa6
 [<c041e3fe>] do_exit+0x248/0x747
 [<c041e973>] sys_exit_group+0x0/0xd
 [<f5d480e4>] 0xf5d480e4
DWARF2 unwinder stuck at 0xf5d480e4
Leftover inexact backtrace:
 [<c0426b76>] get_signal_to_deliver+0x38a/0x3b2
 [<c040243a>] do_notify_resume+0x75/0x62f
 [<c044bfc0>] __pagevec_lru_add_active+0x95/0xa0
 [<c042c814>] autoremove_wake_function+0x0/0x35
 [<c05fc113>] _spin_unlock_irq+0x5/0x7
 [<c05fa9cf>] schedule+0x529/0x585
 [<c0402e2a>] work_notifysig+0x13/0x19
 =======================
eth1: link down.
eth1: link up.

See https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=211429 for 
details of this bug.
