Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265026AbSKAOVa>; Fri, 1 Nov 2002 09:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265031AbSKAOVa>; Fri, 1 Nov 2002 09:21:30 -0500
Received: from pcp748446pcs.manass01.va.comcast.net ([68.49.120.237]:26083
	"EHLO pcp748343pcs.manass01.va.comcast.net") by vger.kernel.org
	with ESMTP id <S265026AbSKAOV3>; Fri, 1 Nov 2002 09:21:29 -0500
Date: Fri, 1 Nov 2002 09:27:51 -0500
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.4[3-5] usb problems
Message-ID: <20021101142751.GA908@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.62
Reply-To: Matthew Harrell 
	  <mharrell-dated-1036592872.f6edc2@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A few different problems.  First, when I use my USB hub then I get this 

  drivers/usb/core/hub.c: new USB device 00:11.2-1, assigned address 2
  drivers/usb/core/hub.c: USB hub found at 1
  drivers/usb/core/hub.c: 9 ports detected
  drivers/usb/core/hub.c: new USB device 00:11.2-1.4, assigned address 3
  drivers/usb/core/hub.c: USB hub found at 1.4
  drivers/usb/core/hub.c: 3 ports detected
  drivers/usb/core/hub.c: new USB device 00:11.2-1.7, assigned address 4
  drivers/usb/core/hub.c: new USB device 00:11.2-1.8, assigned address 5
  drivers/usb/input/hid-core.c: ctrl urb status -32 received
  drivers/usb/input/hid-core.c: usb_submit_urb(ctrl) failed

and none of the USB devices show up at all.  But, when I plug the keyboard
and mouse in without the hub they work fine.

For background I'm using a MAC USB keyboard (w/passive hub) and a Logitech
Trackball plugged into the keyboard.  When I plug the keyboard into the 
computer then both work fine.  When I unplug them I get 

  drivers/usb/core/usb.c: USB disconnect on device 2
  drivers/usb/core/usb.c: USB disconnect on device 3
  drivers/usb/core/usb.c: USB disconnect on device 4

and subsequent plugins of the devices get 

  drivers/usb/core/hub.c: new USB device 00:11.2-1, assigned address 5
  drivers/usb/core/hub.c: new USB device 00:11.2-1, assigned address 6

but the devices never work.

Finally, I've noticed a few times that the mouse has taken a vacation - i.e.
I move it and nothing happens.  This goes on for about twenty seconds and then
all the movements in did in the interum start happening.  During this twenty
seconds my built-in PS/2 mouse works fine.  Oh, and I get no kernel output 
from any of this.

My config can be found here

        http://alecto.bittwiddlers.com/defconfig

Let me know if there's any other information I can provide

-- 
  Matthew Harrell                          Friends don't let friends do DOS
  Bit Twiddlers, Inc.                 
  mharrell@bittwiddlers.com     
