Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVCBXVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVCBXVb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVCBXRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:17:55 -0500
Received: from bay20-f36.bay20.hotmail.com ([64.4.54.125]:39182 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261215AbVCBXRI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:17:08 -0500
Message-ID: <BAY20-F36510468D55048A77ABE9EC95A0@phx.gbl>
X-Originating-IP: [128.214.191.198]
X-Originating-Email: [furlongm@hotmail.com]
From: "Marcus Furlong" <furlongm@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Bug report -- keyboard not working Linux 2.6.11 on Inspiron 1150 (and 5150)
Date: Wed, 02 Mar 2005 23:16:43 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 02 Mar 2005 23:17:01.0028 (UTC) FILETIME=[F0255A40:01C51F7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the diff of dmesgs between 2.6.10 and 2.6.11


2.6.10
>i8042.c: Warning: Keylock active.
>serio: i8042 AUX port at 0x60,0x64 irq 12
>serio: i8042 KBD port at 0x60,0x64 irq 1

2.6.11
< ACPI: PS/2 Keyboard Controller [KBC] at I/O 0x60, 0x66, irq 1
< ACPI: PS/2 Mouse Controller [PS2M] at irq 12
< i8042.c: Can't read CTR while initializing i8042.


booting with i8042.debug=1 gives:

ACPI: PS/2 Keyboard Controller [KBC] at I/O 0x60, 0x66, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
drivers/input/serio/i8042.c:      -- i8042 (timeout) [508]
i8042.c: Can't read CTR while initializing i8042.


workaround is to boot with i8042.noacpi=1

i8042: ACPI detection disabled
i8042.c: Warning: Keylock active.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1

_________________________________________________________________
Get almost unlimited e-mail storage - upgrade to Hotmail Plus! 
http://www.imagine-msn.com/hotmail/en-ie

