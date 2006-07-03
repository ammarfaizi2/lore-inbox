Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWGCQT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWGCQT2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 12:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWGCQT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 12:19:28 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:31121 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S932092AbWGCQT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 12:19:27 -0400
Date: Mon, 03 Jul 2006 12:19:20 -0400
From: Andy Gay <andy@andynet.net>
Subject: Re: [linux-usb-devel] [PATCH] Airprime driver improvements to	allow
 full speed EvDO transfers
In-reply-to: <ef88c0e00607030843q3cf32c1q40ae8fa8055b025f@mail.gmail.com>
To: Ken Brush <kbrush@gmail.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Message-id: <1151943561.3285.517.camel@tahini.andynet.net>
MIME-version: 1.0
X-Mailer: Evolution 2.4.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<ef88c0e00607030843q3cf32c1q40ae8fa8055b025f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-03 at 08:43 -0700, Ken Brush wrote:
> On 6/29/06, Andy Gay <andy@andynet.net> wrote:
> >
> > Adapted from an earlier patch by Greg KH <gregkh@suse.de>.
> > That patch added multiple read urbs and larger transfer buffers to allow
> > data transfers at full EvDO speed.
> >
> > This version includes additional device IDs and fixes a memory leak in
> > the transfer buffer allocation.
> >
> > Some (maybe all?) of the supported devices present multiple bulk endpoints,
> > the additional EPs can be used for control and status functions.
> > This version allocates 3 EPs by default, that can be changed using
> > the 'endpoints' module parameter.
> >
> > Tested with Sierra Wireless EM5625 and MC5720 embedded modules.
> >
> 
> With my aircard 580, I get 6 TTYUSB devices and a Urb too big message.
> You should probably take the 580 out of the driver unless someone
> actually has one and it works for them.
Well, that's the easy way out :)
But I'm willing to try to debug this, if you're game.

I don't know how it could see 6 EPs, unless you specify endpoints=6 when
you load the module. Maybe it sees it as 2 devices somehow?
Can you send me the relevant part of 'cat /proc/bus/usb/devices'?

Also the dmesg where you get the 'urb too big'. You could also try to
load the module with debug enabled.

> 
> -Ken
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

