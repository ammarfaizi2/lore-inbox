Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUBWJ0o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 04:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbUBWJ0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 04:26:44 -0500
Received: from smtp.vnoc.murphx.net ([217.148.32.26]:9199 "HELO
	mail-srv0.cluster.vnoc.murphx.net") by vger.kernel.org with SMTP
	id S261897AbUBWJ0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 04:26:40 -0500
Message-ID: <4039C868.4040609@gadsdon.giointernet.co.uk>
Date: Mon, 23 Feb 2004 09:31:20 +0000
From: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040223
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux kernel <linux-kernel@vger.kernel.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>
Subject: Re: 2.6.x support for prism2 USB wireless adapter?
References: <40395346.3040300@gadsdon.giointernet.co.uk> <20040223020230.GA14833@kroah.com>
In-Reply-To: <20040223020230.GA14833@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The prism2_usb driver is from the linux-wlan-ng project at
http://www.linux-wlan.com/linux-wlan/index.html#Download

This driver driver compiles OK under 2.6.3 and loads, but the problem is 
that the device is not recognised by the USB kernel subsystem before that..

Under 2.4.23 (and without loading the prism2_usb driver) I get the 
following output from #lsusb:
Bus 001 Device 001: ID 0000:0000
Bus 001 Device 002: ID 066b:2212 Linksys, Inc. WUSB11v2.5 802.11b Adapter

Under 2.6.3 I get:
Bus 001 Device 001: ID 0000:0000

Robert Gadsdon

Greg KH wrote:
> On Mon, Feb 23, 2004 at 01:11:34AM +0000, Robert Gadsdon wrote:
> 
>>I had my Linksys prism2 USB wireless adapter (WUSB11 v2.5) working 
>>reasonably well with kernel 2.4.23, but with kernel 2.6.3 (and udev 018) 
>>I get:
>>
>>usb 1-1: new full speed USB device using address 5
>>drivers/usb/core/config.c: invalid interface number (1/1)
>>usb 1-1: can't read configurations, error -22
>>
>>#modprobe prism2_usb     gives:
>>prism2usb_init: prism2_usb.o: 0.2.1-pre20 Loaded
>>prism2usb_init: dev_info is: prism2_usb
>>drivers/usb/core/usb.c: registered new driver prism2_usb
>>
>>#lsusb     does not show the device at all...
>>
>>Is this still 'work in progress'?
> 
> 
> I don't see this driver in the kernel tree.  Where did you find it?
> 
> thanks,
> 
> greg k-h
> 
> 

-- 
..................................
Robert Gadsdon
01442 872 633
rgadsdon2@netscape.net
..................................
