Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbTIFABT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 20:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbTIEX77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 19:59:59 -0400
Received: from lidskialf.net ([62.3.233.115]:7373 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S265143AbTIEX7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 19:59:19 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] 2.6.0-test4 ACPI fixes series (4/4)
Date: Sat, 6 Sep 2003 01:57:47 +0100
User-Agent: KMail/1.5.3
Cc: torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, linux-acpi@intel.com
References: <200309051958.02818.adq_dvb@lidskialf.net> <200309060016.16545.adq_dvb@lidskialf.net> <3F590E28.6090101@pobox.com>
In-Reply-To: <3F590E28.6090101@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309060157.47121.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some erroneous code from mpparse which breaks IO-APIC programming


--- linux-2.6.0-test4.null_crs/arch/i386/kernel/mpparse.c	2003-09-06 00:23:10.000000000 +0100
+++ linux-2.6.0-test4.duffmpparse/arch/i386/kernel/mpparse.c	2003-09-06 00:28:23.788124872 +0100
@@ -1129,9 +1129,6 @@
 			continue;
 		ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
 
-		if (!ioapic && (irq < 16))
-			irq += 16;
-
 		/* 
 		 * Avoid pin reprogramming.  PRTs typically include entries  
 		 * with redundant pin->irq mappings (but unique PCI devices);

