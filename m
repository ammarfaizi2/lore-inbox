Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263312AbTH0MQp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 08:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263335AbTH0MQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 08:16:45 -0400
Received: from smtp-node1.eclipse.net.uk ([212.104.129.76]:52230 "EHLO
	smtp1.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S263312AbTH0MQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 08:16:44 -0400
Date: Wed, 27 Aug 2003 13:13:53 +0100 (BST)
From: Phil Stewart <phil@lichp.co.uk>
X-X-Sender: <phil@henry>
To: <linux-kernel@vger.kernel.org>
Cc: <phil@lichp.co.uk>
Subject: 2.6.0-test4 kernel hangs on loading mouse driver
Message-ID: <Pine.LNX.4.33.0308271256330.527-100000@henry>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm having a problem booting the test4 kernel, which has developed since
patching up from a functional test2 tree (I haven't compiled a test3
kernel on my system, having patched to test3 and then again to test4). The
problem seems to lie with the mouse, which is a USB HID mouse. The kernel
gets as far as loading the hid core at boot time, giving these messages:

drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0: USB HID core driver
mice: PS/2 mouse device common for all mice

The system then hangs.

I'm using an original Athlon (old skool Slot A fragrance) with a VIA
chipset (VT8371 [KX133] north bridge, VT82C686 south bridge), and a
bog-standard USB HID mouse and PS/2 keyboard. Relevant kernel
configuration options are:

CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m

CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_AUDIO=m
CONFIG_USB_STORAGE=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y

Thanks in advance for help with this issue :-)

--
Phil Stewart

PS - I'm not subscribed to the list, so I've CC'd myself into this mail -
please keep me CC'd in if you need me to post any further detail that may
help identify and solve this problem. Thanks!

