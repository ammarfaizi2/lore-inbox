Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282706AbRLLWOf>; Wed, 12 Dec 2001 17:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282492AbRLLWOZ>; Wed, 12 Dec 2001 17:14:25 -0500
Received: from jhuml4.jhu.edu ([128.220.2.67]:32504 "EHLO jhuml4.jhu.edu")
	by vger.kernel.org with ESMTP id <S282687AbRLLWOR>;
	Wed, 12 Dec 2001 17:14:17 -0500
Date: Wed, 12 Dec 2001 17:15:10 -0500
From: Thomas Hood <jdthood@mail.com>
Subject: USB not processing APM suspend event properly?
To: linux-kernel@vger.kernel.org
Message-id: <1008195310.1126.17.camel@thanatos>
MIME-version: 1.0
X-Mailer: Evolution/1.0 (Preview Release)
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following syslog fragment shows what happens when I
suspended a while ago.  The USB subsystem disconnected
my USB mouse, but then tried (twice) to reconnect it again
while the apm driver was still processing the suspend.  The
attempts to reconnect failed.  I presume there is something
wrong with this picture.  Does this indicate a bug in
USB power management?

(The repeated "received system suspend notify" messages are
there because I have apm debug messages switch on, and I
am using a ThinkPad, which generates repeated suspend
events.)

Dec  9 17:38:27 thanatos kernel: apm: received system suspend notify
Dec  9 17:38:27 thanatos kernel: usb.c: USB disconnect on device 4
Dec  9 17:38:27 thanatos kernel: apm: received system suspend notify
Dec  9 17:38:27 thanatos kernel: apm: received system suspend notify
Dec  9 17:38:27 thanatos kernel: hub.c: USB new device connect on
bus1/1, assigned device number 5
Dec  9 17:38:28 thanatos kernel: apm: received system suspend notify
Dec  9 17:38:30 thanatos last message repeated 2 times
Dec  9 17:38:30 thanatos kernel: usb_control/bulk_msg: timeout
Dec  9 17:38:30 thanatos kernel: usb.c: USB device not accepting new
address=5 (error=-110)
Dec  9 17:38:31 thanatos kernel: hub.c: USB new device connect on
bus1/1, assigned device number 6
Dec  9 17:38:31 thanatos kernel: apm: setting state busy
Dec  9 17:38:31 thanatos kernel: apm: received system suspend notify
Dec  9 17:38:33 thanatos last message repeated 2 times
Dec  9 17:38:34 thanatos kernel: usb_control/bulk_msg: timeout
Dec  9 17:38:34 thanatos kernel: usb.c: USB device not accepting new
address=6 (error=-110)
Dec  9 17:38:34 thanatos kernel: apm: received system suspend notify
Dec  9 17:38:35 thanatos kernel: apm: received system suspend notify
Dec  9 17:38:36 thanatos kernel: apm: setting state busy



