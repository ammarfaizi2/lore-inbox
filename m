Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131434AbQLRJWX>; Mon, 18 Dec 2000 04:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131571AbQLRJWN>; Mon, 18 Dec 2000 04:22:13 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:1920 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S131434AbQLRJV7>;
	Mon, 18 Dec 2000 04:21:59 -0500
Message-ID: <3A3DD010.225F721C@pobox.com>
Date: Mon, 18 Dec 2000 00:51:29 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting Group
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Niels Kristian Bech Jensen <nkbj@image.dk>
CC: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: test13-pre3 woes
In-Reply-To: <Pine.LNX.4.30.0012180702380.16423-100000@hafnium.nkbj.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Niels Kristian Bech Jensen wrote:

> Does this patch fix your problem?
>
> --- test13-pre3/drivers/char/Makefile   Mon Dec 18 01:21:31 2000
> +++ linux/drivers/char/Makefile Mon Dec 18 06:58:06 2000
> @@ -16,6 +16,8 @@
>
>  O_TARGET := char.o
>
> +mod-subdirs := drm
> +
>  obj-y   += tty_io.o n_tty.o tty_ioctl.o mem.o raw.o pty.o misc.o random.o
>

Some progress anyway;

The module now compiles and gets installed -

Unfortunately, attempting to load it does not go well:

/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 remap_page_range
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 __wake_up
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 mtrr_add
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 __generic_copy_from_user
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 schedule
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 kmalloc
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 si_meminfo
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 create_proc_entry
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 inter_module_put
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 __get_free_pages
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 boot_cpu_data
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 inter_module_get
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 remove_wait_queue
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 high_memory
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 iounmap
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 free_pages
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 __ioremap
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 del_timer
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 interruptible_sleep_on
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 __pollwait
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 kfree
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 remove_proc_entry
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 pci_find_slot/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o:
unresolved symbol
 kill_fasync
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 fasync_helper
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 add_wait_queue
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 do_mmap_pgoff
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 mem_map
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 sprintf
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 jiffies
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 printk
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 add_timer
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: unresolved
symbol
 __generic_copy_to_user
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: insmod
/lib/modul
es/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o failed
/lib/modules/2.4.0-test13-pre3/kernel/drivers/char/drm/tdfx.o: insmod tdfx
failed





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
