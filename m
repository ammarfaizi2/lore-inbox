Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266039AbVBEJXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266039AbVBEJXx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 04:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266036AbVBEJXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 04:23:52 -0500
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:20162 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266499AbVBEJWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 04:22:54 -0500
Date: Sat, 5 Feb 2005 00:16:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: 2.6.11-rc[23]: swsusp & usb regression
Message-ID: <20050204231649.GA1057@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In 2.6.11-rc[23], I get problems after swsusp resume:

Feb  4 23:54:39 amd kernel: Restarting tasks...<3>hub 3-0:1.0:
over-current change on port 1
Feb  4 23:54:39 amd kernel:  done
Feb  4 23:54:39 amd kernel: hub 3-0:1.0: connect-debounce failed, port
1 disabled
Feb  4 23:54:39 amd kernel: hub 3-0:1.0: over-current change on port 2
Feb  4 23:54:39 amd kernel: usb 3-2: USB disconnect, address 2

After unplugging usb bluetooth key, machine hung. Sysrq still
responded with help but I could not get any usefull output.

Parts of .config:
# CONFIG_USB_IRDA is not set
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_MIDI is not set
CONFIG_USB_ACM=y
CONFIG_USB_PRINTER=y
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_RW_DETECT is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
CONFIG_USB_STORAGE_SDDR09=y
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
CONFIG_USB_HID=y

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
