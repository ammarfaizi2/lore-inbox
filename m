Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbUAEUUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 15:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265304AbUAEUUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 15:20:36 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:22277 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265258AbUAEUU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 15:20:26 -0500
Date: Mon, 5 Jan 2004 20:52:28 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Daniel Jacobowitz <dan@debian.org>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040105205228.A1092@pclin040.win.tue.nl>
References: <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105132756.A975@pclin040.win.tue.nl> <Pine.LNX.4.58.0401050749490.21265@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0401050749490.21265@home.osdl.org>; from torvalds@osdl.org on Mon, Jan 05, 2004 at 08:13:26AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 08:13:26AM -0800, Linus Torvalds wrote:

> > You keep repeating that enumerating is impossible, and that therefore
> > stable device numbers are impossible, and that consequently, since we
> > cannot have stable device numbers expecting them to be stable is broken.
> 
> Right.

> When I talk about "enumerate", I do not mean "give numbers starting at 1".
> It boils down to not how many devices there can be, but to whether there 
> is any way to "walk the space of devices".

Yes, that is what one commonly calls to enumerate.  Let us say,
an effective way, given some integer, to find the associated device.

[You can leave the mathematics out - this enumerable is not the same as
denumerable or countable. The set of devices on earth is finite.]

> And there fundamentally isn't. And _that_ is the basic issue: if you
> _cannot_ number a space, you cannot have a stable device number.

If there is no effective way to find a disk given some number,
there may very well be an effective way to find a number given some disk.
And indeed, there usually is.

> There are no "serial numbers".
> Please. Where do you think those numbers would come from?

Most of my devices do have them...

> My point is that for the subset of devices that _do_ have serial numbers 

Ah, wait! You also have heard about devices with serial numbers! Good!
It is those devices I was talking about. Remember? ["important special case"]

> udev can then use those serial numbers to have a stable pathname

True. Provided that it knows how to get them.
The kernel driver knew all about the device.
Must udev also know all about all possible devices? Do I/O to these devices?
Or must sysfs export all data that could possibly be used?

Andries

