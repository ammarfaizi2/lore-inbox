Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266895AbUHaKJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266895AbUHaKJt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 06:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267701AbUHaKJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 06:09:48 -0400
Received: from mail.humboldt.co.uk ([81.2.65.18]:26264 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S266895AbUHaKJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 06:09:47 -0400
Subject: Userspace Camera Drivers
From: Adrian Cox <adrian@humboldt.co.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1093946986.16190.96.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 11:09:46 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pwcx debate has made me wonder why USB camera drivers are in the
kernel. I can think of two reasons:
1) libusb doesn't support isochronous transactions.
2) V4L is the only generally accepted video capture API.

IEEE1394 cameras took a different path:
1) An isochronous transaction manager for kernel space -
http://www.linux1394.org/video1394.php
2) A userspace library to access the cameras -
http://sourceforge.net/projects/libdc1394/

Problem 1 may be fixed by Mac Cody's code, though I've not tried this
myself yet:
http://sourceforge.net/mailarchive/message.php?msg_id=8816704

Is there an existing library that would handle problem 2? Gstreamer
might do it, but the documentation is much more oriented to media
playback than machine vision.

- Adrian Cox
Humboldt Solutions Ltd.


