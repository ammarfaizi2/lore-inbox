Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262719AbSJHChI>; Mon, 7 Oct 2002 22:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262716AbSJHChI>; Mon, 7 Oct 2002 22:37:08 -0400
Received: from cliff.cse.wustl.edu ([128.252.166.5]:40952 "EHLO
	cliff.cse.wustl.edu") by vger.kernel.org with ESMTP
	id <S262719AbSJHChH>; Mon, 7 Oct 2002 22:37:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15778.17952.262307.796106@samba.doc.wustl.edu>
Date: Mon, 7 Oct 2002 21:42:40 -0500
From: Krishnakumar B <kitty@cse.wustl.edu>
To: linux-kernel@vger.kernel.org
Subject: USB call trace with Linux 2.5.40 + BK-snapshots as of 10/7/2002 13:00 CST
X-Mailer: VM 7.07 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got the following when I powered off my laptop. Normally it powers off
without problems but this time it didn't and I managed to write this down
by hand. I didn't write down the stack frame information. Don't know if
this is useful.

Debug: sleeping function called from illegal context at include/asm/semaphore.h:119

Call Trace:
     driverfs_remove_file
     device_remove_file
     pci_pool_destroy
     hcd_buffer_destroy
     usb_hcd_pci_remove
     pci_match_device
     device_shutdown
     unregister_reboot_notifier
     force_sig_info
     kill_proc_info
     notify_parent
     dput
     fput
     filp_close
     sys_close
     __up_wakeup

drivers/usb/core/hcd.c: USB bus 1 deregistered
drivers/usb/core/hcd-pci.c: usb_hcd_pci_remove 00:07.2, count != 1
Power down.

-kitty.

-- 
Krishnakumar B <kitty at cs dot wustl dot edu>
Distributed Object Computing Laboratory, Washington University in St.Louis
