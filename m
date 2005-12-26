Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVLZTSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVLZTSX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 14:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbVLZTSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 14:18:23 -0500
Received: from smtp6.libero.it ([193.70.192.59]:2531 "EHLO smtp6.libero.it")
	by vger.kernel.org with ESMTP id S932102AbVLZTSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 14:18:23 -0500
Date: Mon, 26 Dec 2005 20:19:01 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 0/7] RTC subsystem
Message-ID: <20051226201901.54288289@inspiron>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 Hello,

  thanks to all the suggestions I've got, I've
 updated my proposal [1] for an RTC subsystem.

  I tried to implement locking wherever necessary.
 I'm on vacations right now and I don't have all the feedback
 emails at handy, so I'm sure I've forgot something.

  I've left some XXX in the points where I have
 doubts.

  The dev interface now supports multiple RTCs and
 hotplug events are generated whenever an RTC is
 added/removed.

 Those udev lines can be used to create the device nodes

ACTION=="add", SUBSYSTEM=="rtc", ENV{MAJOR}=="[0-9]*",  NAME="rtc%m"
ACTION=="add", SUBSYSTEM=="rtc", ENV{MINOR}=="0",       SYMLINK+="rtc"

  I also added a test device/driver which can be used 
 to excercize the APIs. This device can also generate
 interrupts using the sysfs interface (more details
 in the path).

  hwclock seems to work fine, both in polling
 and IRQ modes.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

[1]
	http://lkml.org/lkml/2005/12/20/220
