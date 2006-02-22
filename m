Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWBVLJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWBVLJh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 06:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWBVLJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 06:09:37 -0500
Received: from ns1.suse.de ([195.135.220.2]:26270 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751132AbWBVLJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 06:09:36 -0500
Message-ID: <43FC4682.6050803@suse.de>
Date: Wed, 22 Feb 2006 12:09:54 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix ELF entry point (i386)
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Elf entry point is virtual address, not physical ...

please apply,

  Gerd

========================================================================
--- linux.o/arch/i386/kernel/vmlinux.lds.S	Tue Feb 21 18:36:00 2006
+++ linux/arch/i386/kernel/vmlinux.lds.S	Wed Feb 22 11:52:14 2006
@@ -10,7 +10,7 @@

 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
-ENTRY(phys_startup_32)
+ENTRY(startup_32)
 jiffies = jiffies_64;
 SECTIONS
 {

