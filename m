Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265668AbUFOOfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265668AbUFOOfh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 10:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265676AbUFOOfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 10:35:36 -0400
Received: from web81309.mail.yahoo.com ([206.190.37.84]:30075 "HELO
	web81309.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265668AbUFOOfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 10:35:25 -0400
Message-ID: <20040615143525.18034.qmail@web81309.mail.yahoo.com>
Date: Tue, 15 Jun 2004 07:35:25 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: HID vs. Input Core
To: Karel =?ISO-8859-1?Q?=20=22Kulhav=FD=22?= <clock@twibright.com>,
       Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, Lubomir.Prech@mff.cuni.cz
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 Karel Kulhavý wrote:
> On Tue, Jun 15, 2004 at 03:41:53PM +0200, Helge Hafting wrote:
> > On Tue, Jun 15, 2004 at 12:58:00PM +0000, Karel Kulhavý wrote:
> > > Hello
> > >
> > > I would like to know what's the difference between
> > > Input Core (CONFIG_INPUT) and USB HID (CONFIG_USB_HID) in 2.4.25
> > >
> > > They seem to enable the same thing - USB HID. However I don't
> > > know which one should I enable or if I should enable both. I find
> > > existence of two options with seemingly the same function confusing.
> > >
> > They aren't the same:
> >
> > Enable CONFIG_INPUT if you want to use any input devices _at all_,
> > i.e. if you plan on using some kind of keyboard, mouse, joystick, ...
> > Enable CONFIG_USB_HID also, _if_ such a device might be connected
> > via USB.  (Older devices are not USB, newer may be usb.)
> 
> Bugreport:
> 
> CONFIG_INPUT Help says
> "Say Y here if you want to enable any of the following options for USB
> Human Interface Device (HID) support".
> 
> Helge Hafting from linux-kernel says that CONFIG_INPUT controls enabling
> input devices at
> all. These two statements are in a direct contradiction. (See above).
> 

Well, kind of... Helge Hafting is 100% correct in 2.6 sense where all
input devices have been switched to use input core. In 2.4 only USB input
devices use input core while other devices (like PS/2 mouse) use legacy
interfaces like /dev/psaux.

So for 2.4 you need to enable HID to turn on hardware driver for HID
devices and you want to enable input core to allow data from your USB
device to be awailabe to userspace.

Dmitry
