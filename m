Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbTEIGxu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 02:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbTEIGxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 02:53:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33239 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262313AbTEIGxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 02:53:50 -0400
Date: Fri, 9 May 2003 09:06:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
Message-ID: <20030509070623.GV20941@suse.de>
References: <20030508161600.GE20941@suse.de> <Pine.LNX.4.44.0305080924400.2967-100000@home.transmeta.com> <20030508163441.GG20941@suse.de> <1052431594.13567.30.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052431594.13567.30.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08 2003, Alan Cox wrote:
> On Iau, 2003-05-08 at 17:34, Jens Axboe wrote:
> > Might not be a bad idea, drive->address_mode is a heck of a lot more to
> > the point. I'll do a swipe of this tomorrow, if no one beats me to it.
> 
> We don't know if in the future drives will support some random mask of modes.
> Would
> 
> 	drive->lba48
> 	drive->lba96
> 	drive->..
> 
> be safer ?

I had the same thought yesterday, that just because a device does lba89
does not need it supports all of the lower modes. How about just using
the drive->address_mode as a supported field of modes?

if (drive->address_mode & IDE_LBA48)
	lba48 = 1;

-- 
Jens Axboe

