Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTGOGcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 02:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTGOGcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 02:32:55 -0400
Received: from 12-240-128-156.client.attbi.com ([12.240.128.156]:55765 "EHLO
	carlthompson.net") by vger.kernel.org with ESMTP id S263355AbTGOGcq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 02:32:46 -0400
Message-ID: <1058251644.b873c9b752cd4@carlthompson.net>
X-Priority: 3 (Normal)
Date: Mon, 14 Jul 2003 23:47:24 -0700
From: Carl Thompson <cet@carlthompson.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.test1: Temporary "lock-up" with snd-ali5451 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 192.168.0.163
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This problem still exists in 2.6.0test1]

I am not on the kernel mailing list so please CC me with any responses.

I am forwarding this to the kernel list because
  1. adding printk()s to the driver suggests the lock-up happens before
     module_init() is called
  2. this driver is now part of the kernel
  3. I got no response on the ALSA list

----- Forwarded Message -----

Hello, I have a problem the answer to which I have not found with a search
of the list archives or google.

My laptop (emachines M5305 Widescreen) has an Ali M5451 audio controller.
Whenever is insert the snd-ali5451 driver, the whole computer hangs for
about 10 seconds.  The screen does not change, the keyboard does not work,
the mouse pointer does not move.  It looks very much like the system has
locked up.  After this long pause things start working including sound
which then works fine.  In fact, events seem to be queued while the system
is unresponsive.

This happens with both the module compiled from 0.9.4 for use with Linux
2.4.21 and with the module from Linux 2.5.72.

Changes to my IRQ routing settings have no effect.

The sound card shares interrupts with the usb ports.  I'm not sure if it can
be told to use a different interrupt (but it should share correctly,
right?).

Loading the OSS trident driver does not cause any problems [except on 2.5
where the trident driver causes my hard disks to stop working!?].

I am certain the problem happens when inserting the actual snd-ali5451
module and not one of the other modules.

No syslog messages of any kind seem to be generated.

Does anyone have any idea what the problem could be?

Thank you,
Carl Thompson

----- End Forwarded Message -----



