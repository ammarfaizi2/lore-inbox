Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbTELT43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 15:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbTELT42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 15:56:28 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:6857 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261923AbTELT42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 15:56:28 -0400
Message-ID: <3EC002AB.20008@pacbell.net>
Date: Mon, 12 May 2003 13:23:07 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Max Krasnyansky <maxk@qualcomm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [Bluetooth] HCI USB driver update. Support
 for SCO over HCI USB.
References: <200304290317.h3T3HOdA027579@hera.kernel.org> <200304290317.h3T3HOdA027579@hera.kernel.org> <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com> <5.1.0.14.2.20030429145523.10c52e50@unixmail.qualcomm.com> <5.1.0.14.2.20030508123858.01c004f8@unixmail.qualcomm.com> <3EBBFC33.7050702@pacbell.net> <1052517124.10458.199.camel@localhost.localdomain> <20030509230542.GA3267@kroah.com> <5.1.0.14.2.20030512105155.0d1773c0@unixmail.qualcomm.com> <20030512180146.GB28675@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, May 12, 2003 at 10:53:48AM -0700, Max Krasnyansky wrote:
> 
>>So, I guess in general you're ok with adding ->drv_cb and ->hcd_cb
 >> to 'struct urb' ?
> 
> 
> I am, as long as someone uses it :)

I'm unlikely to dig up that patch making ohci-hcd use a hcd_cb,
which would mean that the submit path (a) gets rid of one fault
mode, (b) slightly speeds up the submit path, and (c) all but
stops using the heap.  Even though they'd be fine updates ...
I'd be glad to see someone else contribute such cleanups though!

The uhci-hcd version would be trickier, and on 64bit CPUs it
would not fit in the 64 bytes Max suggested -- without some
work to shrink that driver.

- Dave


