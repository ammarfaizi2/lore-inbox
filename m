Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTLDWql (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 17:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263647AbTLDWql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 17:46:41 -0500
Received: from hell.org.pl ([212.244.218.42]:46854 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S263646AbTLDWqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 17:46:39 -0500
Date: Thu, 4 Dec 2003 23:46:44 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/3] Input: resume support for i8042 (atkbd & psmouse)
Message-ID: <20031204224643.GA23592@hell.org.pl>
References: <XQFu.15s.3@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <XQFu.15s.3@gated-at.bofh.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Dmitry Torokhov:
> Here is an attempt to implement resume for i8042 using serio_reconnect
> facility that can be found in -mm kernels. It also depends on bunch of 
> other changes in input subsystem all of which can be found here:
> http://www.geocities.com/dt_or/input
> 
> They should apply cleanly to -test11.

Your patches seem to work fine for my keyboard -- it reconnects and works
smoothly (the interrupts are fine). My Synaptics touchpad is however not
present after resume -- no response and no mention of i8042 in
/proc/interrupts after S3 resume. I attach a dmesg excerpt in hope that
helps you in any way. Thanks for the good work!

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl

[...]
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 4.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
[...]
 hwsleep-0257 [28] acpi_enter_sleep_state: Entering sleep state [S3]
[...]
Restarting tasks...<6>input: AT Translated Set 2 keyboard on isa0060/serio0 (reconnected)
 done

