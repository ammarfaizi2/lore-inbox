Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286320AbRLTSf7>; Thu, 20 Dec 2001 13:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286318AbRLTSfu>; Thu, 20 Dec 2001 13:35:50 -0500
Received: from svr3.applink.net ([206.50.88.3]:12051 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S286326AbRLTSfm>;
	Thu, 20 Dec 2001 13:35:42 -0500
Message-Id: <200112201835.fBKIZZSr016562@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: linux-kernel@vger.kernel.org
Subject: Fwd: Re: Scheduler, Can we save some juice ...
Date: Thu, 20 Dec 2001 12:31:51 -0600
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



----------  Forwarded Message  ----------

Subject: Re: Scheduler, Can we save some juice ...
Date: Thu, 20 Dec 2001 12:21:17 -0600
From: Timothy Covell <timothy.covell@ashavan.org.>
To: Ryan Cumming <bodnar42@phalynx.dhs.org>

On Thursday 20 December 2001 00:50, Ryan Cumming wrote:
> On December 19, 2001 22:33, Timothy Covell wrote:
> > OK, here's another 0.1% for you.  Considering how Linux SMP
> > doesn't have high CPU affinity, would it be possible to make a
> > patch such that the additional CPUs remain in deep sleep/HALT
> > mode until the first CPU hits a high-water mark of say 90%
> > utilization?  I've started doing this by hand with the (x)pulse
> > application.   My goal is to save electricity and cut down on
> > excess heat when I'm just browsing the web and not compiling
> > or seti@home'ing.
>
> I seriously doubt there would be a noticable power consumption or heat
> difference between two CPU's running HLT half the time, and one CPU running
> HLT all the time. And I'm downright certain it isn't worth the code
> complexity even if it was, there is very little (read: no) intersection
> between the SMP and low-power user base.

I agree that the code complexity issue could be show stopper.  And since
it can be done from user space, that is where I'll go.   I did preface it
with a "0.1% issue"

As concerns the intersection between SMP and low-power user base, I
could imagine a lot of uses if the person or company gave a hoot about
not polluting.    A lot of companies buy dual CPU systems just in case
they might need the extra horse power.  And with new CPUs approaching
100 Watts or more.

Quoting aceshardware.com.:
" the EV7 is designed to run at roughly 1.2 GHz and dissipate 155W in an
0.18-micron process."

I could see this as a big selling point.    "Our OS uses less power, but
stick kicks M$ @$$.   That is how Transmeta's Linux is marketed, and
how the Via C3 and the Transmeta Crusoe CPUS are marketed.

Alas, further research shows that DeepSleep mode doesn't save much
over HALT mode assuming that you're correct when you say that

> I seriously doubt there would be a noticable power consumption or heat
> difference between two CPU's running HLT half the time, and one CPU running
> HLT all the time

Example: PIII at 1 GHz
Normal Mode: 26-30 Watts
StopGrant: 6.9 A * 1.75 VCC = 12.08 W
Deep Sleep: 6.6 A * 1.75 VCC = 11.55 W
Difference = ~ 0.5 Watts

Example: Via C3
Normal Mode: 6-12 Watts
Halt: 1 Watt
Deep Sleep: 0.5 Watts
Difference = ~ 0.5 Watts


--
timothy.covell@ashavan.org.

-------------------------------------------------------

-- 
timothy.covell@ashavan.org.
