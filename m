Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263461AbSITUht>; Fri, 20 Sep 2002 16:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263476AbSITUht>; Fri, 20 Sep 2002 16:37:49 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:17024 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S263461AbSITUhs>; Fri, 20 Sep 2002 16:37:48 -0400
Date: Fri, 20 Sep 2002 13:42:50 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: 2.5.26 hotplug failure
To: Greg KH <greg@kroah.com>, Brad Hards <bhards@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Message-id: <3D8B884A.7030205@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200207180950.42312.duncan.sands@wanadoo.fr>
 <E17rwAI-0000vM-00@starship> <20020919164924.GB15956@kroah.com>
 <200209200656.23956.bhards@bigpond.net.au> <20020919230643.GD18000@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>I wasn't joking about putting back the /proc/bus/usb/drivers file. This is 
>>really going to hurt us in 2.6. 

Considering that the main use of that file that I know about was
implicit (usbfs is available if its files are present, another
assumption broken in 2.5), I'm not sure I feel any pain... :-)


> Is this file _really_ used?  All it did was show the USB drivers
> registered.  Even so, that same information is now present in driverfs,
> I haven't taken away anything, just moved it.  Lots of things are
> starting to move to driverfs, this isn't the first, and will not be the
> last.

Actually it does more than that ... it tells you what minor numbers
are assigned to the drivers _currently loaded_ which means that it's
not really useful the instant someone plugs in another device.

You can't use it to allocate numbers or tell what /dev/file/name matches
a given device ... so what is its value, other than providing a limited
minor number counterpart to /proc/devices?  (Which, confusingly, doesn't
list devices but major numbers.)

- Dave


