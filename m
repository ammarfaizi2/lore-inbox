Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWEZTBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWEZTBv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 15:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWEZTBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 15:01:51 -0400
Received: from rtr.ca ([64.26.128.89]:50586 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751290AbWEZTBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 15:01:51 -0400
Message-ID: <4477509D.1020009@rtr.ca>
Date: Fri, 26 May 2006 15:01:49 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.17-rc5-git1: potentially fatal build WARNINGS
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is from building the latest kernel on a Kubuntu Breezy system:

System is 1290 kB
Kernel: arch/i386/boot/bzImage is ready  (#1)
  Building modules, stage 2.
  MODPOST
WARNING: drivers/acpi/processor.o - Section mismatch: reference to .init.data: from .text between 'acpi_processor_power_init' (at offset 0xec7) and 'acpi_processor_cst_has_changed'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text:dmi_matched from .data between 'dmi_ids' (at offset 0xe0) and 'keymap_acer_travelmate_240'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text:dmi_matched from .data between 'dmi_ids' (at offset 0x10c) and 'keymap_acer_travelmate_240'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text:dmi_matched from .data between 'dmi_ids' (at offset 0x138) and 'keymap_acer_travelmate_240'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text:dmi_matched from .data between 'dmi_ids' (at offset 0x164) and 'keymap_acer_travelmate_240'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text:dmi_matched from .data between 'dmi_ids' (at offset 0x190) and 'keymap_acer_travelmate_240'
WARNING: drivers/video/macmodes.o - Section mismatch: reference to .init.text:mac_find_mode from __ksymtab between '__ksymtab_mac_find_mode' (at offset 0x0) and '__ksymtab_mac_map_monitor_sense'
WARNING: fs/jffs2/jffs2.o - Section mismatch: reference to .init.text:jffs2_zlib_init from .text between 'jffs2_compressors_init' (at offset 0x21) and 'jffs2_compressors_exit'
...

# gcc --version
gcc (GCC) 4.0.2 20050808 (prerelease) (Ubuntu 4.0.1-4ubuntu9)
Copyright (C) 2005 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# ld --version
GNU ld version 2.16.1 Debian GNU/Linux
Copyright 2005 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.


