Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVLUPi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVLUPi7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 10:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVLUPi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 10:38:59 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:9715 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S932440AbVLUPi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 10:38:58 -0500
Date: Wed, 21 Dec 2005 10:39:25 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Another casualty of -rc6
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Reply-to: gene.heskett@verizononline.net
Message-id: <200512211039.25449.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I just noted my toolbar clock was off by about 45 minutes, with
an uptime on -rc6 or 27hrs & change.

A service ntpd restart resets it, but thats temporary.  
Apic is on, and a cat of /proc/interrupts returns this:
          CPU0
  0:   96565780    IO-APIC-edge  timer
  1:      92669    IO-APIC-edge  i8042
  3:         87    IO-APIC-edge  serial
  4:     537421    IO-APIC-edge  serial
  8:      53487    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:    2362430    IO-APIC-edge  ide0
 15:     238356    IO-APIC-edge  ide1
 16:   12702364   IO-APIC-level  ohci_hcd:usb3, eth0
 17:      42635   IO-APIC-level  ehci_hcd:usb1, NVidia nForce2
 18:         22   IO-APIC-level  ohci_hcd:usb2
 19:    6338513   IO-APIC-level  ohci1394, radeon@pci:0000:02:00.0
 20:          0   IO-APIC-level  cx88[0], cx88[0]
NMI:          0
LOC:   93879684
ERR:          0
MIS:          0

But when I looked at the log, it was synched to LOCAL.  I have a script
to enhance the logging, runs at 30 minute intervals, and it was logging 
this:
---------------
     remote           refid      st t when poll reach   delay   offset  jitter
==============================================================================
 ntp2.usv.ro     80.96.120.253    2 u   59   64  377  180.742  -260483 5112.35
 210.118.170.59  211.115.194.21   3 u   24   64  377  248.620  -260423 6261.15
 ns1.dns.pciwest 204.123.2.5      2 u   48   64  377  126.289  -261067 4127.39
*LOCAL(0)        LOCAL(0)        10 l   57   64  377    0.000    0.000   0.001
drift=3.720
     remote           refid      st t when poll reach   delay   offset  jitter
==============================================================================
 ntp2.usv.ro     80.96.120.253    2 u   52   64  377  183.230  -264401 6453.20
 210.118.170.59  211.115.194.21   3 u   18   64  377  249.206  -265488 6445.08
 ns1.dns.pciwest 204.123.2.5      2 u   42   64  377  126.446  -264423 6491.55
*LOCAL(0)        LOCAL(0)        10 l   56   64  377    0.000    0.000   0.001
drift=3.720
-------------
That drift is slightly lower than normal, its usually in the 4.x's.

This is with the newest bios update, which fixed this problem for -rc5.
Looks like reboot time, to -rc5. :(

-- 

Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
