Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbTLGR6p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 12:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264467AbTLGR6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 12:58:45 -0500
Received: from cafe.hardrock.org ([142.179.182.80]:14209 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S264464AbTLGR6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 12:58:41 -0500
Date: Sun, 7 Dec 2003 10:58:38 -0700 (MST)
From: James Bourne <jbourne@hardrock.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.22-uv3 patch set released
Message-ID: <Pine.LNX.4.51.0312071056350.2796@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
The Update Version patchset is a set of patches which include only fatal
compile/runtime bug fixes and security updates for the current kernel
version.  This patch set can be used in production environments for those
who wish to run 2.4.22, but do not use vendor kernels and at the same time
require patches which add to the stability of the current release kernel
version.  This is a patch set only, it does not include kernel source.

Current version is 2.4.22-uv3 and adds the do_brk() security patch.

The complete URL to the patch set is
http://www.hardrock.org/kernel/current-updates/linux-2.4.22-updates.patch

Individual patches can be viewed and downloaded from
http://www.hardrock.org/kernel/current-updates/

This patch set only contains and will only contain security updates and
fixes for the latest kernel version.  Each individual patch contains text
WRT the patch itself and the creator of the patch, I will try to keep doing
that as standard reference for the complete collection.

Please send bug reports to jbourne@hardrock.org and CC
linux-kernel@vger.kernel.org.

Patch specifics are:
linux-2.4.22-extraversion.patch: Updated the extraversion in the Makefile

linux-2.4.22-amd64-compile.patch: Fixes broken x86-64 compilation

linux-2.4.22-amd76x_pm.c-crash.patch: Fix amd67x_pm.c crash with no chipsets
        / CONFIG_HOTPLUG

linux-2.4.22-atm-pca-200epc.patch: when clip isnt a module, the common code
        try to manipulate the module count while fails.

linux-2.4.22-hardirq-race.patch: Fix possible IRQ handling SMP race

linux-2.4.22-initrd-netboot.patch: Handle -EBUSY in mount_block_root for
        netboot

linux-2.4.22-pcwd-unload-oops.patch: This patch is from Alan Cox and fixes
        problems when pcwd driver is loaded while there is no pcwd hardware
        installed.

linux-2.4.22-usb-serial.patch: This patch from Greg K-H stops an oops
        condition within the USB Serial driver.

linux-2.4.22-acpi_po_tramp.patch: When using ACPI, sysrq-o will oops the
        kernel.  This patch from Andi Kleen fixes the condition.

linux-2.4.22-aic7xxx_osm-compile.patch: Compile fix for aic7xxx_osm when
        compiling using CONFIG_EISA and CONFIG_PCI is unset.

linux-2.4.22-do_brk.patch: Andrew Morton found an issue where there is an
        integer overflow condition in the do_brk function call of mm/mmap.c
        this patch (pulled from 2.4.23) corrects that condition.

Regards
James Bourne

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  
