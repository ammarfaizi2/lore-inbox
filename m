Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWCGRCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWCGRCN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWCGRCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:02:13 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:25861 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751196AbWCGRCN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:02:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z1kvuY8fDzljVNoDeL5KMvTQPZYPCP+zW7hdFJZkXSeimkLaEzZ0+3Xn1pDmwuyzmbGpL2Wa5Zj5C+8PJn8jw+YIIfZzFhQeQbduScgT4XhbSAl1+Sb9HN2KteQ8YPUsuCWdcN3utRu3CFoXsIbeawXXyVYRHA2JNM5H1OVmDRo=
Message-ID: <c43b2e150603070902l10659822ib6ffe1c4b0b296bf@mail.gmail.com>
Date: Tue, 7 Mar 2006 18:02:12 +0100
From: wixor <wixorpeek@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: using usblp with ppdev?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060306172532.GB8697@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c43b2e150603020732m42195b0dkf33d68fe64bc4a57@mail.gmail.com>
	 <20060302165557.GA31247@kroah.com>
	 <c43b2e150603030512l141c101va11300bcfbda4f60@mail.gmail.com>
	 <20060303170752.GA5260@kroah.com>
	 <c43b2e150603060631h494b920g84cf357f376d64bb@mail.gmail.com>
	 <20060306172532.GB8697@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> But if you want to play around and verify this, try modifying the USB
> device table in the drivers/usb/misc/uss720.c file (look for the
> structure called "uss720_table" and add a new entry with the vendor and
> product id of your device there.)
>
Well, it seems the device doesn't like the driver or vice-verse. When
added entry to the uss720_table, /proc/bus/usb/devices reports that
the device is being handled by this driver, but when I plug the device
in, dmesg gets full of error reports, and the device file doesn't
appear in /dev . Now, my question is: is the cable named "usb to
parallel cable" an interface that converts classic printer to usb
printer? Shouldn't it be rather a real usb to parallel cable? Is it
some kind of protocol limitation that the device is unable to perform
per-pin i/o tasks or maybe  the protocol isn't simply fully
implemented by the device? Or maybe I should use some another protocol
(and driver) to use advanced (?) functions? The uss720 driver
complains about usb error -32 (like: get_1284_register: usb error -32
[but: async_complete: urb error -32 - shouldn't it be USB error? a
typo?])

thanks for help

wixor
