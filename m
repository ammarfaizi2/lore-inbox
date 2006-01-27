Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWA0MqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWA0MqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 07:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWA0MqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 07:46:24 -0500
Received: from tornado.reub.net ([202.89.145.182]:24192 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750966AbWA0MqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 07:46:24 -0500
Message-ID: <43DA161C.1070404@reub.net>
Date: Sat, 28 Jan 2006 01:46:20 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.5 (Windows/20060124)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: 2.6.16-rc1-mm3
References: <20060124232406.50abccd1.akpm@osdl.org> <43D7567E.60003@reub.net> <20060126053941.GA13361@kroah.com>
In-Reply-To: <20060126053941.GA13361@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/01/2006 6:39 p.m., Greg KH wrote:
> On Wed, Jan 25, 2006 at 11:44:14PM +1300, Reuben Farrelly wrote:
>>
>> On 25/01/2006 8:24 p.m., Andrew Morton wrote:
>>> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm3/
>>>
>>> - Dropped the timekeeping patch series due to a complex timesource 
>>> selection
>>>  bug.
>>>
>>> - Various fixes and updates.
>> Generally quite good again :)
>>
>> I'm seeing this USB "handoff" warning message logged when booting up:
>>
>> 0000:00:1d.7 EHCI: BIOS handoff failed (BIOS bug ?)
>>
>> This is not new to this -mm release, looking back over my bootlogs I note 
>> that 2.6-15-rc5-mm1 was OK, but 2.6.15-mm4 was showing this message.  I'll 
>> narrow it down if it doesn't appear obvious what the problem is.
> 
> When this happens, does your usb-ehci driver still work properly
> (meaning do usb 2.0 devices connect and go at the proper high speeds)?

It seems like every device I can lay my hands on either only supports 1.1 or 
doesn't specify what it is.  I'll try find something which is known to be 2.0. 
Certainly my 1.1 devices seem to work ok.

> And if you change the USB setting in your bios, does this error message
> go away?

If I change "USB 2.0 legacy support" from "High Speed 480Mbps" which it was 
originally to "Full Speed 12MBps" then yes it does go away.  Although I'm not 
sure that's the best way to have it configured.

There is a slight possibility that this setting was changed in the bios which is 
why I am now noticing it, and that it wasn't as a result of a change above.

Reuben

