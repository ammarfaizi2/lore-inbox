Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbSLHKjd>; Sun, 8 Dec 2002 05:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbSLHKjc>; Sun, 8 Dec 2002 05:39:32 -0500
Received: from p3EE3AD9B.dip.t-dialin.net ([62.227.173.155]:1028 "EHLO
	salem.getuid.de") by vger.kernel.org with ESMTP id <S265339AbSLHKja>;
	Sun, 8 Dec 2002 05:39:30 -0500
Date: Sun, 8 Dec 2002 10:28:23 +0100
From: Christian Kurz <lk@getuid.de>
To: linux-kernel@vger.kernel.org
Subject: Unresolved symbols in 2.5.47
Message-ID: <20021208092822.GB13532@salem.getuid.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Mail-Copies-To: never
Organization: True happiness will be found only in true love.
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when trying to compile kernel 2.5.47 for my system, I included the hisax
driver as a module (hisax.o). At the end of building the kernel, I found
a lot of unresolved symbols making it impossible to use hisax as module.
I already contacted Karsten Keil and Kai Germaschweski (the ISDN
maintainers) about at least one failing symbol and it's also been
reported to this list in November before. But since I didn't found any
fix for them during a quick look at the kernel source at
linux.bkbits.net, I'll post the list of unresolved symbols here:

[salem:/usr/src]-16> nm /lib/modules/2.5.47/kernel/drivers/isdn/hisax/hisax.o|grep "  U"
         U __check_region
         U __const_udelay
         U __kfree_skb
         U __release_region
         U __request_region
         U __this_module
         U __wake_up
         U _ctype
         U add_timer
         U alloc_skb
         U copy_to_user
         U cpu_raise_softirq
         U del_timer
         U free_irq
         U get_random_bytes
         U interruptible_sleep_on
         U ioport_resource
         U isapnp_present
         U jiffies
         U kfree
         U kmalloc
         U kstat__per_cpu
         U pci_bus_read_config_byte
         U pci_devices
         U pci_enable_device
         U pci_find_device
         U preempt_schedule
         U printk
         U register_isdn
         U request_irq
         U schedule_timeout
         U schedule_work
         U skb_clone
         U skb_over_panic
         U skb_under_panic
         U softnet_data
         U sprintf
         U try_inc_mod_count
         U vsprintf

I would appreciate if someone would be able to fix this, so that it's
possible to use kernel 2.5.47 (or maybe newer kernels) on systems
depending on ISDN for their internet connection.

Thanks
Christian
-- 
Life's most urgent question is: what are you doing for others?
Martin Luther King, Jr.
