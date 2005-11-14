Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbVKNVwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbVKNVwT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVKNVwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:52:19 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:55541 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1751273AbVKNVwT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:52:19 -0500
Message-ID: <4379070C.8090709@mvista.com>
Date: Mon, 14 Nov 2005 13:52:12 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Greg KH <greg@kroah.com>, ganzinger@mvista.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Calibration issues with USB disc present.
References: <43750EFD.3040106@mvista.com>	 <1131746228.2542.11.camel@cog.beaverton.ibm.com>	 <20051112050502.GC27700@kroah.com> <4376130D.1080500@mvista.com>	 <20051112213332.GA16016@kroah.com> <4378DDC5.80103@mvista.com>	 <20051114184940.GA876@kroah.com> <1131998339.4668.16.camel@leatherman>
In-Reply-To: <1131998339.4668.16.camel@leatherman>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Mon, 2005-11-14 at 10:49 -0800, Greg KH wrote:
> 
>>On Mon, Nov 14, 2005 at 10:56:05AM -0800, George Anzinger wrote:
>>
>>>Greg KH wrote:
>>>
>>>>On Sat, Nov 12, 2005 at 08:06:37AM -0800, George Anzinger wrote:
>>>>
>>>>>Greg KH wrote:
>>>>
>>>>On these boxes, I'd just recommend disabling USB legacy support
>>>>completly, if possible.  And then complain loudly to the vendor to fix
>>>>their BIOS.
>>>
>>>But if one is booting from that device...
>>
>>Booting from a USB device?  I can see this happening when installing a
>>distro, and you boot from the USB cdrom, but not for "normal"
>>operations.

I think it was a hard drive they were trying to support.
>>
>>Oh well, publicly mock the manufacturer for doing horrible things in
>>their BIOS and then no one will buy the boxes, and we will not have
>>problems :)

Long term, maybe, but it will not close the bug report I have in hand...
> 
> 
> I suspect the right fix is in-between. We should try to push hardware
> makers away from using SMIs recklessly, but we should also do our best
> to work around those that don't. The same problems crop up w/
> virtualization where time-based calibration may be interrupted.
> 
> George, again, there has been some SMI resistant delay calibration code
> added recently. You mentioned this problem was seen on 2.4 kernel, so
> you could verify that the new code in 2.6.14 works and if so, try
> backporting it.
> 
> If not we need to see what else we can do about improving delay
> calibration (its a similar tick-based problem to what I'm addressing
> with the timeofday rework) or reducing the use of delay by using
> something else.
> 
I will look at that code, but we also need to address the same problem in the TSC calibration area.
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
