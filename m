Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbULEKNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbULEKNO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 05:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbULEKNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 05:13:14 -0500
Received: from gate.ibr.ch ([213.144.140.114]:33038 "EHLO gate.ibr.ch")
	by vger.kernel.org with ESMTP id S261289AbULEKNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 05:13:04 -0500
Date: Sun, 5 Dec 2004 11:13:01 +0100
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.9: Mouse lost synchronization
Message-ID: <20041205101301.GA12435@coruba.ibr.ch>
Mail-Followup-To: uwe@ibr.ch, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: Uwe Storbeck <uwe@ibr.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't know if this is the right place for reporting kernel bugs,
but I haven't found a direct e-mail address.

With kernel 2.6.9 my mouse is nearly unusable. It's a Logitech
optical mouse on the PS/2 port.

I get lots of syslog messages like this:

Dec  4 03:19:17 c3 kernel: psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
Dec  4 03:19:44 c3 kernel: psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
Dec  4 03:19:45 c3 kernel: psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
Dec  4 03:19:46 c3 kernel: psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
Dec  4 03:19:47 c3 kernel: psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
Dec  4 03:19:53 c3 kernel: psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.

If I move the mouse it wildly generates button events instead
of movement events, which completely scambles my desktop.

I've tried multiple variations, with gpm and without it, with
mouse set to autodetect and fix configured, all without success.

I have replaced the mouse for testing with an old Logitech
mechanical mouse. This works a bit better, but also often
loses its synchronization:

Dec  5 09:33:42 c3 kernel: psmouse.c: bad data from KBC - bad parity
Dec  5 09:33:52 c3 last message repeated 2 times
Dec  5 09:34:19 c3 kernel: psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.

This makes kernel 2.6 nearly unusable for a desktop system (with X11).

I also get problems with the keyboard if I use my KVM switch with kernel
2.6.9. After switching keyboard to another machine and switching back to
the system with kernel 2.6 the keyboard is disconnected. Nothing happens
if I press a key. After switching KVM back and forth several times and
pressing arbitrary keys multiple times keyboard comes back on line after
a while.

All of this hardware is working trouble-free with kernel 2.2.26 and
2.4.28. For now I'm forced to switch back to the stable kernel.

If you need more information please drop me a CC.

Regards,

Uwe
