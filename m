Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267832AbUG3V0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267832AbUG3V0r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 17:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267848AbUG3V0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 17:26:47 -0400
Received: from host4-67.pool80117.interbusiness.it ([80.117.67.4]:31376 "EHLO
	dedasys.com") by vger.kernel.org with ESMTP id S267832AbUG3V0m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 17:26:42 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] speedy boot from usb devices
From: davidw@dedasys.com (David N. Welton)
Date: 30 Jul 2004 23:25:05 +0200
Message-ID: <87fz79xk5q.fsf@dedasys.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Please CC replies to me - thanks! ]

Hi,

I gather that there isn't much interest in this idea on behalf of the
'mainstream', because initrd is a far more flexible solution, but I
happen to like the idea of booting quickly from a USB device, without
wasting a bunch of time and space for an initrd, and we're using this
in a product as well, so without further ado, I'll point you at

http://dedasys.com/freesoftware/patches/

where you can get blkdev_wakeup.patch

        Works like so: whenever a block device comes on line, it
        signals this fact to a wait queue, so that the init process
        can stop and wait for slow devices, in particular things such
        as USB storage devices, which are much slower than IDE
        devices.  The init process checks the list of available
        devices and compares it with the desired root device, and if
        there is a match, proceeds with the initialization process,
        secure in the knowledge that the device in question has been
        brought up.  This is useful if one wants to boot quickly from
        a USB storage device without a trimmed-down kernel, and
        without going through the whole initrd slog.

Comments, critiques, suggestions and ideas are all welcome.

Thankyou for your time,
-- 
David N. Welton
     Personal: http://www.dedasys.com/davidw/
Free Software: http://www.dedasys.com/freesoftware/
   Apache Tcl: http://tcl.apache.org/
       Photos: http://www.dedasys.com/photos/
