Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932622AbVLFSyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbVLFSyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbVLFSyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:54:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:2721 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932622AbVLFSyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:54:38 -0500
X-Authenticated: #26200865
Message-ID: <4395DE67.4050101@gmx.net>
Date: Tue, 06 Dec 2005 19:54:31 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-usb-devel@lists.sourceforge.net
Subject: usblp suspend failure with 2.6.15-rc5
References: <438F3A2F.5090207@gmx.net>
In-Reply-To: <438F3A2F.5090207@gmx.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since I switched to 2.6.15-rc2-git6, my machine is not able to suspend
anymore if my USB printer is plugged in. The problem is reproducible.

usb 1-2: new full speed USB device using uhci_hcd and address 3
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 proto 2 vid 0x04E8 pid 0x3242
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
PM: Preparing system for mem sleep
Stopping tasks: ==================================================|
usblp 1-2:1.0: no suspend?
Could not suspend device 1-2: error -16
Some devices failed to suspend
Restarting tasks... done


Earlier kernels (2.6.14.2 and before) worked just fine.

A first search suggests this problem was introduced between
2.6.14 and 2.6.15-rc2-git6. Should I try to narrow it down further?


Regards,
Carl-Daniel
