Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWC3LL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWC3LL1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 06:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWC3LL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 06:11:27 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:21928 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932172AbWC3LL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 06:11:26 -0500
Date: Thu, 30 Mar 2006 13:11:15 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [2.6.16-gitX] initcall at 0xffffffff804615d1: returned with error
 code -1
Message-Id: <20060330131115.73886fd4.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC-ing author since I'm unsure about domain responsibility. The commit
"[PATCH] initcall failure reporting" AKA
c1cda48af8b330a23206eceef3bd030b53c979cd immediately triggered:

--- dmesg-cd02b966bfcad12d1b2e265dc8dbc331d4c184c4      2006-03-30 08:41:30.000000000 +0200
+++ dmesg-c1cda48af8b330a23206eceef3bd030b53c979cd      2006-03-30 09:12:31.000000000 +0200
[...]
@@ -83,10 +83,12 @@
 SCSI subsystem initialized
 PCI: Using ACPI for IRQ routing
 PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
+initcall at 0xffffffff804615d1: returned with error code -1
 pnp: 00:06: ioport range 0x600-0x60f has been reserved
 pnp: 00:06: ioport range 0x1c0-0x1cf has been reserved
 pnp: 00:06: ioport range 0x4d0-0x4d1 has been reserved
 pnp: 00:06: ioport range 0xfe10-0xfe11 could not be reserved
+initcall at 0xffffffff804704fc: returned with error code 2
 PCI: Failed to allocate mem resource #6:20000@f0000000 for 0000:01:00.0
 PCI: Bridge: 0000:00:01.0
   IO window: disabled.

Since then (now at 2.6.16-git18) the last/lower one has vanished, but the
first one remains. The patch says that the initcall function should be
printed, but it seems to need some debugging option set. Please advice if
this is of interest (the addresses do not stay constant). 

Mvh
Mats Johannesson
--
