Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318460AbSGSDhC>; Thu, 18 Jul 2002 23:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318461AbSGSDhC>; Thu, 18 Jul 2002 23:37:02 -0400
Received: from mta01ps.bigpond.com ([144.135.25.133]:7154 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S318460AbSGSDhB>; Thu, 18 Jul 2002 23:37:01 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Josh Litherland <fauxpas@temp123.org>, Greg KH <greg@kroah.com>
Subject: Re: USB Keypad
Date: Fri, 19 Jul 2002 13:36:02 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
References: <20020719015232.GA20956@temp123.org> <20020719031000.GA18382@kroah.com> <20020719032008.GA22934@temp123.org>
In-Reply-To: <20020719032008.GA22934@temp123.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207191336.02403.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002 13:20, Josh Litherland wrote:
> On Thu, Jul 18, 2002 at 08:10:00PM -0700, Greg KH wrote:
> > Should work just fine today.  What kind of problems do you have when you
> > try to do it?
>
> Just not getting any events from the keypad.  When I load up evdev, and
> cat the device I get the appropriate gibberish, so the device is
> detected okay.  This is 2.4.18, if that makes a difference for the
> purposes of this discussion.
OK, evdev is on the userspace side of the input core (and USB is on the other).
If evdev reports events (and you can decode them, if you are interested, using
tools available from the linuxconsole CVS), then all is probably well with USB and
the input core.

The obvious error would be not compiling in the input layer keyboard driver (or
not loading the module, whatever). 

If that definately isn't wrong (like lsmod shows the module, or a normal USB
keyboard works fine and the keypad doesn't), then we'll likely need the 
HID descriptors. Probably easiest to get them from evdev using the evtest
tool from linuxconsole CVS.

Brad

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
