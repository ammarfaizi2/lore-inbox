Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966225AbWKYQty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966225AbWKYQty (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 11:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966654AbWKYQty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 11:49:54 -0500
Received: from firewall.rowland.harvard.edu ([140.247.233.35]:17007 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S966225AbWKYQtx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 11:49:53 -0500
Date: Sat, 25 Nov 2006 11:49:52 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Ed Sweetman <safemode2@comcast.net>
cc: Gene Heskett <gene.heskett@verizon.net>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.19-rc5-mm2 : usb keeps resetting usb
 keyboard.
In-Reply-To: <45684360.1060801@comcast.net>
Message-ID: <Pine.LNX.4.44L0.0611251125230.5173-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2006, Ed Sweetman wrote:

> Gene Heskett wrote:
> > On Friday 24 November 2006 22:41, Ed Sweetman wrote:
> >   
> >> I just upgraded from a ps2 keyboard to usb and have been getting these
> >> messages seemingly randomly, which also corresponds to whatever key i'm
> >> pressing at the time they occur to act like it's stuck down.
> >>
> >> usb 2-2: reset low speed USB device using ohci_hcd and address 3
> >> usb 2-2: reset low speed USB device using ohci_hcd and address 3
> >> usb 2-2: reset low speed USB device using ohci_hcd and address 3
> >> usb 2-2: reset low speed USB device using ohci_hcd and address 3
> >> usb 2-2: reset low speed USB device using ohci_hcd and address 3
> >> usb 2-2: reset low speed USB device using ohci_hcd and address 3
> >> usb 2-2: reset low speed USB device using ohci_hcd and address 3
> >>
> >> (repeated a few hundred times )
> >>
> >>     
> > All the data below doesn't point to the culprit.  
> >
> > I also have this, and I'd bet the common point is going to be an M$ 
> > wireless mouse like I have.  The mouse works ok as near as I can tell, so 
> > I'm not sure of the exact cause.
> >
> > To verify, unplug the receiver for that mouse, wait 5secs, and plug it 
> > back in, which if thats it should move the mouse, and the log message to 
> > a higher number on the usb tree.
> >
> > Also, FWIW dear lkml readers, my logs have been contaminated with this 
> > since about a year ago, running kernel.org kernels on an FC2 system, but 
> > using the latest FC6 non-xen kernel.
> >   
> I dont have a wireless usb mouse or any hardware from microsoft 
> running.  My usb mouse is a standard logitech that i've been using for a 
> couple years.   I haven't had these errors in my log before installing 
> my usb keyboard. 
> 
> These are the only usb devices in the system.

Complaining about the messages in your log doesn't do any good.  You need 
to address the real problem, which is why your keyboard keeps needing to 
be reset.

To get more information about the problem, you could try building a kernel 
with CONFIG_USB_DEBUG turned on.  Perhaps even more informative, you could 
use the usbmon facility (see the instructions in 
Documentation/usb/usbmon.txt).  To keep the trace simple, you should 
unplug all USB devices except the one you're testing.

Alan Stern

