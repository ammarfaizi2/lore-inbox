Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTFXPeS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 11:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTFXPbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 11:31:35 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:59533 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262165AbTFXPa4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 11:30:56 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 24 Jun 2003 17:52:00 +0200
From: Gerd Knorr <kraxel@suse.de>
To: Kernel List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: [x86_64 PATCH 2/2] build fix -- show_stack
Message-ID: <20030624155200.GB30885@bytesex.org>
References: <20030624154951.GA30885@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030624154951.GA30885@bytesex.org>
X-GPG-Fingerprint: 79C4 EE94 CC44 6DD4 58C6  3088 DBB7 EC73 8750 D2C4  [1024D/8750D2C4]
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

acpi build fix needed for x86_64 -- make the functions match the
prototypes in include/acpi/

  Gerd

--- o-linux-2.5.73/drivers/acpi/osl.c.acpi	2003-06-24 12:24:16.000000000 +0200
+++ o-linux-2.5.73/drivers/acpi/osl.c	2003-06-24 12:24:56.000000000 +0200
@@ -933,8 +933,8 @@
 }
 
 /* Assumes no unreadable holes inbetween */
-BOOLEAN
-acpi_os_readable(void *ptr, u32 len)
+u8
+acpi_os_readable(void *ptr, acpi_size len)
 {
 #if defined(__i386__) || defined(__x86_64__) 
 	char tmp;
@@ -943,8 +943,8 @@
 	return 1;
 }
 
-BOOLEAN
-acpi_os_writable(void *ptr, u32 len)
+u8
+acpi_os_writable(void *ptr, acpi_size len)
 {
 	/* could do dummy write (racy) or a kernel page table lookup.
 	   The later may be difficult at early boot when kmap doesn't work yet. */
