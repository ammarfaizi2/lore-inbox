Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbTEFTj4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 15:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbTEFTj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 15:39:56 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:40616 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261169AbTEFTjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 15:39:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16056.4728.649612.413159@gargle.gargle.HOWL>
Date: Tue, 6 May 2003 21:52:24 +0200
From: mikpe@csd.uu.se
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.5.69 oops at sysenter_past_esp
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Old Dell Latitude with very basic .config: PII, IDE/PIIX, ext2, cardbus,
hotplug, networking, but no SMP, {IO-,}APIC, ACPI, usb.

Booting into a text console, not starting X or inserting cardbus NIC,
suspending the box (apm). At resume, I am immediately greeted with an
oops looking like:

general protection fault: 0000 [#?]
CPU:	0
EIP:	0060:[<c0109079>]	Not tainted
EFLAGS:	00010246
EIP is at systenter_past_esp+0x6e/0x71
<register dump>
Process <varies, any one of the daemons>
Stack: ...
Call Trace: <empty>

The machine is almost but not completely dead at this point.
The oops repeats several times with varying intervals (from
seconds up to minutes). The keyboard is initially not dead
(it responds to RET) but it too locks up after a while.

I don't know if this is new in 2.5.69, as I didn't test suspend
with 2.5.68 -- I've had resume-related PS/2 mouse problems with
recent 2.5 kernels, fixed finally by the "psmouse_noext" option.

/Mikael
