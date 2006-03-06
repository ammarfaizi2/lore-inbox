Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWCFTJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWCFTJI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWCFTJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:09:08 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:11907
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932253AbWCFTJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:09:07 -0500
Date: Mon, 6 Mar 2006 11:09:02 -0800
From: Greg KH <gregkh@suse.de>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: State of the Linux USB Subsystem for 2.6.16-rc5
Message-ID: <20060306190902.GA7796@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a summary of the current state of the Linux USB subsystem, as of
2.6.16-rc5.

If the information in here is incorrect, or anyone knows of any
outstanding issues not listed here, please let me know.

List of outstanding regressions from 2.6.15:
	- none known.

List of outstanding regressions from older kernel versions:
	- one nasty bug, http://bugzilla.kernel.org/show_bug.cgi?id=6078
	  is plaguing some people since 2.6.15 came out.  Right now some
	  people have reported that 2.6.16-rc5 fixes the issue, and none
	  of the Linux USB developers can duplicate it.  No one has
	  reported that it is still present in 2.6.16-rc5 either, so we
	  don't know if this is fixed yet or not.
	- omninet driver is broken since 2.6.13 or so.  Currently being
	  debugged.

Here is a list of the current outstanding bugs for the USB subsystem as
tracked at bugzilla.kernel.org.  Note that a lot of these are still
sitting in the NEEDSINFO state waiting for people to reply with more
information or testing.  If anyone can help out with any of these,
please add information to the bug reports.

 * 3505 [dbrownell@users.sourceforge.net] - usb-storage since at least
 	 2.6.3: destroy's partitions on hdd and stick.
 * 4724 [vojtech@suse.cz] - USB error causes system to become
 	unresponsive to input.
 * 5086 [greg@kroah.com] - unplugging webcam when stv680 is in use
 	freezes the whole system.
 * 5325 [greg@kroah.com] - Processes in D state after printing big jobs.
 * 5386 [drivers_input-devices@kernel-bugs.osdl.org] - rmmod usbhid
	crashes.
 * 5640 [mdharm-usb@one-eyed-alien.net] - System doesn' shutdown when a
	device is connected to USB 1.1 root hub.
 * 5652 [mdharm-usb@one-eyed-alien.net] - Built in card reader doesn't
	work anymore.
 * 5682 [dbrownell@users.sourceforge.net] - USB hard drive disconnects
	(2.6.7-2.6.13) or is never recognized (2.6.14) with ehci_hcd.
 * 5742 [greg@kroah.com] - Suspend resume does not work on Inspiron 8200
	if usbhid module is loaded.
 * 5744 [dbrownell@users.sourceforge.net] - usbnet connection to sharp
	zaurus SL-5600 buggy since kernel 2.6.14.
 * 5753 [greg@kroah.com] - Problem initializing CSR bluetooth through
	usb.
 * 5777 [greg@kroah.com] - ehci-hcd re-load necessary to use kbd on
	docking station hub.
 * 5835 [dbrownell@users.sourceforge.net] - High Speed USB devices don't
	work when ehci_hcd loaded, work if removed.
 * 5894 [stern@rowland.harvard.edu] - usb-storage freezes during large
	file transfers.
 * 6078 [greg@kroah.com] - USB "device not accepting address XX, error
	-71" problem.
 * 6081 [mdharm-usb@one-eyed-alien.net] - Pendrive (Pentadrive 256MB)
	not working.


Future patches that are currently in my quilt tree (as found at
	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/
) for the USB subsystem:

	- UHCI reworks hopefully making it easier to maintain and fixes
	  a few power management issues
	- kzalloc fixes for the drivers/usb/ tree
	- ehci support for new controller type, and fixes for others.
	- USB gadget driver updates
	- USB video driver additions and updates.
	- HID error handling rework
	- semaphore to mutex rework
	- other minor bugfixes that are not really critical or too big
	  to go into 2.6.16 at this period of time.

No new USB driver API changes are pending that I am aware of.


Was this summary useful for people?  Anything that I should add to it?

thanks,

greg k-h
