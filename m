Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbWFLWNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbWFLWNA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 18:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbWFLWNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 18:13:00 -0400
Received: from rtr.ca ([64.26.128.89]:57756 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932598AbWFLWM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 18:12:59 -0400
Message-ID: <448DE6EA.8020708@rtr.ca>
Date: Mon, 12 Jun 2006 18:12:58 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb,
 error -28
References: <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de> <448DD50F.3060002@rtr.ca> <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de> <448DD968.2010000@rtr.ca> <20060612212812.GA17458@suse.de> <448DE28D.3040708@rtr.ca> <20060612220321.GA19792@suse.de>
In-Reply-To: <20060612220321.GA19792@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Jun 12, 2006 at 05:54:21PM -0400, Mark Lord wrote:
>> Okay, with these two patches from -mm, the USB no longer dies
>> when I plug in my hub/dock device:
>>
>> gregkh-usb-improved-tt-scheduling-for-ehci.patch
>> gregkh-usb-usb-rmmod-pl2303-after-28.patch
>>
>> So let's get these pushed upstream sooner than later, please!
> 
> It will happen after 2.6.17 is out, as they are in the queue to do so.

2.6.18 will do, I suppose.

But has the *real* bug been fixed with these patches,
or merely "avoided" ?

Eg. If usb_submit_urb() ever fails again (low on memory, etc..)
inside  pl2303_open(), will we be back with the same bug?

What's the *real* actual bug here?

Thanks
