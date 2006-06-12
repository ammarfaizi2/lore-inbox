Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWFLVg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWFLVg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWFLVg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:36:56 -0400
Received: from rtr.ca ([64.26.128.89]:10654 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932369AbWFLVgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:36:55 -0400
Message-ID: <448DDE76.3090401@rtr.ca>
Date: Mon, 12 Jun 2006 17:36:54 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb,
 error -28
References: <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de> <448DD50F.3060002@rtr.ca> <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de> <448DD968.2010000@rtr.ca> <20060612212812.GA17458@suse.de>
In-Reply-To: <20060612212812.GA17458@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I found this fix in -mm:   gregkh-usb-usb-rmmod-pl2303-after-28.patch
>> > It did *not* fix the problem.
> 
> That should fix the memory leak after getting that error and let you
> unload the module, right?

Nope.  No difference here.

>> If I plug the 1.1 hub/dock into another external hub, no problems.
>
>I recommend doing that  :) 
>It's not like you get _any_ speed differences by using a USB 2.0 hub
>with this device...

I suppose not!  ;)

But the USB2.0 "hub" is built-into my notebook,
and the "cascading hubs" solution is likely to stop
working when we begin enforcing per-port power limits
on these devices.

I'm rebuilding to try the suggested patch now.

Cheers

