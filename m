Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266088AbUAFHOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 02:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266090AbUAFHOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 02:14:53 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:53960 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S266088AbUAFHOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 02:14:51 -0500
Date: Tue, 6 Jan 2004 08:14:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Daniel Jacobowitz <dan@debian.org>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040106071432.GA29252@ucw.cz>
References: <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105132756.A975@pclin040.win.tue.nl> <Pine.LNX.4.58.0401050749490.21265@home.osdl.org> <20040105205228.A1092@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105205228.A1092@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 08:52:28PM +0100, Andries Brouwer wrote:

> > udev can then use those serial numbers to have a stable pathname
> 
> True. Provided that it knows how to get them.
> The kernel driver knew all about the device.
> Must udev also know all about all possible devices?

No. But it must have rules about what to do with all possible device
types (at least very generic default rules), based on the data the
drivers can provide to identify the device.

> Do I/O to these devices?

If the using an UUID stored on the device (like the filesystem UUID), yes.

> Or must sysfs export all data that could possibly be used?

Not necessarily. But udev must get the all the data that could possibly
be used for assigning a name to the device. It can get them either as
hotplug command line arguments and environment variables or via sysfs,
or by any other means.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
