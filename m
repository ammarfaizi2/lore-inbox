Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265581AbUBCA7J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 19:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265587AbUBCA5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 19:57:54 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:36613 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S265400AbUBCA4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 19:56:40 -0500
Date: Tue, 3 Feb 2004 01:56:37 +0100
From: mcornils@usta.de
To: linux-kernel@vger.kernel.org
Subject: 2.6.x: local APIC results in hang at boot
Message-ID: <20040203005637.GA19998@innen.usta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've tested this with 2.6.2-rc3 and kernels before that; when I activate
the "Enable local APIC" question the kernel hangs with:

POSIX conformance testing by UNIFIX
enabled ExtInt on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1399.0856 MHz.
..... host bus clock speed is 99.0989 MHz.
NET: Registered protocol family 16
EISA bus registered
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
ACPI: IRQ9 SCI: Edge set to Level Trigger.

and then nothing happens.

On request, I can send the boot log from the same kernel without local
APIC compiled-in; you can also get it from 
http://www.usta.de/RefAk/Aussen/privat/apic-works.log

As I said, it works without the option. (So, this is a problem for
people using distribution/generic kernels with the Local-APIC option
enabled)

This is an Asus Centrino notebook (M2400N) with 1,4 GHz, latest BIOS
update and so on. When I enable the local APIC but disable ACPI, it
works too - ACPI is used to reroute some interrupts and make e.g. sound
work.

Yours,
-Malte Cornils
