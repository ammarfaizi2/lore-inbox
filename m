Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265643AbSJSR6y>; Sat, 19 Oct 2002 13:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265644AbSJSR6y>; Sat, 19 Oct 2002 13:58:54 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:39111 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S265643AbSJSR6x>; Sat, 19 Oct 2002 13:58:53 -0400
Date: Sat, 19 Oct 2002 11:06:39 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: Zaurus support for usbnet.c
To: Nicolas Pitre <nico@cam.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <3DB19F2F.2040603@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <Pine.LNX.4.44.0210191336430.5873-100000@xanadu.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>Zaurus doesn't have a stock www.handhelds.org kernel; there's a
>>different usb slave/target device driver, which uses different
>>framing for the Ethernet packets.  Pavel's patch teaches "usbnet"
>>about one of those protocols.  (The other is MSFT-friendly.)
>>
>>It's worth mentioning the Yopy here too:  Zaurus isn't the only
>>SA-1110 based Linux PDA, and its distro is evidently closer to
>>the iPAQ distros (but you won't need a WinCE-ectomy).  Current
>>versions of "usbnet" have support for a recent YOPY version; they
>>use different USB vendor and product IDs "out of the box".
> 
> 
> Why not using the same (the best which ever it is) driver instead of 
> reinventing the wheel for every SA1110-based devides out there?

I think that on the host side the evidence is that "usbnet" is that
driver, and Pavel's patch is big step forward.  It forces all the
remaining questions onto the slave/target side (PDA for now).

Now, on the device side ... that's not really my call, but I agree
that'd be a good way to go.  The question is what's "best"?

Last I looked, no www.usb.org class spec or IETF RFC (even I-D)
standardized a reasonably simple/robust "IP-over-USB", so there
are only vendor-specific solutions.  Some of them deal with odd
hardware quirks, others deal with MSFT interop.  Lots of vendor
expectations have unfortunately been set on the MSFT side, where
creating product interop problems is sometimes seen as a win in
terms of market control or "product differentiation".

- Dave





