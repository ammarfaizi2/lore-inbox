Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263139AbTDBTYL>; Wed, 2 Apr 2003 14:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263142AbTDBTYL>; Wed, 2 Apr 2003 14:24:11 -0500
Received: from [66.70.28.20] ([66.70.28.20]:56327 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S263139AbTDBTYK>; Wed, 2 Apr 2003 14:24:10 -0500
Date: Wed, 2 Apr 2003 21:37:31 +0200
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: USB Mouse issue
Message-ID: <20030402193731.GA1273@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :))

    I've recently installed a USB mouse, and I want it to run with
HIDBP. I have USB and USB_UHCI (and USB_DEVICEFS) built into the
kernel and I successfully use my printer thru the USB interface. No
problem with that, with a 2.4.18 kernel.

    The USB mouse support I have it as a module, as well as the input
core support. Well, I do:
    $ insmod input
    $ insmod usbmouse

    and I have a char device with major 180, minor 16 (first USB
mouse, per Documentation/devices.txt). I load the modules by hand
because the default 'above' settings for modprobe with this modules
want to install keybdev and others.

    My system log says:

<30>Apr  2 21:30:32 kernel: usb.c: registered new driver usb_mouse
<30>Apr  2 21:30:32 kernel: input0: Logitech USB-PS/2 Trackball on usb1:2.0
<30>Apr  2 21:30:32 kernel: usbmouse.c: v1.6:USB HID Boot Protocol mouse driver

    that is, seems to detect the mouse properly, doesn't it?

    But when I do 'gpm -m mouse -p -t imps2' I have a 'ENODEV'. Same
if I try to open 'mouse' with cat or the like, always ENODEV:

    crw-r--r--  1 root root 180,16 mouse

    Is the node correct? I'm doing all this as root, so no permission
problems should arise :? and I've tested too 13,32 and 13,63 nodes,
too, no one worked :( (same: ENODEV).

    I don't want to use the /dev/input/... interface, since this
mouse should work with HIDBP. Must I use any additional module? If
so, why the kernel is not telling me anything about unresolved
symbols, lack of support, etc...? Must I use another minor?

    Thanks in advance :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://www.pleyades.net/~raulnac
