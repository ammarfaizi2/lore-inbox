Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbUCCMp6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 07:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUCCMp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 07:45:58 -0500
Received: from emn-agsl-4744.mxs.adsl.euronet.nl ([212.129.199.68]:22797 "EHLO
	kapteyn.telox.net") by vger.kernel.org with ESMTP id S262470AbUCCMnP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 07:43:15 -0500
Date: Wed, 3 Mar 2004 13:33:40 +0100
From: Wouter Lueks <wouter@telox.net>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: serious 2.6 bug in USB subsystem?
Message-ID: <20040303123340.GH31279@telox.net>
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: ead, and I can do a hard reset.
Content-Disposition: inline
In-Reply-To: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>
X-Operating-System: Linux kapteyn 2.4.18 #1 Wed Jun 11 07:47:21 CEST 2003 i686 GNU/Linux
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 02:35:09PM -0800, David Mosberger wrote:
> One-line summary: plug-in your USB keyboard, see your machine die.
>
> So, I have this non-name USB keyboard (with built-in 2-port USB hub)
> which reliably crashes 2.6.0-test{8,9} on both x86 and ia64.  In
> retrospect, it's clear to me that the same keyboard also occasionally
> crashes 2.4 kernels, but there the problem appears more seldom.
> Perhaps once in 10 reboots and once the machine is booted and the
> keyboard is running, it keeps on working.  The keyboard in question is
> a BTC 5141H.

I am having the same problem as David but with a major difference, the
keyboard doesn't have any problems on either 2.4.21 or windows XP, it
works flawlessly there. I have tested up to 2.6.2 and haven't seen
anything in the changelogs that suggests its fixed in 2.6.3

> In any case, even if the keyboard happened to be completely broken, I
> don't think it should be possible to crash the kernel merely by
> connecting a (potentially) bad USB device, so, regardless, there seems
> to be something off in the 2.6 USB subsystem.
> 
> Here is a more detailed description of how to reproduce the problem
> and the behavior that I'm seeing with 2.6 (I don't think the exact
> kernel version matters much; it definitely happens both with
> 2.6.0-test8 and 2.6.0-test9):
> 
>  1) disconnect the 5141H keyboard
>  2) power on the machine
>  3) boot into Linux 2.6
>  4) connect the keyboard
>  5) see the normal "USB HID" keyboard connection message
>  6) wait a few seconds
>  7) machine is dead

I used the exact same steps and the result is the same, the machine is
dead, and I can do a hard reset.
>
> On x86, I see this message prior to the death of the machine:
>
>  drivers/usb/input/hid-core.c: ctrl urb status -104 received
>  drivers/usb/input/hid-core.c: timeout initializing reports

See the attached dmesg file I get one error more. On top of that I have
enabled usb debugging so perhaps the dmesg file yields more result when
someone who knows this subsystem can see what is happening here.
Personally I lack the experience to fix this problem. When you need any
more information I'll be happy to provide it.

One thing to note though is that I do have usb legacy mode turned on,
because I otherwise cannot boot into linux.

Wouter
