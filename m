Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265060AbUHSKc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUHSKc1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 06:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUHSKc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 06:32:27 -0400
Received: from mail.on.net.mk ([217.16.69.3]:18622 "EHLO on.net.mk")
	by vger.kernel.org with ESMTP id S265060AbUHSKcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 06:32:25 -0400
From: "Damjan Georgievski" <gdamjan@mail.net.mk>
Subject: 2.6.7, apm suspend and ReiserFS bug?
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro WebUser Interface v.4.1.8
Date: Thu, 19 Aug 2004 12:31:33 +0200
Message-ID: <web-17272777@on.net.mk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel is vanilla 2.6.7.
The hardware is a p3-650mhz laptop with intel-bx chipset
and usb1 (uhci_hcd).

This is the problem, I had a 2.5" ide hard disk in a
external USB box, it works with usb-storage.

The hdd has two reiserfs filesystems on it. I had one of
them mounted (that was my old /home) when I suspended the
laptop (with apm --suspend, that's the only one working on
the laptop). After wakeing the laptop this is the error
message I got in "dmesg":
http://softver.org.mk/damjan-files/reiserfs-bug.txt

After that I couldn't umount that partition, but even worse
I couldn't umount ANY other ReiserFS partitions (root and
/home on the internal hdd). All the umount commands became
dormant, and also shutdown or reboot were dormant. I had to
do a hardware-reset. I don't think one block device going
bad, should affect other filesystems, no. Is this a bug?

This is my kernel config if its of any relevance:
http://softver.org.mk/damjan-files/01091369906/config
(note: even though this kernel has ACPI builtin, ACPI
doesn't work on the laptop since the bios is to old. so I'm
using APM).
