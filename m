Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286308AbRLTRoF>; Thu, 20 Dec 2001 12:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286309AbRLTRnz>; Thu, 20 Dec 2001 12:43:55 -0500
Received: from svr3.applink.net ([206.50.88.3]:31506 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S286308AbRLTRno>;
	Thu, 20 Dec 2001 12:43:44 -0500
Message-Id: <200112201743.fBKHhaSr016276@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Robert Love <rml@tech9.net>
Subject: Re: Scheduler, Can we save some juice ...
Date: Thu, 20 Dec 2001 11:39:52 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33L.0112200149330.15741-100000@imladris.surriel.com> <200112200637.fBK6b2Sr014173@svr3.applink.net> <1008831171.806.14.camel@phantasy>
In-Reply-To: <1008831171.806.14.camel@phantasy>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 December 2001 00:52, Robert Love wrote:
> On Thu, 2001-12-20 at 01:33, Timothy Covell wrote:
> > OK, here's another 0.1% for you.  Considering how Linux SMP
> > doesn't have high CPU affinity, would it be possible to make a
> > patch such that the additional CPUs remain in deep sleep/HALT
> > mode until the first CPU hits a high-water mark of say 90%
> > utilization?  I've started doing this by hand with the (x)pulse
> > application.   My goal is to save electricity and cut down on
> > excess heat when I'm just browsing the web and not compiling
> > or seti@home'ing.
>
> You'd probably be better off working against load and not CPU usage,
> since a single app can hit you at 100% CPU.  Load average is the sort of
> metric you want, since if there is more than 1 task waiting to run on
> average, you will benefit from multiple CPUs.
>
> That said, this would be easy to do in user space using the hotplug CPU
> patch.  Monitor load average (just like any X applet does) and when it
> crosses over the threshold: "echo 1 > /proc/sys/cpu/2/online"
>
> Another solution would be to use CPU affinity to lock init (and thus all
> tasks) to 0x00000001 or whatever and then start allowing 0x00000002 or
> whatever when load gets too high.
>
> My point: it is awful easy in user space.
>
> 	Robert Love
>

You make good points.  I'll try the hotplug CPU patch to automate things
more than with my simple use of Xpulse, (whose code I could have
used if I wanted to get off my butt and write a useful C application.)


-- 
timothy.covell@ashavan.org.
