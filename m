Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270851AbTHKBxz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 21:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270852AbTHKBxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 21:53:55 -0400
Received: from pan.togami.com ([66.139.75.105]:40132 "EHLO pan.mplug.org")
	by vger.kernel.org with ESMTP id S270851AbTHKBxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 21:53:54 -0400
Subject: 2.6-test3 compusa USB optical mouse
From: Warren Togami <warren@togami.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1060565776.2888.3.camel@laptop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Sun, 10 Aug 2003 15:53:52 -1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I normally use Logitech optical USB mice in Linux.  I bought a "CompUSA
Optical USB Notebook Mouse" for $14 and the following happens in dmesg
in kernel-2.6.0-test3.

Known bug?  Should I Bugzilla this?

hub 1-1:0: debounce: port 2: delay 100ms stable 4 status 0x301
hub 1-1:0: new USB device on port 2, assigned address 8
drivers/usb/core/message.c: selecting invalid configuration 0
usb 1-1.2: failed to set device 8 default configuration (error=-22)
hub 1-1:0: new USB device on port 2, assigned address 9
drivers/usb/core/message.c: selecting invalid configuration 0
usb 1-1.2: failed to set device 9 default configuration (error=-22)
Debug: sleeping function called from invalid context at
include/asm/uaccess.h:473
Call Trace:
 [<c011ab9b>] __might_sleep+0x5b/0x80
 [<c010cc66>] save_v86_state+0x66/0x1f0
 [<c010d737>] handle_vm86_fault+0xa7/0x8c0
 [<c01519fb>] do_sync_write+0x8b/0xc0
 [<c01a1e15>] inode_has_perm+0x65/0xa0
 [<c010b820>] do_general_protection+0x0/0xa0
 [<c010aae5>] error_code+0x2d/0x38
 [<c010a93b>] syscall_call+0x7/0xb


