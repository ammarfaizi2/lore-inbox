Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVB0NJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVB0NJk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 08:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVB0NJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 08:09:40 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:44745 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261382AbVB0NJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 08:09:37 -0500
From: Holger Klawitter <listen@klawitter.de>
To: linux-kernel@vger.kernel.org
Subject: usbnet not being loaded in 2.6.11-rc4/5
Date: Sun, 27 Feb 2005 14:06:20 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502271406.21100.listen@klawitter.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:c3f09bf0911098d231c83d2978ee4594
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

After updrading the kernel from 2.6.10 to 2.6.11-rc4 (also tried rc5) the 
usbnet module is not being loaded when the Sharp Zaurus C860 (Sharp ROM) is 
being plugged in at usb. It used to work fine in 2.6.10.

- I tried 4 different machines (all i386) all the same result (Chipsets were 
"Intel ICH5","Intel ICH4","Intel 82801BA" and "ALI USB 1.1 r3 (Acer)")

- All systems were i386, Debian unstable (sid) using hotplug and udev.

- The Zaurus itself is being correctly identified in all systems.

- The kernel settings did not change across 2.6.10 vs. 2.6.11 (upgrade by 
patch) ALl systems were booting into the same rootfs (no initrd)

- Manual loading of usbnet does not bring "usb0" into existance either.

- Other USB devices (I tried usb_storage, pl2303) had no problems with 2.6.11.

- Enabling DEBUG in hotplug reveals the message
 "... no modules for USB product 4dd/9031/0"

- The modules.usbmap entries in 2.6.10 and 2.6.11 are both the same with one 
exception: the bInterfaceSubClass is 0x0a in 2.6.10 but 0x06 in 2.6.11

What's broken there? (From glacing at usbnet.c it almost looks like Zaurus has 
been blacklisted, however then I don't grok why it's still in the config and 
the modules.usbmap).

Regards
  Holger Klawitter (not subscribed)
