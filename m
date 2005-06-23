Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbVFWKOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVFWKOX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 06:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbVFWKKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 06:10:38 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:29611 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S262609AbVFWJ4A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 05:56:00 -0400
Message-ID: <42BA88A9.6010701@aitel.hist.no>
Date: Thu, 23 Jun 2005 12:02:17 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: jim@why.dont.jablowme.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs: remove devfs from Kconfig preventing it from being
 built
References: <20050621222419.GA23896@kroah.com>	<20050621.155919.85409752.davem@davemloft.net>	<20050622041330.GB27716@suse.de> <20050621.214527.71091057.davem@davemloft.net>
In-Reply-To: <20050621.214527.71091057.davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>From: Greg KH <gregkh@suse.de>
>Date: Tue, 21 Jun 2005 21:13:30 -0700
>
>  
>
>>On Tue, Jun 21, 2005 at 03:59:19PM -0700, David S. Miller wrote:
>>    
>>
>>>From: Greg KH <gregkh@suse.de>
>>>Date: Tue, 21 Jun 2005 15:24:19 -0700
>>>
>>>However, this does mean I do need to reinstall a couple
>>>debian boxes here to something newer before I can continue
>>>doing kernel work in 2.6.x on them.
>>>      
>>>
>>Those boxes rely on devfs?
>>    
>>
>
>Yeah, when I forget to turn on DEVFS_FS and DEVFS_MOUNT in the
>kernel config the machine won't boot. :-)
>
>  
>
>>Can't you just grab the "static dev" debian package and continue on?
>>I'm sure there is one in there somewhere (don't really know for sure,
>>not running debian anywhere here, sorry.)
>>
>>Or how about a tarball of a /dev tree?  Would that help you out?
>>    
>>
>
>I don't know if Debian has such a package.
>
>Don't worry, I'll take care of this by simply reinstalling
>and thus moving to udev.
>
That works, but seems like "the long way".
You don't need to be given a tarball of a /dev tree - make your own!
tar up your existing devfs-based /dev tree (at a time when all
your devices are present)  then umount devfs and untar it
all.   Then you have a static /dev which works with the existing setup,
and a nondevfs kernel can boot right away.

The udev way may be necessary if you actually have lots of devices
that come and go, such as usb thingies.  It shouldn't be necessary
just to boot the machine though.

Jim Crilly wrote:

>I think he's just saying that since he did the install with devfs enabled
>and has been using devfs device names, a conversion back to 'standard'
>names would be a major PITA. It's definately possible to convert, but if
>there's not much on the boxes a reinstall might be quicker.

Fortunately, one doesn't need to convert back.  Just copy devfs-dev onto
ext3-dev and there you have the "good old" devfs-names in a static /dev.

Helge Hafting



