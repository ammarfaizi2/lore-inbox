Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbTDIBAu (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 21:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTDIBAu (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 21:00:50 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:4809 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261907AbTDIBAt (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 21:00:49 -0400
Date: Wed, 9 Apr 2003 02:12:12 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: opost_block sleeping in illegal context.
Message-ID: <20030409011212.GB25834@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not seen this one before.. 2.5.67

		Dave


Debug: sleeping function called from illegal context at include/linux/rwsem.h:43
Call Trace:
 [<c0120d61>] __might_sleep+0x61/0x80
 [<c011c3af>] do_page_fault+0x19f/0x4e4
 [<c013104b>] specific_send_sig_info+0xeb/0x160
 [<c03291f5>] opost_block+0xf5/0x1c0
 [<c011c66d>] do_page_fault+0x45d/0x4e4
 [<c011c210>] do_page_fault+0x0/0x4e4
 [<c010b41d>] error_code+0x2d/0x40
 [<c02e66d6>] __copy_to_user_ll+0x26/0x50
 [<c010e967>] save_v86_state+0x1a7/0x1c0
 [<c011c210>] do_page_fault+0x0/0x4e4
 [<c010a4b6>] work_notifysig_v86+0x6/0x20
 [<c010a457>] syscall_call+0x7/0xb


