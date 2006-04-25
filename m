Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWDYMOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWDYMOL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 08:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWDYMOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 08:14:11 -0400
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:979 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP id S932204AbWDYMOL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 08:14:11 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: problems with printk's
Date: Tue, 25 Apr 2006 17:39:58 +0530
Message-ID: <4F36B0A4CDAD6F46A61B2B32C33DC69C02502AEE@BLR-EC-MBX03.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: problems with printk's
Thread-Index: AcZoYIv0/DBDDHDHRv29TYxz7NRelwAAAmNw
From: <biswa.nayak@wipro.com>
To: <vshrirama@gmail.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Apr 2006 12:13:48.0388 (UTC) FILETIME=[B4F79A40:01C66861]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
  When i see the output of the driver using dmesg

  Only some of the prints are visible (some of them are not printed even
though they
   must get printed. i dont know why this is happening.

  Is there any limit on printk (like number of messages....)


  How do i disable (ie printk should print irrespective of any limit or
anything).


Please check '/proc/sys/kernel/printk_ratelimit' and
'/proc/sys/kernel/printk_ratelimit_burst'. The printk_ratelimit tells
your system to stop logging messages for 'n' number of seconds and
printk_ratelimit_burst tells the number of messages to allow before rate
limiting. You can change these values to allow more messages.

Warning: You can generate so many messages that the system can get
unresponsive, and the buffer for kernel log message is also of fixed
sized circular buffer. So if you write too many messages, you might
overwrite some of your old useful logs too. Hope this helps.

~Biswa
