Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270232AbUJUHmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270232AbUJUHmx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270415AbUJUHmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:42:16 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:49563 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270392AbUJUHaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 03:30:12 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 0/7] New input patches
Date: Thu, 21 Oct 2004 02:23:45 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410210223.45498.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

I have some more input patches for you. Please let me know if you like any
of these and I will push them onto bkbits.

01-whitespace.patch
	- get rid of trailing whitespace in sermouse.c and vsxxxaa.c

02-remove-class-device-on-disconnect.patch
	- when hardware device associated with evdev, mousedev, joydev or
          tsdev is disconnected remove class device right away, do not wait
	  till the last user of corresponding /dev/input/ device closes it.
          It allows hardware drivers be unloaded at any time.
 
03-link-input_dev-and-serio.patch
	- Link input_dev->dev and serio.dev so when corresponding class
	  devices are created they are linked (device, driver) to their
          serio driver and device.

04-i8042-debug.patch
	- Alow activate i8042 debugging without recompiling, I am tired of
	  asking people to edit/recompile.
 
05-i8042-old-pm-remove.patch
	- get rid of old-style PM handling as APM calls device_suspend
	  so we actually were doing the same work twice.

06-i8042-remove-reboot-notifier.patch
	- since i8042 now has shutdown driver core method we do not need
	  reboot notifier, i8042_shutdown will do the work.

07-input-remove-pm_dev.patch
	- pm_dev is deprecated and nobody except for h3600 (which does not
          even compile) uses it, remove from input core.

Thanks!

-- 
Dmitry
