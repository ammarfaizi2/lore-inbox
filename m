Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWE0LzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWE0LzU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 07:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWE0LzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 07:55:20 -0400
Received: from math.ut.ee ([193.40.36.2]:14326 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1751480AbWE0LzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 07:55:19 -0400
Date: Sat, 27 May 2006 14:55:16 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: section mismatches in atyfb and macmodes
Message-ID: <Pine.SOC.4.61.0605271446210.27107@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is todays 2.6.15-rc5+git, updated a day or two old tree and got 
this after compilation:

   MODPOST
WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to .init.data: from .text between 'atyfb_pci_probe' (at offset 0x246c) and 'rotation24bpp'
WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to .init.text:aty_init_cursor from .text between 'atyfb_pci_probe' (at offset 0x2502) and 'rotation24bpp'
WARNING: drivers/video/macmodes.o - Section mismatch: reference to .init.text:mac_find_mode from __ksymtab between '__ksymtab_mac_find_mode' (at offset 0x0) and '__ksymtab_mac_map_monitor_sense'

These kinds of errors seem to go away after make clean, which suggests 
it might be something that our build system does not detect to 
recompile?

-- 
Meelis Roos (mroos@linux.ee)
