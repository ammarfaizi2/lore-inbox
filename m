Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265899AbUAULkm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 06:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUAULkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 06:40:42 -0500
Received: from joel.ist.utl.pt ([193.136.198.171]:21185 "EHLO joel.ist.utl.pt")
	by vger.kernel.org with ESMTP id S265899AbUAULkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 06:40:36 -0500
Date: Wed, 21 Jan 2004 11:40:26 +0000 (WET)
From: Rui Saraiva <rmps@joel.ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: [2.6.2-rc1] sleep called from invalid context (8250/ACPI related?)
Message-ID: <Pine.LNX.4.58.0401211139001.13077@joel.ist.utl.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--------------------------------------------------------------------------------|
	Hello,

	I've found this message in my logs while investigating some kernel Oops
(in other message). If you need more info, please ask.

	Regards,
		Rui Saraiva


Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c0122ddb>] __might_sleep+0xab/0xd0
 [<d1bd2df6>] uart_unregister_port+0x76/0xa9 [serial_core]
 [<d1bd9559>] unregister_serial+0x19/0x20 [8250]
 [<d1bcb2de>] acpi_serial_remove+0x2e/0x50 [8250_acpi]
 [<c02523f0>] acpi_driver_detach+0xcc/0x184
 [<c0252621>] acpi_bus_unregister_driver+0x18/0x168
 [<d1bcb312>] acpi_serial_exit+0x12/0x14 [8250_acpi]
 [<c014510f>] sys_delete_module+0x13f/0x160
 [<c0166307>] sys_munmap+0x57/0x80
 [<c010a14f>] syscall_call+0x7/0xb
