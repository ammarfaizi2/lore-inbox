Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWBTK20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWBTK20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWBTK20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:28:26 -0500
Received: from lucidpixels.com ([66.45.37.187]:45450 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S964846AbWBTK2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:28:25 -0500
Date: Mon, 20 Feb 2006 05:28:24 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: Intel CSA Gigabit Bug in IC7-G Motherboards- Affects Windows/Linux
In-Reply-To: <4807377b0602192359g39c3a2fbnffaead2694788783@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0602200526210.24629@p34>
References: <Pine.LNX.4.64.0602191807001.7212@p34>  <1140392860.2733.433.camel@mindpipe>
  <Pine.LNX.4.64.0602191848230.7212@p34> <4807377b0602192359g39c3a2fbnffaead2694788783@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Have you tried running without NAPI? (disable it in your config in the
> e1000 section)

I have always used NAPI, I will test this later today and let you know the 
results with NAPI off, thanks.

Is there anything I need to be aware of using a CSA-based ethernet device 
vs. no CSA?

Thanks,

Justin.


On Sun, 19 Feb 2006, Jesse Brandeburg wrote:

> On 2/19/06, Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
>> Essentially, when you copy large amounts of data across the NIC it will
>> "freeze" the box in Linux (any 2.6.x kernel, have not tried 2.4.x) or
>> Windows XP SP2.
>
> I've heard isolated reports about issues with the CSA connected NIC,
> but we've not been able to reproduce much in our labs and (mostly)
> people haven't been complaining about it.
>
>> If you checkout the thread, it occurs for multiple people under various
>> OS' but in *some* cases if they use ABIT's IC7-G CSA/INTEL driver, they
>> their problems go away.
>
>> In Linux when I used to use the onboard NIC, it froze the box, I did not
>> have sysrq enabled at the time when this happened but frozen I mean screen
>> is frozen, no ping, box is inoperative.
>
> Have you tried running without NAPI? (disable it in your config in the
> e1000 section)
>
>> Nothing pecuilar was ever found in any of the logs or dmesg output
>> regarding the crash.
>>
>> Basically its the first revision of CSA gigabit on a motherboard from what
>> I read in the forums and unless you use ABIT's specially crafted driver,
>> it will crash the machine when you copy either:
>>
>> a) large amounts of data over a gigabit link
>> or
>> b) that death.zip file (unzipped of course) which contains the bad "bits"
>> that are probably seen/repeated when copying large amounts of data
>
> I'll have our lab attempt to reproduce the bug (again) this time using
> the special file.  I can't speak to the windows crash, sorry.
>
> please send your .config, cat /proc/interrupts, dmesg after driver is
> up, whether NAPI is on, what exact steps you use to reproduce the
> problem, what your environment is (i.e. copying to a windows server,
> etc) pretty much follow the instructions in
> http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html
>
> Jesse
>
