Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267766AbUGWOwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267766AbUGWOwj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 10:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267770AbUGWOwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 10:52:39 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:62122 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S267766AbUGWOwg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 10:52:36 -0400
Subject: Re: User-space Keyboard input?
From: Marcel Holtmann <marcel@holtmann.org>
To: Mario Lang <mlang@delysid.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87bri6n7nz.fsf@lexx.delysid.org>
References: <87y8lb80yj.fsf@lexx.delysid.org>
	 <1090580051.4791.24.camel@pegasus>  <87bri6n7nz.fsf@lexx.delysid.org>
Content-Type: text/plain
Message-Id: <1090594355.4791.56.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 23 Jul 2004 16:52:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

> >> I'm working on BRLTTY[1], a user-space daemon which handles braille displays
> >> on UNIX platforms.  One of our display drivers recently gained the ability
> >> to receive (set 2) scancodes from a keyboard connected directly to the display.
> >> This is a very cool feature, since the display in question has
> >> a bluetooth interface, making it effectively into a complete wireless
> >> terminal (input and output through the same connection).
> >
> > tell me more about this Bluetooth device.
> 
> Its a Braille Star 40 from HandyTech.  Originally sold, the device had two
> alternative ports, serial or USB.  They recently offered an additional
> bluetooth module.  I don't really know what you want to know though :-).

what kind of profiles do this Bluetooth module support? Is it a HID
compatible device or do it uses a vendor specific protocol? Do you
tested it with Linux?

> >> However, this creates some problems.  First of all, we now have to deal
> >> with keyboard layouts.  Additionally, since we currently insert via
> >> TIOCSTI I think this might get problematic as soon as one switches
> >> to an X Windows console and modifiers come into play.
> >> 
> >> Does anyone know (and can point me into the right direction) if
> >> Linux has some mechanism to allow for user-space keyboard data to
> >> be processed by the kernel as if it were received from the system
> >> keyboard?  I.e., keyboard layout would be handled by the same
> >> mapping which is configured for the system.
> >
> > Take a look at the user level driver support (uinput).
> Yup, thats it, thanks.  Now I just need to find some example code on how
> to use it :-).

The BlueZ CVS repository utils2 contains the old bthid code that makes
use of the uinput kernel module.

Regards

Marcel


