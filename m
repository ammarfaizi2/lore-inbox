Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266125AbSKLCqz>; Mon, 11 Nov 2002 21:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbSKLCqz>; Mon, 11 Nov 2002 21:46:55 -0500
Received: from mail.myrio.com ([63.109.146.2]:30452 "HELO mail.myrio.com")
	by vger.kernel.org with SMTP id <S266125AbSKLCqy>;
	Mon, 11 Nov 2002 21:46:54 -0500
Subject: pc_keyb.c #define kbd_controller_present()
From: Nat Ersoz <nat.ersoz@myrio.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Nov 2002 18:53:17 -0800
Message-Id: <1037069597.23521.46.camel@ersoz.et.myrio.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 12 Nov 2002 02:53:38.0315 (UTC) FILETIME=[B35075B0:01C289F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. We have a hardware platform which do not have a PS/2 style keyboard
controller.  When the kernel boots we get the following message, printed
many times over:

"pc_keyb: controller jammed 0xFF"

2. In the file linx/drivers/char/pc_keyb.c, the following lines are
present (lines 72-74 for kernel version 2.4.20-pre10)

#ifndef kbd_controller_present
#define kbd_controller_present()        1
#endif

By changing kbd_controller_present() to '0' instead of '1', we no longer
the the "jammed" message and a 15-20 second reduction in boot time.

3. It would be nice if there were a .config file parameter that was the
moral equivalent of CONFIG_PSMOUSE for the keyboard, like say
CONFIG_PSKEYBD so that the keyboard could be disabled as easily as the
mouse.

4. We try to maintain different linux/.config files for each hardware
platform.  This works well, except in this case of the keyboard.  In
this case we have to maintain a hardware specific patch.

Is it possible to get a new .config file symbol for the keyboard similar
to the mouse?  It would be very helpful to us.

Thanks,

Nat
nat.ersoz@myrio.com

PS - please post responses to my email as well as the LKML.  Thanks.



