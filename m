Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTD2VOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 17:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbTD2VOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 17:14:08 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:22173 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261827AbTD2VOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 17:14:07 -0400
Message-ID: <3EAEF11B.4070000@pacbell.net>
Date: Tue, 29 Apr 2003 14:39:39 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Max Krasnyansky <maxk@qualcomm.com>
CC: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [Bluetooth] HCI USB driver update. Support
 for SCO over HCI USB.
References: <200304290317.h3T3HOdA027579@hera.kernel.org> <200304290317.h3T3HOdA027579@hera.kernel.org> <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > I was actually going to ask you guys if you'd be interested
 > in generalizing this _urb_queue() stuff that I have for
 > other drivers. Current URB api does not provide any interface
 > for queueing/linking/etc of URBs in the _driver_ itself.

I only saw fragments of the original patch -- could you be just
a bit more specific?

If you're suggesting adding some "struct list_head" into
"struct urb" for exclusive use of the interface's driver
(instead of urb_list, which is for usbcore/hcd) ... I'd
agree that'd be a good thing.

In fact I recently got around to adding that to the
"gadget side" analogue of an URB.  For much the same
kind of reasons as you mentioned.

- Dave


