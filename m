Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131418AbQL3UWC>; Sat, 30 Dec 2000 15:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135170AbQL3UVw>; Sat, 30 Dec 2000 15:21:52 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:7568 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131418AbQL3UVh>; Sat, 30 Dec 2000 15:21:37 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: modutils 2.3.23 fails with tdfx.o with test13-pre6
To: linux-kernel@vger.kernel.org
Date: Sat, 30 Dec 2000 14:50:50 -0500
Organization: me
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: KNode/0.3.3
Message-Id: <20001230195051.7580E5E0D2@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is lets it load.   The same missing symbols happen with mga as well... 
This is from a patch posted here two weeks ago:

--- linux/drivers/char/drm/drmP.old        Thu Dec 28 16:27:34 2000
+++ linux/drivers/char/drm/drmP.h        Sat Dec 23 13:57:08 2000
@@ -40,6 +40,7 @@
 #include <asm/current.h>
 #endif /* __alpha__ */
 #include <linux/config.h>
+#include <linux/modversions.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>

Not sure if this is more than a temporay fix though.

Ed Tomlinson

Frank Jacobberger wrote:

> I can't get the latest modutils to work with loading
> tdfx.o... Even went to the directory where tdfx.o resides
> and did a insmod -S tdfx.o and got the following :
> 
> BTW - test13-pre6 here
> 
> tdfx.o: unresolved symbol remap_page_range
> tdfx.o: unresolved symbol __wake_up
> tdfx.o: unresolved symbol mtrr_add
> tdfx.o: unresolved symbol __generic_copy_from_user
> tdfx.o: unresolved symbol schedule
> tdfx.o: unresolved symbol kmalloc
> tdfx.o: unresolved symbol si_meminfo
> tdfx.o: unresolved symbol create_proc_entry
> tdfx.o: unresolved symbol inter_module_put
> tdfx.o: unresolved symbol __get_free_pages
> tdfx.o: unresolved symbol boot_cpu_data
> tdfx.o: unresolved symbol inter_module_get
> tdfx.o: unresolved symbol remove_wait_queue
> tdfx.o: unresolved symbol high_memory
> tdfx.o: unresolved symbol iounmap
> tdfx.o: unresolved symbol free_pages
> tdfx.o: unresolved symbol __ioremap
> tdfx.o: unresolved symbol del_timer
> tdfx.o: unresolved symbol interruptible_sleep_on
> tdfx.o: unresolved symbol __pollwait
> tdfx.o: unresolved symbol kfree
> tdfx.o: unresolved symbol remove_proc_entry
> tdfx.o: unresolved symbol pci_find_slot
> tdfx.o: unresolved symbol kill_fasync
> tdfx.o: unresolved symbol fasync_helper
> tdfx.o: unresolved symbol add_wait_queue
> tdfx.o: unresolved symbol do_mmap_pgoff
> tdfx.o: unresolved symbol mem_map
> tdfx.o: unresolved symbol sprintf
> tdfx.o: unresolved symbol jiffies
> tdfx.o: unresolved symbol printk
> tdfx.o: unresolved symbol add_timer
> tdfx.o: unresolved symbol __generic_copy_to_user
> 
> So what gives here?
> 
> Frank
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
