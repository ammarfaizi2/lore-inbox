Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269823AbRHMVgS>; Mon, 13 Aug 2001 17:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269824AbRHMVgJ>; Mon, 13 Aug 2001 17:36:09 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:64076 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S269823AbRHMVfv>; Mon, 13 Aug 2001 17:35:51 -0400
Date: Mon, 13 Aug 2001 17:36:04 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200108132136.f7DLa4l13034@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.8-ac2 USB keyboard capslock hang
In-Reply-To: <mailman.997731905.31689.linux-kernel2news@redhat.com>
In-Reply-To: <E15WM1P-0007uJ-00@the-village.bc.nu> <mailman.997731905.31689.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bug that I fixed was that CapsLock submitted URB while
in a callback (it was a LED control URB).

If you have to hit CapsLock _twice_ to trigger the bug,
then I think it's something different.

-- Pete

> this bug has been around since 2.4.3-ac *at least*, and the linux-usb 
> folks are aware of it [but can't get a repro].  i've had repros since 
> 2.4.3-ac.
> 
> this is the first time afaik that this bug has been reported on a non 
> ms-natural-pro keyboard tho.
> 
> Alan Cox wrote:
> 
> >>On Mon, Aug 13, 2001 at 06:56:48PM +0100, Alan Cox wrote:
> >>
> >>>Roswell is the Red Hat 7.2 beta, so its probably another bug that was fixed
> >>>in the USB and input updates in -ac
> >>>
> >>It hangs on 2.4.8-ac2, so was this bug fix lost perhaps? 
> >>
> >
> >It would be useful to know if 2.4.7ac3 say works and if so which one after
> >that it broke at
