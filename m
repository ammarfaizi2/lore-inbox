Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267327AbUIXCXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267327AbUIXCXS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267720AbUIXCVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 22:21:07 -0400
Received: from scrye.com ([216.17.180.1]:44743 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S267662AbUIXCUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 22:20:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Sep 2004 20:19:53 -0600
From: Kevin Fenzi <kevin-linux-kernel@scrye.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc2-mm1 swsusp bug report.
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Message-Id: <20040924021956.98FB5A315A@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Was trying to swsusp my 2.6.9-rc2-mm1 laptop tonight. It churned for a
while, but didn't hibernate. Here are the messages. 

I do have PREEMPT and HIMEM enabled. 

Sep 23 16:53:37 voldemort kernel: Stopping tasks: ==================================================
=================================================|
Sep 23 16:53:37 voldemort kernel: Freeing memory...  ^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H
/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-
^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^
H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H
/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-
^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^
H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H
/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-
^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^
H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H
/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\
Sep 23 16:53:37 voldemort kernel: ..................................................................
....................................................................................................
.........................swsusp: Need to copy 34850 pages
Sep 23 16:53:37 voldemort kernel: hibernate: page allocation failure. order:8, mode:0x120
Sep 23 16:53:37 voldemort kernel:  [<c013fc1e>] __alloc_pages+0x21e/0x3e0
Sep 23 16:53:37 voldemort kernel:  [<c013fe05>] __get_free_pages+0x25/0x3f
Sep 23 16:53:37 voldemort kernel:  [<c01373b5>] alloc_pagedir+0x1f/0x6b
Sep 23 16:53:37 voldemort kernel:  [<c01374e3>] swsusp_alloc+0x2c/0x62
Sep 23 16:53:37 voldemort kernel:  [<c0137549>] suspend_prepare_image+0x30/0x6e
Sep 23 16:53:37 voldemort kernel:  [<c0284fea>] swsusp_arch_suspend+0x2a/0x2c
Sep 23 16:53:37 voldemort kernel:  [<c01375d5>] swsusp_suspend+0x24/0x33
Sep 23 16:53:37 voldemort kernel:  [<c01379c2>] pm_suspend_disk+0x28/0x7e
Sep 23 16:53:37 voldemort kernel:  [<c0135fd0>] enter_state+0x91/0x95
Sep 23 16:53:39 voldemort kernel:  [<c013fc30>] __alloc_pages+0x230/0x3e0
Sep 23 16:53:39 voldemort kernel:  [<c01360fb>] state_store+0xb1/0xc8
Sep 23 16:53:39 voldemort kernel:  [<c0192748>] subsys_attr_store+0x3a/0x3e
Sep 23 16:53:39 voldemort kernel:  [<c01929ce>] flush_write_buffer+0x3e/0x4a
Sep 23 16:53:39 voldemort kernel:  [<c0192a5c>] sysfs_write_file+0x82/0x98
Sep 23 16:53:39 voldemort kernel:  [<c01929da>] sysfs_write_file+0x0/0x98
Sep 23 16:53:39 voldemort kernel:  [<c015926d>] vfs_write+0xd0/0x135
Sep 23 16:53:39 voldemort kernel:  [<c015882b>] filp_close+0x59/0x86
Sep 23 16:53:39 voldemort kernel:  [<c01593a3>] sys_write+0x51/0x80
Sep 23 16:53:39 voldemort kernel:  [<c0106019>] sysenter_past_esp+0x52/0x71
Sep 23 16:53:39 voldemort kernel: swsusp: Restoring Highmem
Sep 23 16:53:39 voldemort kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ
11
Sep 23 16:53:39 voldemort kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
Sep 23 16:53:39 voldemort kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
Sep 23 16:53:39 voldemort kernel: Restarting tasks... done

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFBU4RM3imCezTjY0ERAgEQAJ4qj2PmNsL/5ao+3swoOxioop7G1gCeLLUg
ZOWJKH6q3k9UMG8xaYDGLx0=
=Csmg
-----END PGP SIGNATURE-----
