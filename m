Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282388AbRKXHe3>; Sat, 24 Nov 2001 02:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282389AbRKXHeT>; Sat, 24 Nov 2001 02:34:19 -0500
Received: from www.transvirtual.com ([206.14.214.140]:26892 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S282388AbRKXHeF>; Sat, 24 Nov 2001 02:34:05 -0500
Date: Fri, 23 Nov 2001 23:33:51 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: First new fbdev driver
Message-ID: <Pine.LNX.4.10.10111232320130.20244-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks!!!

   As some might know I have been working for the last year in my spare
time on the linux console project. Well it ended up as a total rewrite of
the tty/console layer. In the new design the the tty/console layer is
composed of seperate subsystems which can exist independently outside of
the tty layer. Thus the tty layer is constructed from these subsystems.
This makes for a cleaner mor emodular design. Some of things done are:

1) New framebuffer api. This new api allows the fbramebuffer layer to
   exist without a framebuffer console. This makes for a much simpler 
   api and much smaller code. Plus on embedded devices like a iPAQ have
   a VT console doesn't make sense. Okay a stowaway does change that. 
   But it would be nice if the VT system was modular and loadable :-)
   This is what we are working at. Pretty much complete.

2) Moving all the keyboards and other input devices over to the input
   api. Also makes for a nice modular design. Alot of work done.

3) Rewrite of the serial layer to be more like the parport layer. Here
   we have a hardware layer that registers ports and then we bind
   device interface drivers to specific ports. It makes no sense to use
   a serial tty to talk to a serial joystick for example. Plus their is a
   extra cost of going threw needless layers. This is partially complete
   but needs alot fo work.

So expect patches. I also look forward to working with people to port
devices over to these new APIs. Thank you.


