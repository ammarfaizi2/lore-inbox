Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbUBWPYl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 10:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUBWPYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 10:24:41 -0500
Received: from mail.artsci.net ([64.29.142.100]:34065 "EHLO jadsystems.com")
	by vger.kernel.org with ESMTP id S261921AbUBWPYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 10:24:38 -0500
Date: Mon, 23 Feb 2004 07:23:25 -0800
Message-Id: <200402230723.AA639631576@jadsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Jim Deas" <jdeas0648@jadsystems.com>
Reply-To: <jdeas0648@jadsystems.com>
To: <linux-kernel@vger.kernel.org>
Subject: -1 Unknown symbol in module
X-Mailer: <IMail v6.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to recompile a 2.4.x driver to 2.6.2.
After rebuilding the make system to use the kernel make file I was able to compile a short test module to test the system.
I then tried my real drive and got the following error when trying to load my module
I.E. tried
'insmod mymodule.ko' returned '-1 Unknown symbol in module'

I have included the module.mod.c but most important to me is where can I cross check the module symbols against the kernel to find this symbol error?

Thanks,
JD

-----------------------------------------
#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>
 
MODULE_INFO(vermagic, VERMAGIC_STRING);
 
static const struct modversion_info ____versions[]
__attribute_used__
__attribute__((section("__versions"))) = {
        { 0x12fe0ca3, "struct_module" },
        { 0x1a1a4f09, "__request_region" },
        { 0x7da8156e, "__kmalloc" },
        { 0xd6ee688f, "vmalloc" },
        { 0x41b88718, "malloc_sizes" },
        { 0xb8cd33b5, "remove_proc_entry" },
        { 0xeae3dfd6, "__const_udelay" },
        { 0x1d26aa98, "sprintf" },
        { 0xda02d67, "jiffies" },
        { 0xd533bec7, "__might_sleep" },
        { 0xc280a525, "__copy_from_user_ll" },
        { 0x865ebccd, "ioport_resource" },
        { 0x1b7d4074, "printk" },
        { 0xcfaa1ea9, "pci_find_device" },
        { 0xed5c73bf, "__tasklet_schedule" },
        { 0xcbf92b8b, "__down_failed_trylock" },
        { 0x28c3bbf5, "__down_failed_interruptible" },
        { 0xf1d0cdab, "__check_region" },
        { 0x306c0d42, "kmem_cache_alloc" },
        { 0xab600421, "probe_irq_off" },
        { 0x3762cb6e, "ioremap_nocache" },
        { 0x6050990a, "schedule_delayed_work" },
        { 0x26e96637, "request_irq" },
        { 0x4292364c, "schedule" },
        { 0x32dd738e, "register_chrdev" },
        { 0x9c72f3ff, "create_proc_entry" },
        { 0xd49501d4, "__release_region" },
        { 0xbfeef0a1, "__wake_up" },
        { 0xb121390a, "probe_irq_on" },
        { 0x37a0cba, "kfree" },
        { 0x5fb196d4, "iounmap" },
        { 0xc192d491, "unregister_chrdev" },
        { 0xd22b546, "__up_wakeup" },
        { 0xaac07a8f, "pci_enable_device" },
        { 0xf20dabd8, "free_irq" },
};
 
static const char __module_depends[]
__attribute_used__
__attribute__((section(".modinfo"))) =
"depends=";


