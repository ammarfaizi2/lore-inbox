Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUAJNV4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 08:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbUAJNV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 08:21:56 -0500
Received: from moutng.kundenserver.de ([212.227.126.185]:36550 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265161AbUAJNVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 08:21:54 -0500
Date: Sat, 10 Jan 2004 14:23:04 +0100 (CET)
From: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter@peterpall.de>
Reply-To: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter.koenigsmann@gmx.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter@peterpall.de>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] Psmouse log and discard timed out bytes
In-Reply-To: <200401100346.04660.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.53.0401101407520.1276@calcula.uni-erlangen.de>
References: <Pine.LNX.4.53.0401091101170.1050@calcula.uni-erlangen.de>
 <200401100344.03758.dtor_core@ameritech.net> <200401100345.17211.dtor_core@ameritech.net>
 <200401100346.04660.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:6f0b4d165b4faec4675b8267e0f72da4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Next strange thing is the following boot message:


<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 1399.0579 MHz.
<4>..... host bus clock speed is 99.0969 MHz.

Recompiling the Kernel without APIC support changes nothing.

<6>cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
<7>cpufreq: Unknown P4. Please send an e-mail to <linux@brodo.de>
<6>speedstep-centrino: found "Intel(R) Pentium(R) M processor 1400MHz": max frequency: 1400000kHz
<6>IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>

Was on max speed for tests.

<6>mice: PS/2 mouse device common for all mice
<6>input: PC Speaker
<6>i8042.c: Detected active multiplexing controller, rev 1.1.
<6>serio: i8042 AUX0 port at 0x60,0x64 irq 12
<4>psmouse.c: bad data from KBC - timeout
<6>serio: i8042 AUX1 port at 0x60,0x64 irq 12
<4>psmouse.c: bad data from KBC - timeout
<6>serio: i8042 AUX2 port at 0x60,0x64 irq 12
<4>psmouse.c: bad data from KBC - timeout
<6>serio: i8042 AUX3 port at 0x60,0x64 irq 12
<6>Synaptics Touchpad, model: 1
<6> Firmware: 5.8
<6> 180 degree mounted touchpad
<6> Sensor: 18
<6> new absolute packet format
<6> Touchpad has extended capability bits
<6> -> 4 multi-buttons, i.e. besides standard buttons
<6> -> multifinger detection
<6> -> palm detection
<6>input: SynPS/2 Synaptics TouchPad on isa0060/serio4
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>input: AT Translated Set 2 keyboard on isa0060/serio0

Timeout on init?
Looked in old boot logs. Without the patches I get random unknown pressed
keys on init. Don't know if this helps.

-- 
Tu', was Du willst, aber --- HÜTE DICH VOR DEM GROOVE!
        --Der Bauer, Ein Königreich für ein Lama.

