Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310913AbSCHPcO>; Fri, 8 Mar 2002 10:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310914AbSCHPcG>; Fri, 8 Mar 2002 10:32:06 -0500
Received: from [198.16.16.39] ([198.16.16.39]:17490 "EHLO carthage")
	by vger.kernel.org with ESMTP id <S310913AbSCHPb4>;
	Fri, 8 Mar 2002 10:31:56 -0500
Date: Fri, 8 Mar 2002 09:26:45 -0600
From: James Curbo <jcurbo@acm.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: a couple of USB related Oopses
Message-ID: <20020308152645.GA936@carthage>
Reply-To: James Curbo <jcurbo@acm.org>
In-Reply-To: <20020305184604.GA4590@carthage> <20020305192307.GB10151@kroah.com> <20020305193317.GA5339@carthage> <20020305193732.GC10151@kroah.com> <20020306050349.GA1152@carthage> <20020307063905.GA18676@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020307063905.GA18676@kroah.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Debian GNU/Linux
Organization: Henderson State University, Arkadelphia, AR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I applied the patch; I don't get the panic anymore. I'm still
getting kernel messages like this:

usb-uhci.c: ENXIO 80000280, flags 0, urb d76c4840, burb d79b1d40
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb d76c4840, burb d79b1d40
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb d76c4840, burb d79b1d40
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb d74c59c0, burb d79b1d40
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb d74c59c0, burb d79b1d40
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb d74c59c0, burb d79b1d40
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb d74c5b40, burb d79b1d40
usb-uhci.c: ENXIO 80000280, flags 0, urb d74c5b40, burb d79b1d40
usb-uhci.c: ENXIO 80000280, flags 0, urb d74c5b40, burb d79b1d40
usb-uhci.c: ENXIO 80000280, flags 0, urb d74c5b40, burb d79b1d40
usb-uhci.c: ENXIO 80000280, flags 0, urb d76c4640, burb d79b1d40
usb-uhci.c: ENXIO 80000280, flags 0, urb d76c4640, burb d79b1d40
usb-uhci.c: ENXIO 80000280, flags 0, urb d76c4640, burb d79b1d40
usb-uhci.c: ENXIO 80000280, flags 0, urb d76c4640, burb d79b1d40

Also, while now I don't get the panic when I try to print, it still
doesn't print.. CUPS says "USB port busy, retrying in 30 seconds"
Unfortunately I can't remember what kernel version I was using when it
worked last.

On Mar 06, Greg KH wrote:
> Crud, missed another driver.  Can you please try the patch below and let
> me know if it fixes the problem for you?
> 
> thanks,
> 
> greg k-h

-- 
James Curbo <jcurbo@acm.org> <jc108788@rc.hsu.edu>
Undergraduate Computer Science, Henderson State University
PGP Keys at <http://reddie.henderson.edu/~curboj/>
Public Keys: PGP - 1024/0x76E2061B GNUPG - 1024D/0x3EEA7288
