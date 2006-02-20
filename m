Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932693AbWBTH7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbWBTH7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 02:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbWBTH7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 02:59:48 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:32086 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932693AbWBTH7r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 02:59:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VsW9j1YDh1kZNakVp0FwUKxnLcwDVmXKlaYZ8kYdfWG4+eo0gYQ0wrlhk1dBDtvhkr/65hmGV37Je1QC+/bziZJvQ8vnEdYeyFdmxfMXGvXX1XOE1Lq46iHQH6vwHuD4IsDu6RuHcHb+H/8Fr7O1lzRDmp8G2ozFHnOrCMdgqxQ=
Message-ID: <4807377b0602192359g39c3a2fbnffaead2694788783@mail.gmail.com>
Date: Sun, 19 Feb 2006 23:59:46 -0800
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Justin Piszcz" <jpiszcz@lucidpixels.com>
Subject: Re: Intel CSA Gigabit Bug in IC7-G Motherboards- Affects Windows/Linux
Cc: "Lee Revell" <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       "Jesse Brandeburg" <jesse.brandeburg@intel.com>
In-Reply-To: <Pine.LNX.4.64.0602191848230.7212@p34>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602191807001.7212@p34>
	 <1140392860.2733.433.camel@mindpipe>
	 <Pine.LNX.4.64.0602191848230.7212@p34>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/06, Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
> Essentially, when you copy large amounts of data across the NIC it will
> "freeze" the box in Linux (any 2.6.x kernel, have not tried 2.4.x) or
> Windows XP SP2.

I've heard isolated reports about issues with the CSA connected NIC,
but we've not been able to reproduce much in our labs and (mostly)
people haven't been complaining about it.

> If you checkout the thread, it occurs for multiple people under various
> OS' but in *some* cases if they use ABIT's IC7-G CSA/INTEL driver, they
> their problems go away.

> In Linux when I used to use the onboard NIC, it froze the box, I did not
> have sysrq enabled at the time when this happened but frozen I mean screen
> is frozen, no ping, box is inoperative.

Have you tried running without NAPI? (disable it in your config in the
e1000 section)

> Nothing pecuilar was ever found in any of the logs or dmesg output
> regarding the crash.
>
> Basically its the first revision of CSA gigabit on a motherboard from what
> I read in the forums and unless you use ABIT's specially crafted driver,
> it will crash the machine when you copy either:
>
> a) large amounts of data over a gigabit link
> or
> b) that death.zip file (unzipped of course) which contains the bad "bits"
> that are probably seen/repeated when copying large amounts of data

I'll have our lab attempt to reproduce the bug (again) this time using
the special file.  I can't speak to the windows crash, sorry.

please send your .config, cat /proc/interrupts, dmesg after driver is
up, whether NAPI is on, what exact steps you use to reproduce the
problem, what your environment is (i.e. copying to a windows server,
etc) pretty much follow the instructions in
http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html

Jesse
