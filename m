Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265625AbSJSQpE>; Sat, 19 Oct 2002 12:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265628AbSJSQpE>; Sat, 19 Oct 2002 12:45:04 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:32976 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S265625AbSJSQpD>; Sat, 19 Oct 2002 12:45:03 -0400
Date: Sat, 19 Oct 2002 09:52:49 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: Zaurus support for usbnet.c
To: Nicolas Pitre <nico@cam.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <3DB18DE1.3060003@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-usb-devel list has a slightly cleaned up version of Pavel's
Zaurus patch, which I've asked him to retest before this support
gets integrated.

These patches will apply to recent 2.4.20pre kernels too, if anyone
is sufficiently impatient to try... :)


> If both clients i.e. the iPAQ and the Zaurus are actually a SA1110, and if 
> the iPAQ is already supported on both sides, then the Zaurus should work out 
> of the box.

Yes, but out of the www.handhelds.org box, not Sharp's box.

Zaurus doesn't have a stock www.handhelds.org kernel; there's a
different usb slave/target device driver, which uses different
framing for the Ethernet packets.  Pavel's patch teaches "usbnet"
about one of those protocols.  (The other is MSFT-friendly.)

It's worth mentioning the Yopy here too:  Zaurus isn't the only
SA-1110 based Linux PDA, and its distro is evidently closer to
the iPAQ distros (but you won't need a WinCE-ectomy).  Current
versions of "usbnet" have support for a recent YOPY version; they
use different USB vendor and product IDs "out of the box".

- Dave



