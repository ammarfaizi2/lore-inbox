Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266455AbUBLOSq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 09:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266457AbUBLOSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 09:18:46 -0500
Received: from math.ut.ee ([193.40.5.125]:2007 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S266455AbUBLOSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 09:18:45 -0500
Date: Thu, 12 Feb 2004 16:18:43 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Strange atkbd messages with missing keyboard
Message-ID: <Pine.GSO.4.44.0402121600030.22808-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get strange messages on bootup when there is no keyboard attached
(Intel 430TX chipset on a Tyan S1573 mainboard) - it tells about unknown
keys pressed.

When no keyboard and no mouse is plugged in:

serio: i8042 AUX port at 0x60,0x64 irq 12
atkbd.c: Unknown key pressed (raw set 0, code 0x17e on isa0060/serio1).
atkbd.c: Use 'setkeycodes 7e <keycode>' to make it known.
serio: i8042 KBD port at 0x60,0x64 irq 1
atkbd.c: Unknown key released (translated set 0, code 0x7e on isa0060/serio0).
atkbd.c: Use 'setkeycodes 7e <keycode>' to make it known.

When keyboard is plugged in but no mouse:

serio: i8042 AUX port at 0x60,0x64 irq 12
atkbd.c: Unknown key pressed (raw set 0, code 0x17e on isa0060/serio1).
atkbd.c: Use 'setkeycodes 7e <keycode>' to make it known.
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0

With both keyboard and mouse plugged in it is normal:

serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Logitech Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0

-- 
Meelis Roos (mroos@linux.ee)



