Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267461AbUBSB6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 20:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267454AbUBSB5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 20:57:23 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:49559 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S267453AbUBSB4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 20:56:22 -0500
To: <linux-kernel@vger.kernel.org>
Subject: ACPI and ISA IRQ 9, Linux 2.4
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 19 Feb 2004 02:19:33 +0100
Message-ID: <m3isi3n9wa.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think this is a known problem, but I don't know how to fix it:

I have a dual Pentium-2 machine (non-SCSI Asus P2B-D), latest BIOS with
ACPI etc. It has an ISA card (serial port) using IRQ 9 (I can't change
the IRQ). It works fine without ACPI, Linux 2.4 lists IRQ 9 as
APIC edge-triggered.

With acpi=force (due to BIOS date) IRQ 9 is used by ACPI. /proc/interrupts
lists it as APIC level-triggered, and the ISA card no longer generates
interrupts.

IRQ 9 is set to "ISA" in BIOS setup. acpi_irq_isa=9 doesn't help.

Is is possible to fix it? Or is it just impossible to use ISA IRQ 9
with ACPI?

More details available on request, of course.
-- 
Krzysztof Halasa, B*FH
