Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270280AbTGMQhf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270281AbTGMQhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:37:35 -0400
Received: from smtp-2.concepts.nl ([213.197.30.52]:20484 "EHLO
	smtp-2.concepts.nl") by vger.kernel.org with ESMTP id S270280AbTGMQhL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:37:11 -0400
Subject: [2.5.x] panics while booting 2.5.75
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1058115165.2238.9.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 13 Jul 2003 18:52:46 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

apart from the issues I described in my other email ("[2.5.x] doesn't
boot at all on one computer"), I've got one other issue on another
computer. While booting, I'm getting multiple panics "bad: scheduling
while atomic!". This seems to happen while the mouse/keyboard are
initializing (I've got them compiled in-kernel), and also when my root
fs (ext3) is being loaded. I've tried both with and without an initrd
image (I first thought it was caused by the initrd image), and they both
crash. The exact lines look like this:

bad: scheduling while atomic!
Call Trace:
  [0xaddress] default_idle+0x0/0x40
  [0xaddress] schedule+0x3c4/0x3d0
  [0xaddress] default_idle+0x0/0x40
  [0xaddress] default_idle+0x0/0x40
  [0xaddress] default_idle+0x0/0x40
  [0xaddress] cpu_idle+0x41/0x50
  [0xaddress] rest_init+0x0/0x60
  [0xaddress] start_kernel+0x172/0x1a0
  [0xaddress] unknown_bootoption+0x0/0x20

Is anyone else experiencing issues with 2.5.75 that look alike? Are
there specific things I should/shouldn't do to get this to work?

OS:
RedHat-9.0
gcc-3.2.2-5
module-init-tools-0.9.12
kernel 2.5.75 (and now running 2.4.21)

System:
Toshiba Satellite Pro 6000
P-3 1,06 GHz
256 MB RAM
ALi/CyberAlladin mainboard chipset

Relevant lines from grub.conf:
title Red Hat Linux (2.5.75)
        root (hd0,0)
        kernel /vmlinuz-2.5.75 ro root=LABEL=/ vga=792
        initrd /initrd-2.5.75.img

Tried both with and without the initrd thing (obviously), and I also
tried using root=/dev/hda5 and omitting the vga=792 option (because the
call trace said "unknown_bootoption"), and it all didn't help.

config files:
http://213.197.11.65/ronald/config-2.5.75-initrd
http://213.197.11.65/ronald/config-2.5.75-noinitrd

If you need any more info, just ask. Oh, and please [CC] me, I'm not
subscribed here.

Thanks,

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

