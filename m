Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVLKTlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVLKTlj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 14:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVLKTlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 14:41:39 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:50356 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1750827AbVLKTlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 14:41:39 -0500
From: "ph0x" <ph0x@freequest.net>
To: "'Jesse Brandeburg'" <jesse.brandeburg@gmail.com>
Cc: <linux-kernel@vger.kernel.org>,
       "'Kernel Netdev Mailing List'" <netdev@vger.kernel.org>
Subject: RE: PROBLEM: bug in e1000 module causes very high CPU load
Date: Sun, 11 Dec 2005 20:41:18 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <4807377b0512101416t2f3a04c5ua6859ab3d99e8d07@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcX92MKgPdY07loVR4GgT+V/+wn0/gAr1/cg
Message-Id: <20051211194114.GBCH17186.mxfep02.bredband.com@ph0x>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>please send the output of cat /proc/interrupts, I'm worried you have
>an issue due to interrupt sharing.  If it does fail again and is still
>usable, please send the output of ethtool -d eth0, and ethtool -S
>eth0. Also, is there any chance you can try the 6.2.15 driver from
>http://prdownloads.sf.net/e1000

ph0x@orion:~$ cat /proc/interrupts
           CPU0
  0:  113068493          XT-PIC  timer
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:   25386110          XT-PIC  eth1
 11:   29562097          XT-PIC  eth0
 12:     527004          XT-PIC  uhci_hcd:usb1, uhci_hcd:usb2
 14:     565520          XT-PIC  ide0
 15:       1887          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0
MIS:          0

The problem is that the card has never been rendered unusable, it just
starts to have performance issues.
I've compiled the new driver and installed it. I'll schedule a reboot later
this week to get it working.
I've also built 2.6.14.3, which was activeted by a reboot this Saturday.
I'll let you know if the new driver worked.

>do you have a test to reproduce this?

Yes, let the server act as usual, it just starts happening out of the blue.
No new hardware has been added or removed, no new programs has been
installed.
Only thing upgrades was the kernel.

>Thanks, Jesse

Thanks,
Andreas

