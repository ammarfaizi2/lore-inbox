Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVKJMLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVKJMLL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVKJMLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:11:10 -0500
Received: from tornado.reub.net ([202.89.145.182]:3242 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750800AbVKJMLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:11:09 -0500
Message-ID: <437338DA.3020406@reub.net>
Date: Fri, 11 Nov 2005 01:11:06 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20051109)
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: Greg KH <greg@kroah.com>, bunk@stusta.de, stern@rowland.harvard.edu,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, mdharm-usb@one-eyed-alien.net
Subject: Re: [-mm patch] USB_LIBUSUAL shouldn't be user-visible
References: <20051107215226.GA25104@kroah.com>	<Pine.LNX.4.44L0.0511071725220.5165-100000@iolanthe.rowland.org>	<20051107222840.GB26417@kroah.com>	<20051108004716.GJ3847@stusta.de>	<20051109222808.GG9182@kroah.com> <20051109224117.337690bf.zaitcev@redhat.com>
In-Reply-To: <20051109224117.337690bf.zaitcev@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2005 7:41 p.m., Pete Zaitcev wrote:
> On Wed, 9 Nov 2005 14:28:08 -0800, Greg KH <greg@kroah.com> wrote:
> 
>>> What about letting the two drivers always use libusual?
>> Pete?  What do you think about this patch?
> 
> It does nothing to explain how exactly the current configuration managed
> not to work, which leaves me unsatisfied. I did test the kernel to build
> correctly with libusub on and off. All we have is this:
> 
>> It seems that libusual.ko is not being actually built as a module, despite being 
>> set to 'm' in .config.

Duh.  It's set to 'y' not 'm'.  That will teach me for not reading...sorry

> Which is nonsensual, because CONFIG_USB_LIBUSUAL is a boolean.
> And reub.net is down, so I cannot fetch the erroneous .config.

It's up and down like a yoyo (fighting with a faulty DSLAM tonight for a 
stable upstream train speed).  It's up while I am still awake and kicking it.

I saw Adrian Bunks's posting in response to yours, and he stated a config he 
knows that is permitted but doesn't work.  That happens to be the same as 
mine, ie:

USB=y
CONFIG_USB_STORAGE=m
CONFIG_USB_LIBUSUAL=y

and also

CONFIG_BLK_DEV_UB=m

> I suspect that Reuben did not rerun "make oldconfig" after editing
> .config or something of that nature.

Didn't edit .config at all...just selected options when the make oldconfig was 
run (and misread, still not sure why I looked for a module when I saw 'y' in 
that .config..)

> What Adrian is proposing may be a good idea or may be not, but it has
> nothing to do with the problem.
> 
> -- Pete

Reuben
