Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280041AbRJaCy5>; Tue, 30 Oct 2001 21:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280040AbRJaCys>; Tue, 30 Oct 2001 21:54:48 -0500
Received: from ilm.mech.unsw.EDU.AU ([129.94.171.100]:27143 "EHLO
	ilm.mech.unsw.edu.au") by vger.kernel.org with ESMTP
	id <S280039AbRJaCyl>; Tue, 30 Oct 2001 21:54:41 -0500
Date: Wed, 31 Oct 2001 13:55:07 +1100
To: Kurt Roeckx <Q@ping.be>
Cc: linux-kernel@vger.kernel.org, Ian Maclaine-cross <iml@debian.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011031135507.A9129@ilm.mech.unsw.edu.au>
In-Reply-To: <20011031113312.A8738@ilm.mech.unsw.edu.au> <20011031020538.A354@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011031020538.A354@ping.be>
User-Agent: Mutt/1.3.23i
From: Ian Maclaine-cross <iml@ilm.mech.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 02:05:38AM +0100, Kurt Roeckx wrote:
> On Wed, Oct 31, 2001 at 11:33:12AM +1100, Ian Maclaine-cross wrote:
> > 
> > PROBLEM: Linux updates RTC secretly when clock synchronizes.
> > 
> > When /usr/sbin/ntpd synchronizes the Linux kernel (or system) clock
> > using the Network Time Protocol the kernel time is accurate to a few
> > milliseconds. Linux then sets the Real Time (or Hardware or CMOS)
> > Clock to this time at approximately 11 minute intervals. Typical RTCs
> > drift less than 10 s/day so rebooting causes only millisecond errors.

[snip]

>
> 
> This is all in the manpage, see man hwclock.  If you use ntpd,
> you probably don't want hwclock to adjust, just set the time.
> 
> Kurt
> 

When the machine reboots from a power interruption Internet connection
may be unavailable (usual here). Ntpd can start synchronized to an RTC
but time is inaccurate because hwclock has not adjusted it. When
Internet connection reestablishes ntpd notices the time conflict and
terminates.  Human intervention or cron lines can run ntpdate and then
restart ntpd. This results in time of low quality.

There are lots of high quality and cost hardware solutions.  The
solution in my first post was a very small kernel patch to add an
11 minute update log so hwclock etc could adjust the time.  Any
comments on my patch?


-- 
Regards,
Ian Maclaine-cross (iml@debian.org)
