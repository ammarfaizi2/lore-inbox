Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314488AbSDRXKt>; Thu, 18 Apr 2002 19:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314489AbSDRXKs>; Thu, 18 Apr 2002 19:10:48 -0400
Received: from smtp.comcast.net ([24.153.64.2]:25430 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S314488AbSDRXKr>;
	Thu, 18 Apr 2002 19:10:47 -0400
Date: Thu, 18 Apr 2002 19:10:42 -0400
From: Michael West <neovorbis@comcast.net>
Subject: Possible bug in USB or HID on asus mobo with via kt266 a chipset
To: linux-kernel@vger.kernel.org
Message-id: <3CBF5272.3030203@comcast.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020313
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I recently changed motherboards on my linux box and one of my hid 
controllers (a psx-usb converter) stopped functioning correctly.  I was 
running a 2.4.18 kernel on both boards, and with the new asus board, 
apps reading from the /dev/input/js0 file seem to halt after the first 
19 joystick messages are read.  I tried reproducing the problem on other 
kernel versions, and experienced the same problem with a smattering of 
previous kernels.  I'm using a hid mouse, as well as another hid 
controller, and both work correctly.  Not sure if its related or not, 
but I also seem to have some apparent irq problems, as newly plugged in 
usb devices (any) and by that I mean after the usb-uhci or uhci driver 
is loaded, throw "USB device not accepting new address - * (error = 
-110)" errors.  The situation in 2.4.19-pre2 changed a bit by completely 
breaking the psx-converter (joydev driver assigns no device) only on 
usb-uhci.  pre3 has the same origional problem, as well as 4 and 5. 
 Pre6 and Pre7 seem to completely break all usb hid devices.  The irq 
(or whatever) problems go away and devices are hotplugged fine, but no 
hid devices are ever registered.  Sorry for my infamiliarity with the 
linux kernel source and terminology.  Thanks in advance.
 Michael


