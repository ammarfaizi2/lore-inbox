Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261886AbSJHK7O>; Tue, 8 Oct 2002 06:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261931AbSJHK7O>; Tue, 8 Oct 2002 06:59:14 -0400
Received: from delphin.mathe.tu-freiberg.de ([139.20.24.12]:10553 "EHLO
	delphin.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id <S261886AbSJHK7N>; Tue, 8 Oct 2002 06:59:13 -0400
Message-Id: <200210081015.MAA09863@delphin.mathe.tu-freiberg.de>
Content-Type: text/plain; charset=US-ASCII
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.41 input problems and sleeping functions
Date: Tue, 8 Oct 2002 13:05:32 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, 

with 2.5.41 I can't type the " | " anymore. If I type it, I get

atkbd.c: Unknown key (set 2, scancode 0x6a, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x6a, on isa0060/serio0) released.


relevant part or dmesg (I hope):

register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
register interface 'event' with class 'input
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1



Moreover, sometimes the usb mouse dies. Pulling it out and plugging it back
gives me

Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
 [<c0113a4d>] __might_sleep+0x54/0x5b
 [<c02082af>] usb_hub_events+0x5f/0x29d
 [<c020851d>] usb_hub_thread+0x30/0xce
 [<c02084ed>] usb_hub_thread+0x0/0xce
 [<c0112981>] default_wake_function+0x0/0x32
 [<c0105461>] kernel_thread_helper+0x5/0xb



Thanks,
Michael


