Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129109AbQKFSi7>; Mon, 6 Nov 2000 13:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129597AbQKFSiu>; Mon, 6 Nov 2000 13:38:50 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:44294 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129109AbQKFSin>;
	Mon, 6 Nov 2000 13:38:43 -0500
Message-ID: <3A06FA73.948357F6@mandrakesoft.com>
Date: Mon, 06 Nov 2000 13:37:39 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: David Woodhouse <dwmw2@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Keith Owens <kaos@ocs.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <Pine.LNX.4.10.10011061210360.30477-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> On Mon, 6 Nov 2000, David Woodhouse wrote:
> 
> > The point here is that although I've put up with just keeping the sound
> > driver loaded for the last few years, permanently taking up a large amount
> > of DMA memory, the inter_module_xxx stuff that Keith is proposing would
> > give us a simple way of storing the data which we want to store.
> ...
> > Being able to do it completely in userspace would be neater, though.
> 
> I think there are a bunch of other devices that need stuff from userspace
> before they fully init, namely the ones that load proprietary firmware
> images. Will an approach like that work here?

Some devices have a firmware.h that is compiled into the driver.  A few
sound devices use a function that loads a firmware file from userspace,
given a filename.  The comment in drivers/sound/sound_firmware.c says
that this is a poor method, and that the recommended method for
uploading firmware to a device is via ioctl.

	Jeff


-- 
Jeff Garzik             | "When I do this, my computer freezes."
Building 1024           |          -user
MandrakeSoft            | "Don't do that."
                        |          -level 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
