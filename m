Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261670AbSIXNGE>; Tue, 24 Sep 2002 09:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261671AbSIXNGE>; Tue, 24 Sep 2002 09:06:04 -0400
Received: from syr-24-92-226-125.nyroc.rr.com ([24.92.226.125]:46883 "EHLO
	mailout6-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S261670AbSIXNGD>; Tue, 24 Sep 2002 09:06:03 -0400
Subject: Polling /proc/apm causes usb hiccups and clock drift
From: James D Strandboge <jstrand1@rochester.rr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Sep 2002 09:12:00 -0400
Message-Id: <1032873120.3056.7.camel@sirius.strandboge.cxm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently purchased a usb webcam and found that polling /proc/apm
causes the webcam in xawtv to skip.  I can do this either by doing 'cat
/proc/apm' or using the gnome battstat-applet.  Syslog says:

Sep 23 10:14:17 sirius kernel: usb-uhci.c: iso_find_start: gap in
seamless isochronous scheduling
Sep 23 10:14:18 sirius kernel: quickcam: too little data by 48260
Sep 23 10:14:18 sirius kernel: quickcam: failed qc_imag_convert()=-90


Disabling the battstat-applet and not touching /proc/apm lets xawtv work
fine without the above errors.  Polling /proc/apm also causes clock
drift.

I have a Dell Inspiron 8200 laptop (1.6Ghz Pentium 4).  Using kernel
2.4.18-686 from debian.  I read that this happened to people in the 2.2
series.  Is this a kernel apm bug or BIOS problem?  Do I just have to
live with it?

Thanks,

Jamie Strandboge

-- 
Email:        jstrand1@rochester.rr.com
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A

