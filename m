Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262977AbVG3OvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbVG3OvX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 10:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262978AbVG3OvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 10:51:22 -0400
Received: from 69.36.162.216.west-datacenter.net ([69.36.162.216]:19406 "EHLO
	schau.com") by vger.kernel.org with ESMTP id S262977AbVG3OvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 10:51:16 -0400
Message-ID: <42EB940E.5000008@schau.com>
Date: Sat, 30 Jul 2005 16:51:58 +0200
From: Brian Schau <brian@schau.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Wireless Security Lock driver.
Content-Type: multipart/mixed;
 boundary="------------070106080101050601000009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070106080101050601000009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,


I've attached a gzipped version of my Wireless Security Lock patch
for v2.6.13-rc4.
A Wireless Security Lock (WSL or weasel :-) is made up of two parts.
One part is a receiver which you plug into any available USB port.
The other part is a transmitter which at fixed intervals sends
"ping packets".
A "ping packet" usually consists of an ID and a flag telling if the
transmitter has just been turned on.
Both devices lights up in a nice way when a "ping packet" is send/
received.
The whole idea of this is that when the transmitter is brought out
of range one could have a process (such as xscreensaver) lock the
display.
The WSL is a toy gadget.

For more information see:

	http://www.schau.com/l/wsl/index.html

The WSL driver touches these files:

	drivers/usb/Makefile			(1 line)
	drivers/usb/input/Kconfig		(10 lines)
	drivers/usb/input/Makefile		(1 line)
	drivers/usb/input/hid-core.c		(2 lines)
	drivers/usb/input/wsl.c			(224 lines)

This is my first driver for Linux - feel free to harass me if I am
not following procedures or you think the driver is lame.  Better still,
educate me :-)


/brian


--------------070106080101050601000009
Content-Type: application/x-gzip;
 name="wsl.patch-2.6.13-rc4.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="wsl.patch-2.6.13-rc4.gz"

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
--------------070106080101050601000009--
