Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVCKU36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVCKU36 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 15:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVCKU1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 15:27:14 -0500
Received: from [160.45.44.199] ([160.45.44.199]:13981 "EHLO elderorb.fefe.de")
	by vger.kernel.org with ESMTP id S261427AbVCKUVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 15:21:41 -0500
Date: Fri, 11 Mar 2005 20:21:23 +0000
From: Felix von Leitner <felix-linuxkernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11: USB broken on nforce4, ipv6 still broken, centrino speedstep even more broken than in 2.6.10
Message-ID: <20050311202122.GA13205@fefe.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux is getting less and less usable for me. :-(


My new nForce 4 mainboard has 10 or so USB 2.0 outlets.  In Windows,
they all work.  In Linux, two of them work.  Putting my USB stick or
anything else in one of the others produces nothing in Linux.
Apparently no IRQ getting through or something?

This is what /proc/interrupts has to say:

  177:    9503618   IO-APIC-level  ohci_hcd, eth0

These are the USB boot messages:

  usbcore: registered new driver usbfs
  usbcore: registered new driver hub
  ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
  ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
  hub 1-0:1.0: USB hub found
  ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
  ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
  hub 2-0:1.0: USB hub found
  usbcore: registered new driver usblp
  drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
  Initializing USB Mass Storage driver...
  usb 2-4: new low speed USB device using ohci_hcd and address 2
  usbcore: registered new driver usb-storage
  USB Mass Storage support registered.
  input: USB HID v1.10 Mouse [B16_b_02 USB-PS/2 Optical Mouse] on
  usb-0000:00:02.0-4
  usbcore: registered new driver usbhid
  drivers/usb/input/hid-core.c: v2.0:USB HID core driver
  HUB0 XVR0 XVR1 XVR2 XVR3 USB0 USB2 MMAC MMCI UAR1

As you can see, it appears to work in principle.



Now about IPv6: npush and npoll are two applications I wrote.  npush
sends multicast announcements and opens a TCP socket.  npoll receives
the multicast announcement and connects to the source IP/port/scope_id
of the announcement.  If both are run on the same machine, npoll sees
the link local address of eth0 as source IP, and the interface number of
eth0 as scope_id.  So far so good.  Trying to connect() however hangs.
Since this has been broken in different ways for as long as I can
remember in Linux, and I keep complaining about it every half a year or
so.  Can't someone fix this once and for all?  IPv4 checks whether we
are connecting to our own address and reroutes through loopback, why
can't IPv6?



Finally Centrino SpeedStep.
I have a "Intel(R) Pentium(R) M processor 1.80GHz" in my notebook.
Linux does not support it.  This architecture has been out there for
months now, and there even was a patch to support it posted here a in
October last year or so.  Linux still does not include it.  Until
2.6.11-rc4-bk8 or so, the old patched file from back then still worked.
Now it doesn't.  Because some interface changed.  Now what?  Using a
Centrino notebook without CPU throttling is completely out of the
question.  Linux might as well not boot on it at all.



Did I mention that I'm really tired of you putting stones into ATI's
way?  You might believe you have a right to piss everyone off, after all
people get what they paid for.  Or maybe you think you are on a crusade
to promote open source software.  But if you keep alienating me (I'm a
software developer) like this, I spend more time working around this
bullshit and less time writing free software.  In the end, everyone
loses.  I sincerely hope some day you people are done pissing in the
pool and can create at least some semblance of semi-stable APIs.  This
house is never going to be safe for living until you stop digging around
the foundation.

You know, people are actually spending time (and money!) to learn how to
write Linux kernel modules.  And all this API shifting makes sure their
knowledge is completely obsolete a few months down the road.  That's not
how you create a community of people working on a shared goal.


Enough ranting for today.  Sigh.

Felix
