Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316424AbSETWcU>; Mon, 20 May 2002 18:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316426AbSETWcT>; Mon, 20 May 2002 18:32:19 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:31251 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316424AbSETWcT>;
	Mon, 20 May 2002 18:32:19 -0400
Date: Mon, 20 May 2002 15:31:32 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Linux-usb-users@lists.sourceforge.net
Subject: What to do with all of the USB UHCI drivers in the kernel?
Message-ID: <20020520223132.GC25541@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 22 Apr 2002 20:18:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, now that 2.5.16 is out, we have a total of 4 different USB UHCI
controller drivers in the kernel!  That's about 3 too many for me :)

So what to do?  I propose the following:

  From now until July 1, I want everyone to test out both the uhci-hcd
  and usb-uhci-hcd drivers on just about every piece of hardware they
  can find.  This includes SMP, UP, preempt kernels, big and little
  endian machines, and loads of different types of USB devices.

  (Note, for those who don't realize it, the uhci-hcd driver is based
  off of the uhci.c driver, and the usb-uhci-hcd driver is based off of
  the usb-uhci.c driver.  Both of these drivers now use the USB HCD
  interface, hopefully reducing some code complexity and size because of
  this.  So this means that the uhci.c and usb-uhci.c drivers are
  going to go away, just like the usb-ohci.c driver did in 2.5.16.)

  Let me (and the linux-usb-devel list) know about any thoughts you have
  pertaining to liking one of the drivers over the other one.  Speed
  tests, size tests, code pretty tests, comment spelling tests,
  documentation tests, you name it, I want to know about it.  If you
  don't want your comments to be public, send them to me directly and I
  will not let anyone else know what you said, but will use the info to
  try to pick which one should stay.

  I will be doing the same thing (running speed tests, and hardware
  tests) and will be publishing those results on the linux-usb-devel
  list for others to verify.

  Then, the week of July 1, I will be taking everyone's comments and
  making a decision about which driver to keep.

thanks,

greg k-h
