Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267432AbUHJFXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267432AbUHJFXT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 01:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267435AbUHJFXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 01:23:19 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:45517 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267432AbUHJFXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 01:23:16 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Albert Cahalan <albert@users.sf.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk, dwmw2@infradead.org,
       schilling@fokus.fraunhofer.de, axboe@suse.de
In-Reply-To: <cone.1092113232.42936.29067.502@pc.kolivas.org>
References: <1092082920.5761.266.camel@cube>
	 <cone.1092092365.461905.29067.502@pc.kolivas.org>
	 <1092099669.5759.283.camel@cube>
	 <cone.1092113232.42936.29067.502@pc.kolivas.org>
Content-Type: text/plain
Organization: 
Message-Id: <1092106283.5761.304.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Aug 2004 22:51:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 00:47, Con Kolivas wrote:
> Albert Cahalan writes:
> > On Mon, 2004-08-09 at 18:59, Con Kolivas wrote:
> >> Albert Cahalan writes:

> >> > Joerg:
> >> >    "WARNING: Cannot do mlockall(2).\n"
> >> >    "WARNING: This causes a high risk for buffer underruns.\n"
> >> > Fixed:
> >> >    "Warning: You don't have permission to lock memory.\n"
> >> >    "         If the computer is not idle, the CD may be ruined.\n"
> >> > 
> >> > Joerg:
> >> >    "WARNING: Cannot set priority class parameters priocntl(PC_SETPARMS)\n"
> >> >    "WARNING: This causes a high risk for buffer underruns.\n"
> >> > Fixed:
> >> >    "Warning: You don't have permission to hog the CPU.\n"
> >> >    "         If the computer is not idle, the CD may be ruined.\n"
> >> 
> >> Huh? That can't be right. Every cd burner this side of the 21st century has 
> >> buffer underrun protection.
> > 
> > I'm pretty sure my FireWire CD-RW/CD-R is from
> > another century. Not that it's unusual in 2004.
> > 
> >> I've burnt cds _while_ capturing and encoding 
> >> video using truckloads of cpu and I/O without superuser privileges, had all 
> >> the cdrecord warnings and didn't have a buffer underrun.
> > 
> > That's cool. My hardware won't come close to that.
> > Burning a coaster costs money.
> > 
> > Let me put it this way: $$ $ $$$ $$ $ $$$ $$ $
> > 
> > The warning, if re-worded, will save people from
> > frustration and wasted money.
> 
> Sounds good; how about something less terrifying? That warning sounds like a 
> ruined cd is likely.

I'm not about to burn CDs trying, but I do believe
that "a ruined cd is likely" would be accurate if I
were to keep busy with Mozilla and such. OpenOffice
would surely ruin a cd. Light web browsing makes my
mp3 player skip.

Not all of us have hardware like you do. Encoding
video is something I wouldn't bother to try, even
without the CD burner going!

(the box isn't that old; it's fanless though)

> >> Last time I gave 
> >> superuser privilege to cdrecord it locked my machine - clearly it wasn't 
> >> rt_task safe.
> > 
> > So, you've been working on the scheduler anyway...
> > An option to reserve some portion of CPU time for
> > emergency use (say, 5% after 1 second has passed)
> > would let somebody get out of this situation.
> 
> This breaks the real time policy entirely. That's why I run it SCHED_ISO ... 
> but of course this isn't available in mainline linux.

Of course it breaks the real time policy entirely.
It would have to be enabled via a sysctl.

The NMI watchdog breaks cli/sti. We have it anyway.
This is the same thing.


