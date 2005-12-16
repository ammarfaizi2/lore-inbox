Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbVLPBUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVLPBUh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbVLPBUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:20:37 -0500
Received: from [202.67.154.148] ([202.67.154.148]:29147 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S1751181AbVLPBUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:20:36 -0500
Message-ID: <43A21825.2020300@ns666.com>
Date: Fri, 16 Dec 2005 02:28:05 +0100
From: Trilight <trilight@ns666.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: serious issue with acpi on a dual/HT xeon dell workstation
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently trying to find a solution for as it looks like an acpi
problem on a dell precision workstation 650, dual xeon w/HT.

Kernel: 2.6.14.3

Tried:

I tried all the conventional stuff of almost all acpi commands on the
bootprompt and things like (no)apic and so on.

The only way to make the box boot is by disabling every shred of acpi
and using noapic but that means for example no HT anymore.

Or by letting it reboot 5 to 12 times to get it to continue WITH acpi
and apic and end up with a suddenly working system. Seeing 2 real cpu's
and 2 virtual cpu's.


Just before the moment, during boot, when it's going to crash i see
something like:

...remote apic #(some number here) ...

Then when it's probing the apic #<numbers> to get ID/Version of the
cpu's they all come back with FAILED, then it reboots. Nothing is
logged, it just reboots quickly.

ACPI/DSDT:

Now i'm trying to see if this issue sits in the DSDT table or somewhere
else in the acpi data. The DSDT contains errors when trying to recompile
it with the intel compiler (IASL). I'm pasting here below the errors, it
would be great if some one can give a helping hand or at least if the
DSDT is responsible for this behaviour:

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20050930 [Dec 15 2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

dsdt.dsl   338:         Notify (\_SB.PCI0.USB0, 0x02)
Error    1061 -        Object does not exist ^  (\_SB.PCI0.USB0)

dsdt.dsl   351:         Notify (\_SB.PCI0.USB1, 0x02)
Error    1061 -        Object does not exist ^  (\_SB.PCI0.USB1)

dsdt.dsl   364:         Notify (\_SB.PCI0.USB2, 0x02)
Error    1061 -        Object does not exist ^  (\_SB.PCI0.USB2)

dsdt.dsl   377:         Notify (\_SB.PCI0, 0x02)
Error    1061 -   Object does not exist ^  (\_SB.PCI0)

dsdt.dsl   384:         Notify (\_SB.PCI0.PCI4, 0x02)
Error    1061 -        Object does not exist ^  (\_SB.PCI0.PCI4)

dsdt.dsl   400:         Notify (\_SB.PCI0.ISA.KBD, 0x02)
Error    1061 -           Object does not exist ^  (\_SB.PCI0.ISA.KBD)

dsdt.dsl  1784:                 Device (DMA)
Error    1094 -                           ^ syntax error, unexpected
PARSEOP_DMA, expecting PARSEOP_NAMESEG or PARSEOP_NAMESTRING

ASL Input:  dsdt.dsl - 3096 lines, 93624 bytes, 515 keywords
Compilation complete. 7 Errors, 0 Warnings, 0 Remarks, 53 Optimizations
