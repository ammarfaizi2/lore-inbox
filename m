Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbUCPXN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbUCPXN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:13:27 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:23489 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S261794AbUCPXN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:13:26 -0500
Subject: EHCI/BIOS issues.
From: Plaz McMan <PlazMcMan@Softhome.net>
To: linux-kernel@vger.kernel.org
Message-Id: <1079479132.2169.9.camel@ansel.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 15:18:52 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware of interest:
EPoX EP-8RDA mobo, recent BIOS (last few months)
Misc. USB mass storage devices (dock iPod, Zip 250)
---
Kernel 2.6.4
---

With built-in support for EHCI and OHCI:
When booting the computer with USB storage devices attached, I end up
having no USB support from Linux. The BIOS detects the USB devices, so
my dmesg contains a line such as "Can't TakeOver USB!".

With only support for EHCI, USB doesn't work at all.

With built-in support for OHCI and modular support for EHCI, this is
fixed - I just modprobe ehci-hcd, and all is well (15 MB/s for my iPod -
slow hard drive, but too fast for USB 1.1).

So, is EHCI trying to grab USB before OHCI? Everything works fine if the
BIOS has no reason to take control of USB (e.g., USB disks).

The workaround is quite acceptable in my opinion, as performance is
ultimately not noticeably different.

Thanks,
-Brannon Klopfer

