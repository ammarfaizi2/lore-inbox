Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275815AbSIUCbw>; Fri, 20 Sep 2002 22:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275862AbSIUCbw>; Fri, 20 Sep 2002 22:31:52 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:46295 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S275815AbSIUCbv>; Fri, 20 Sep 2002 22:31:51 -0400
Date: Fri, 20 Sep 2002 19:36:54 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: 2.5.26 hotplug failure
To: Brad Hards <bhards@bigpond.net.au>
Cc: Johannes Erdfelt <johannes@erdfelt.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Message-id: <3D8BDB46.9020508@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200207180950.42312.duncan.sands@wanadoo.fr>
 <200209210922.41887.bhards@bigpond.net.au> <20020920193642.I1627@sventech.com>
 <200209211025.59114.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Personally, I've never used /proc/bus/usb/drivers. I've always just
>>looked at lsmod.
>>
>>Why should this be any different?
> 
> Because lsmod only works for drivers that are modular. Real users mix built-in 
> and modules.

Wasn't someone -- Rusty? -- working an update to the module framework
so 2.5 would be able to show all kernel modules, not just dynamically
linked ones?  And so something like their MODULE_NAME could be used
in static tables as the driver name?  Some 2.4 usb drivers disagreed
with themselves on that issue.  (Hotplug no longer has the table of
exceptions it once had, it was error prone.  But that also means it's
more uncertain about system state than is necessary.)

I'd be more keen to see that issue solved than keep the 'drivers' file.
The question that hotplug wants to answer, for example, is "is this
driver in the kernel".  None of the 2.4 solutions for that were very
trouble free.

- Dave

