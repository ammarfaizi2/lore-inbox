Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280960AbRKTRvI>; Tue, 20 Nov 2001 12:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281183AbRKTRur>; Tue, 20 Nov 2001 12:50:47 -0500
Received: from 24-148-25-58.na.21stcentury.net ([24.148.25.58]:52849 "EHLO
	danapple.com") by vger.kernel.org with ESMTP id <S280960AbRKTRuj>;
	Tue, 20 Nov 2001 12:50:39 -0500
Message-Id: <200111201750.fAKHoYa03354@danapple.com>
To: linux-kernel@vger.kernel.org
Subject: built-in USB /proc bug
From: "Daniel I. Applebaum" <danapple@danapple.com>
Date: Tue, 20 Nov 2001 11:50:34 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried building a 2.4.13 kernel with USB support as built-in, instead
of modules.  The system worked, and USB devices worked, but there were
no entries in /proc/bus/usb Yes, I had enabled both /proc filesystem
and USB /proc filesystem support.  When the same kernel was built but
with USB support as modules, the /proc/bus/usb entries appear.

Although no expert in these matters, I suspect that when the USB
subsystem is built-in, it is initialized before /proc is mounted, and
the USB /proc filesystem support either turns itself off or puts the
"files" elsewhere.

A viable solution might be to have make menuconfig warn against this
combination.

Dan.

