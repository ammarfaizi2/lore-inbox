Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbTD2XED (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 19:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTD2XED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 19:04:03 -0400
Received: from [64.246.42.47] ([64.246.42.47]:3747 "EHLO euroseek.com")
	by vger.kernel.org with ESMTP id S262049AbTD2XEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 19:04:01 -0400
From: "Virgil" <yyz001@euroseek.com>
Subject: Linux 2.4.x on HP ze4145
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro Web Mailer v.3.5.9
Date: Tue, 29 Apr 2003 18:06:53 -0400
Message-ID: <web-3382698@euroseek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This particular laptop has, among other things, an Athlon 
XP1800 mobile processor with an ALI USB 1.1 controller, an 
ATI Northbridge, an ATI 320 (CAB0) videocard and a 
synaptics PS/2 touchpad. In the following I'll try to best 
describe the problem I have. (Please note that I am not a 
developer, although I dream about writing a driver for the 
oz6912 PCMCIA controller this laptop came with).

Kernel versions covered: 2.4.19 - 2.4.21pre6 patched with 
acpi-patch. Distribution: none (LFS 4.0). For 
distributions, I tried RH 7.1, 7.3 and 8.0 but all fail 
installing if I don't pass pci=off during installation. 
After reboot and stock kernel I end up with the problem 
below, which does not dissappear when custom compiling the 
kernel.

1) I compiled the kernel with usb support built-in (not as 
modules). Upon booting and entering the login prompt, the 
keyboard is blocked (i.e. I can't write anything with it). 
If I press the power button, the computer enters runlevel 
0 (so it is not frozen) and powers off.

2) Recompile the kernel with usb as modules (usbcore and 
usb-ohci) and do a script in /etc/rc.d/init.d/ to load the 
modules at boot time. Symptoms stay as above.

3) Remove the script from /etc/rc.d/rc3.d (e.g.). Boot. 
Login as root. The keyboard works (yee!). Do cat 
/dev/mouse. Keyboard no longer works (all three LEDs light 
up). Reboot.

4) Do step 3 above but don't cat the mouse anymore. 
Instead do modprobe usbcore and modprobe usb-ohci. The 
keyboard is NOT blocked. Do cat /dev/mouse. The mouse 
works (yee). Do mount -t usbdevfs none /proc/bus/usb. The 
USB filesystem is initialised and the USB works 
beautifully (tested with a digital camera, a scanner, and 
currently with an Apple USB mouse and Apple USB keyboard).

Did any1 have a similar problem? I posted this message 
about three months ago on the linux-usb, omnibook and 
finally last week on linux-laptop, with no success :-( At 
this point I am completely out of ideas, so I'd appreciate 
any help.

Virgil
-------------------------------------------------
Search for pictures with Euroseek Image Search
http://euroseek.com/image_search/

Euroseek Translation
http://www.euroseek.com/translator/


