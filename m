Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312466AbSDSOpq>; Fri, 19 Apr 2002 10:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312526AbSDSOpp>; Fri, 19 Apr 2002 10:45:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8320 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312466AbSDSOpp>; Fri, 19 Apr 2002 10:45:45 -0400
Date: Fri, 19 Apr 2002 10:46:07 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Kent Borg <kentborg@borg.org>
cc: "Dr. Death" <drd@homeworld.ath.cx>, linux-kernel@vger.kernel.org
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
In-Reply-To: <20020419102219.E21727@borg.org>
Message-ID: <Pine.LNX.3.95.1020419103426.855A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2002, Kent Borg wrote:

> On Fri, Apr 19, 2002 at 10:14:41AM -0400, Richard B. Johnson wrote:
> > On Thu, 18 Apr 2002, Dr. Death wrote:
> > 
> > > Problem:
> > > 
> > > I use SuSE Linux 7.2 and when I create md5sums from damaged files on a 
> > > CD, the WHOLE system  freezes or is ugly slow untill md5 has passed the 
> > > damaged part of the file !
> > > 
> > 
> > So what do you suggest? You can see from the logs that the device
> > is having difficulty  reading your damaged CD. You can do what
> > Windows-95 does (ignore the errors and pretend everything is fine),
> > or what Windows-98 and Windows-2000/Prof does (blue-screen, and re-boot),
> > or you can try like hell to read the files like Linux does. What do you
> > suggest?
> 
> You didn't ask me, but I would still suggest that it would be nice if
> the whole system didn't come to a near halt.
> 

Some time-outs are enforced by hardware, some errors even result in
a bus reset in which all the devices reload their firmware, etc.
Therefore time-outs are made quite long so one has to wait for a
relatively long to either retry or to give up upon an error. It
is possible to dynamically determine the kind of time-out necessary
for a particular error in a particular device. This could be
determined, for instance, when a device is mounted or otherwise
first accessed. However, then there would be complaints about
the amount of time necessary to mount a device, etc.

So, basically, the compromise seems to be that bad devices or
bad media result in long-time retries.

Note, if you have another task, that is not trying to use the
errored device or its bus, it does not get starved for CPU time.
The kernel still sleeps while waiting for pass/fail interrupts,
therefore giving the CPU to somebody. Of course this doesn't
help the task that's accessing the device, and to that task the
system seems to, as you say, come to a near halt. 

FYI "Dr. Death" is phony and email to that node gets bounced.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

