Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbUK2U02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbUK2U02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 15:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbUK2U02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 15:26:28 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:54292 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261781AbUK2U0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 15:26:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=b0S1co8OP+CpruHMufDWzazvITJlwIdjQ+b6FlNEdMIFFF5n+HcxSZEPsGwgKZLxSxjZBBZIyzIbUd72uaFW44B1A2QvVU8hcNf9WNp1y9qi/nXoCM5r1ABFagqjpoDbvr3Kva3BBYgtHrJou1lWrRXlI2Rk1NtlB5LlPvlZWrw=
Message-ID: <aec7e5c30411291226104ae711@mail.gmail.com>
Date: Mon, 29 Nov 2004 21:26:20 +0100
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: yenta: Fish. Please report.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am unable to use yenta from 2.6.9 on my laptop.  The module loads
but "cardctl insert" and "cardctl status" does not work what I can
tell. 2.4.28 seems to work ok, so does 2.4.19.

The laptop model is uniwill 223ii0, BIOS 1.03. 

2.6.9-kernel output from "modprobe yenta_socket":

ACPI: PCI interrupt 0000:01:03.0[A] -> GSI 3 (level, low) -> IRQ 3
Yenta: CardBus bridge found at 0000:01:03.0 [1584:3200]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:01:03.0, mfunc 0x000c1002, devctl 0x44
Yenta TI: socket 0000:01:03.0 probing PCI interrupt failed, trying to fix
Yenta TI: socket 0000:01:03.0 no PCI interrupts. Fish. Please report.
Yenta: ISA IRQ mask 0x0000, PCI irq 0
Socket status: 00000000

Output from 2.4.28:

Yenta ISA IRQ mask 0x00d0, PCI irq 3
Socket status: 30000020

Output from "lspci -vn":
[snip]
0000:01:03.0 Class 0607: 104c:ac50 (rev 02)
        Subsystem: 1584:3200
        Flags: bus master, medium devsel, latency 168, IRQ 3
        Memory at 7e001000 (32-bit, non-prefetchable)
        Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 7e400000-7e7ff000 (prefetchable)
        Memory window 1: 7e800000-7ebff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001
[snip]

Let me know how to proceed, full dmesg output, non-numeric lspci etc.

Thanks!

/ magnus
