Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWE3LR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWE3LR4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 07:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWE3LR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 07:17:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4011 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932259AbWE3LRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 07:17:55 -0400
Date: Tue, 30 May 2006 13:17:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: Netdev list <netdev@vger.kernel.org>, Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Subject: zd1201 & ipw2200 problems
Message-ID: <20060530111712.GA32054@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I see some strange problems with zd1201. (Ccing greg, he seen
something similar).

Wireless LAN is configured on eth1 (ipw2200) and works. I insert
zd1201 usb wireless card, and pings stop. I do not have (or should not
have) any hotplug scripts doing anything. Leds on zd1201 light up.

If I unplug zd1201, pings immediately continue.

If I issue iwlist wlan0 scan, zd1201 discovers some networks, its led
goes out, and ipw2200 ping immediately continue (ipw2200 starts to
work).

Now... what is going on? Any ideas how to debug it?

Plus, zd1201 does not work on sharp zaurus (pxa arm-based)
machine. (Any idea if that is little or big endian?). It is detected
okay, lights light up, but iwlist wlan0 scan produces no results.

								Pavel

pavel@amd:~$ cat /proc/interrupts
           CPU0
  0:     776518          XT-PIC  timer
  1:      12266          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:     123162          XT-PIC  acpi
 11:      48021          XT-PIC  ohci1394, yenta, yenta,
ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3,
uhci_hcd:usb4, Intel 82801DB-ICH4, ipw2200
 12:      11315          XT-PIC  i8042
 14:      21677          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0
pavel@amd:~$


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
