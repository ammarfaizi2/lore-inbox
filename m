Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266379AbUGUAyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266379AbUGUAyx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 20:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266381AbUGUAyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 20:54:53 -0400
Received: from 214.98-30-64.ftth.swbr.surewest.net ([64.30.98.214]:50189 "HELO
	sublime.the-space.net") by vger.kernel.org with SMTP
	id S266379AbUGUAyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 20:54:50 -0400
Date: Tue, 20 Jul 2004 17:55:32 -0700 (PDT)
From: Andy Biddle <andyb@chainsaw.com>
X-X-Sender: andyb@sublime.winfirst.com
To: linux-kernel@vger.kernel.org
Subject: Asus A7M266-D, Linux 2.6.7 and APIC
Message-ID: <20040720175509.H48409@sublime.winfirst.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having what I suspect is a newbie-type problem, but I assure you I've
looked around.

I have a dual-proc server that I've recently decided to overhaul.  It's an
Asus A7M266-D motherboard.  It had been running with dual Athlon MP 1800+s
and RedHat and BIOS rev 1003 for at least a year with no real problems.

First I decided to change the OS to Gentoo.  I build the system with no
problem and built a custom kernel based on linux 2.6.7-gentoo-r11.
Everything was working great.  Then I changed out the procs and went with
dual Athlon MP 2800+s.  To support these, I needed to (according to Asus's
website) upgrade the BIOS to 1011.002 or higher.  (Latest is 1011.003, so
that's what I used.)

Now, when I boot to this custom kernel I get about 2 seconds into the boot
process before the system starts spewing constant "APIC error on CPU0:
04(04)" messages.   It stops booting at that point.

I've done a little research and it seems that I'm supposed to do a couple
of things:
	1.  Disable "MPS 1.4 Support" in the BIOS.
	2.  pass the kernel "noapic" as a parameter.

I've done both of these and I STILL get the APIC messages.  (Which leads
me to suspect the "noapic" isn't working or I'm doing it wrong at the very
least.)

I've build another custom kernel where the only difference is that SMP is
disabled.  Sure enough, that works like a champ, but with only the single
CPU.

I've searched through the kernel "make menuconfig" menus and can't see
that I'm missing anything.  In fact, I can't even FIND "APIC" options
unless I disable SMP...

I'm just about out of ideas here... Any suggestions?

Thanks,
AndyB
-
To unsubscribe from this list: send the line "unsubscribe linux-smp" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

