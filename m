Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWFLVPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWFLVPo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWFLVPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:15:41 -0400
Received: from rtr.ca ([64.26.128.89]:17882 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932299AbWFLVPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:15:22 -0400
Message-ID: <448DD968.2010000@rtr.ca>
Date: Mon, 12 Jun 2006 17:15:20 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb,
 error -28
References: <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de>
In-Reply-To: <20060612204918.GA16898@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Jun 12, 2006 at 04:06:22PM -0400, Mark Lord wrote:
>>  pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb, error -28
>>
>> The pl2303 serial port is part of a USB1.1 Hub/dock device,
>> plugged into a USB2 port on my notebook.
> 
> Known issue for years.  Either plug it directly into the USB 2.0 root
> hub, or disable the ehci driver.
> 
>> I get the same failure again when trying to use the port with Kermit.
>> This device was working fine here not long ago -- on the -rc5 kernels I 
>> think.
> 
> It's a flaky thing.
> 
> Also, look in the -mm tree, there is a fix for this direct error, and
> hopefully some ehci fixes that enable the whole thing to work properly.

I found this fix in -mm:   gregkh-usb-usb-rmmod-pl2303-after-28.patch
It did *not* fix the problem.

Any other candidates available?

Thanks
