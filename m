Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293687AbSCFRDM>; Wed, 6 Mar 2002 12:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293689AbSCFRDG>; Wed, 6 Mar 2002 12:03:06 -0500
Received: from gate.perex.cz ([194.212.165.105]:25353 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S293687AbSCFRA0>;
	Wed, 6 Mar 2002 12:00:26 -0500
Date: Wed, 6 Mar 2002 17:57:54 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Paul Davis <pbd@op.net>
cc: Ulrich Zadow <ulrich.zadow@ARTCOM.DE>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Timer?
In-Reply-To: <200203061631.LAA17147@renoir.op.net>
Message-ID: <Pine.LNX.4.33.0203061741300.2187-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, Paul Davis wrote:

> >Is there any documentation on the timer api that goes beyond what's on the als
> >a-project pages? We're trying to sync Video and Audio, and all we need is a wa
> >y to query the current time relative to some arbitrary start point.
> 
> i don't believe that the timer API has much to do with this. its more
> a way of getting a trigger from a timer, not of reading time per se.
> 
> to sync audio + video you have to keep track of the number of frames
> you've delivered to both streams. the audio stream is giving you
> exactly the same timing info (albeit implicitly) as it would do if you
> used as a timer.

You're right. But it would be really nice to have a continuous timer 
source in some resolution (microseconds?) available for all platforms
to satisfy synchronization requirements. 

It's not probably required exactly for this example where timing from one
audio target is sufficient, but I can imagine several applications
synchronized together. As far as I know, Linux has not a continous timer.
I am ready to work on this issue. It is very simple to create an interface
with one ioctl returning struct timeval with the absolute timer value
measured from system boot on i386 using rdtsc instruction.

Perhaps, I'm trying to reinvent wheel, so please, let me know, if someone 
solved this issue.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



