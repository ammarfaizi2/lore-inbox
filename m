Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbTJCNBs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 09:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263739AbTJCNBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 09:01:48 -0400
Received: from mailhost.cs.auc.dk ([130.225.194.6]:40151 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S263665AbTJCNBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 09:01:46 -0400
Subject: Floppy disk working constantly
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1065186072.6517.44.camel@rade7.s.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 03 Oct 2003 15:01:12 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am testing the 2.6.0-test6 and I noticed that my floppy driver is
working constantly.

More details:

I have compiled the floppy driver as a module:
CONFIG_BLK_DEV_FD=m

I noticed that the floppy drive was constantly on and when a disk was in
it was acting as it was reading (but no request to do so was sent).

Then I noticed that the module was not loaded, so I did a "modprobe
floppy" and instantly the floppy driver shot down and act normally...

I guess that this problem has been already reported, but I didn't manage
to find it in the mailing-list archive, so I am submitting it in doubt.

Here is my lspci:

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host
Bridge (rev 04)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge
(rev 04)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 05)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05)
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 05)
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 05)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW
[Radeon 7500]
02:03.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)
02:04.0 USB Controller: NEC Corporation USB (rev 41)
02:04.1 USB Controller: NEC Corporation USB (rev 41)
02:04.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
02:0c.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 0c)


If any more informations (or patches to test) are needed, feel free to
ask.

Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.auc.dk

