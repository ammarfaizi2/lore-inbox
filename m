Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264766AbUDWJCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264766AbUDWJCl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 05:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbUDWJCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 05:02:41 -0400
Received: from painless.aaisp.net.uk ([217.169.20.17]:3530 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S264766AbUDWJCh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 05:02:37 -0400
Message-ID: <4088DDC0.8080701@rgadsdon2.giointernet.co.uk>
Date: Fri, 23 Apr 2004 10:11:28 +0100
From: Robert Gadsdon <robert@rgadsdon2.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7b) Gecko/20040320
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.6-rc2 - debug/trace messages
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following 'debug' traces from 2.6.6-rc2:

-------------------------------------------------------------------
Debug: sleeping function called from invalid context at mm/slab.c:1954
in_atomic():1, irqs_disabled():1
Call Trace:
  [<c011bf87>] __might_sleep+0xb7/0xe0
  [<c014335f>] __kmalloc+0x9f/0xb0
  [<f890dc84>] alloc_dma_rcv_ctx+0x64/0x3f0 [ohci1394]
  [<c014b2a4>] do_no_page+0x204/0x3d0
  [<f890b1ec>] ohci_devctl+0x3cc/0x640 [ohci1394]
  [<c014b6a6>] handle_mm_fault+0x106/0x1b0
  [<f89e8399>] hpsb_listen_channel+0x49/0x70 [ieee1394]
  [<f8989dbf>] handle_iso_listen+0xcf/0x1a0 [raw1394]
  [<f898ca56>] state_connected+0x116/0x2b0 [raw1394]
  [<f898cc7d>] raw1394_write+0x8d/0xe0 [raw1394]
  [<c015a678>] vfs_write+0xb8/0x130
  [<c015a7a2>] sys_write+0x42/0x70
  [<c0105dd9>] sysenter_past_esp+0x52/0x71

Debug: sleeping function called from invalid context at 
include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():1
Call Trace:
  [<c011bf87>] __might_sleep+0xb7/0xe0
  [<c0269cf4>] dma_pool_destroy+0x24/0x140
  [<f890dbcb>] free_dma_rcv_ctx+0xcb/0x120 [ohci1394]
  [<f890b39e>] ohci_devctl+0x57e/0x640 [ohci1394]
  [<c01336e7>] unqueue_me+0x67/0xd0
  [<f89e83fc>] hpsb_unlisten_channel+0x3c/0x60 [ieee1394]
  [<f8989e53>] handle_iso_listen+0x163/0x1a0 [raw1394]
  [<f898ca56>] state_connected+0x116/0x2b0 [raw1394]
  [<f898cc7d>] raw1394_write+0x8d/0xe0 [raw1394]
  [<c015a678>] vfs_write+0xb8/0x130
  [<c015a7a2>] sys_write+0x42/0x70
  [<c0105dd9>] sysenter_past_esp+0x52/0x71

Debug: sleeping function called from invalid context at 
include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():1
Call Trace:
  [<c011bf87>] __might_sleep+0xb7/0xe0
  [<c0269cf4>] dma_pool_destroy+0x24/0x140
  [<f890dbcb>] free_dma_rcv_ctx+0xcb/0x120 [ohci1394]
  [<f890b39e>] ohci_devctl+0x57e/0x640 [ohci1394]
  [<c01336e7>] unqueue_me+0x67/0xd0
  [<f89e83fc>] hpsb_unlisten_channel+0x3c/0x60 [ieee1394]
  [<f8989e53>] handle_iso_listen+0x163/0x1a0 [raw1394]
  [<f898ca56>] state_connected+0x116/0x2b0 [raw1394]
  [<f898cc7d>] raw1394_write+0x8d/0xe0 [raw1394]
  [<c015a678>] vfs_write+0xb8/0x130
  [<c015a7a2>] sys_write+0x42/0x70
  [<c0105dd9>] sysenter_past_esp+0x52/0x71
--------------------------------------------------------

The recent usb_uhci patch had been applied (to make Clie/visor sync work)

Apart from these debug/trace messages (which have not - so far - been 
repeated), the system appears to be working fine...

.............................
Robert Gadsdon
.............................
